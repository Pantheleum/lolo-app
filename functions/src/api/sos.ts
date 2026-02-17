// functions/src/api/sos.ts
import { Router, Response, NextFunction } from "express";
import { db, redis, CONFIG } from "../config";
import { AuthenticatedRequest, AppError, SubscriptionTier } from "../types";
import { requireFeature, enforceLimit } from "../middleware/tierEnforcement";
import { getTierFromFirestore, incrementUsage } from "../services/subscriptionService";
import { awardXp } from "../services/gamificationService";
import { encrypt, decrypt } from "../services/encryptionService";
import { v4 as uuidv4 } from "uuid";
import * as functions from "firebase-functions";

const router = Router();

// POST /sos/activate — tier check: Pro+
router.post(
  "/activate",
  requireFeature("sos_mode"),
  enforceLimit("sosSessions"),
  async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const uid = req.user.uid;
      const { scenario, urgency, partnerProfileId } = req.body;

      if (!scenario || !urgency) {
        throw new AppError(400, "MISSING_FIELDS", "scenario and urgency are required");
      }

      const sessionId = uuidv4();
      const encryptedScenario = encrypt(scenario);

      await db.collection("users").doc(uid).collection("sosSessions").doc(sessionId).set({
        scenario: encryptedScenario,
        urgency,
        severity: null,
        status: "active",
        coachingMessages: [],
        partnerProfileId: partnerProfileId || null,
        stepsCompleted: 0,
        modelUsed: null,
        duration: 0,
        createdAt: new Date(),
      });

      await incrementUsage(uid, "sosSessions");

      res.status(201).json({
        sessionId,
        status: "active",
        message: "SOS session activated. Proceed to /assess for situation analysis.",
      });
    } catch (err) {
      next(err);
    }
  }
);

// POST /sos/assess
router.post("/assess", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, answers } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");
    if (sessionDoc.data()!.status !== "active") throw new AppError(409, "SESSION_INACTIVE", "Session is no longer active");

    // Score severity from answers
    const severityScore = calculateSeverity(answers || {});
    const severityLabel = severityScore >= 8 ? "critical" : severityScore >= 5 ? "high" : severityScore >= 3 ? "medium" : "low";

    await sessionRef.update({
      severity: severityLabel,
      severityScore,
      assessmentAnswers: answers,
      assessedAt: new Date(),
      updatedAt: new Date(),
    });

    res.json({
      sessionId,
      severity: severityLabel,
      severityScore,
      recommendedApproach: getApproachForSeverity(severityLabel),
    });
  } catch (err) {
    next(err);
  }
});

function calculateSeverity(answers: Record<string, any>): number {
  let score = 0;
  if (answers.sheIsCrying) score += 3;
  if (answers.sheIsAngry) score += 2;
  if (answers.sheIsSilent) score += 2;
  if (answers.involvesFamily) score += 2;
  if (answers.isPublic) score += 1;
  if (answers.urgency === "happening_now") score += 2;
  else if (answers.urgency === "just_happened") score += 1;
  return Math.min(score, 10);
}

function getApproachForSeverity(severity: string) {
  const approaches: Record<string, object> = {
    critical: { steps: 5, tone: "calm_urgent", includeScript: true, priorityModel: true },
    high: { steps: 4, tone: "empathetic", includeScript: true, priorityModel: true },
    medium: { steps: 3, tone: "supportive", includeScript: false, priorityModel: false },
    low: { steps: 2, tone: "encouraging", includeScript: false, priorityModel: false },
  };
  return approaches[severity] || approaches.medium;
}

// POST /sos/coach — SSE streaming
router.post("/coach", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, userMessage, step } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");

    const session = sessionDoc.data()!;
    if (session.status !== "active") throw new AppError(409, "SESSION_INACTIVE", "Session is no longer active");
    if ((session.stepsCompleted || 0) >= CONFIG.MAX_SOS_STEPS) {
      throw new AppError(409, "MAX_STEPS_REACHED", "Maximum coaching steps reached");
    }

    // SSE headers
    res.setHeader("Content-Type", "text/event-stream");
    res.setHeader("Cache-Control", "no-cache");
    res.setHeader("Connection", "keep-alive");
    res.setHeader("X-Accel-Buffering", "no");

    // Add user message to transcript
    const userMsg = { role: "user", text: userMessage || "", timestamp: new Date() };

    // Build AI prompt from session context
    const partnerDoc = session.partnerProfileId
      ? await db.collection("users").doc(uid).collection("partnerProfiles").doc(session.partnerProfileId).get()
      : null;

    const prompt = buildSOSPrompt(session, userMessage, partnerDoc?.data(), step);

    // Stream AI response via AI router
    const aiRouterUrl = process.env.AI_ROUTER_INTERNAL_URL || "http://localhost:5001/api/v1/ai/route";
    const tier = await getTierFromFirestore(uid);
    const aiResponse = await fetch(aiRouterUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-Internal-Key": process.env.INTERNAL_API_KEY || "" },
      body: JSON.stringify({
        requestId: uuidv4(),
        userId: uid,
        tier,
        requestType: "sos_coaching",
        parameters: { tone: "empathetic", length: "medium", language: req.user.language },
        context: { prompt, severity: session.severity, step },
        stream: true,
      }),
    });

    if (!aiResponse.ok || !aiResponse.body) {
      res.write(`data: ${JSON.stringify({ error: "AI service unavailable" })}\n\n`);
      res.end();
      return;
    }

    let fullResponse = "";
    const reader = aiResponse.body.getReader();
    const decoder = new TextDecoder();

    // eslint-disable-next-line no-constant-condition
    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      const chunk = decoder.decode(value, { stream: true });
      fullResponse += chunk;
      res.write(`data: ${JSON.stringify({ chunk, done: false })}\n\n`);
    }

    res.write(`data: ${JSON.stringify({ chunk: "", done: true })}\n\n`);
    res.end();

    // Update session transcript
    const aiMsg = { role: "ai", text: fullResponse, timestamp: new Date() };
    await sessionRef.update({
      coachingMessages: [...(session.coachingMessages || []), userMsg, aiMsg],
      stepsCompleted: (session.stepsCompleted || 0) + 1,
      modelUsed: "ai_router",
      updatedAt: new Date(),
    });
  } catch (err) {
    if (!res.headersSent) return next(err);
    functions.logger.error("SSE coaching error", err);
    res.end();
  }
});

function buildSOSPrompt(session: any, userMessage: string, partner: any, step: number): string {
  const scenario = decrypt(session.scenario);
  const history = (session.coachingMessages || []).map((m: any) => `${m.role}: ${m.text}`).join("\n");
  return [
    `SOS Coaching - Step ${step || 1}`,
    `Scenario: ${scenario}`,
    `Severity: ${session.severity}`,
    partner ? `Partner: ${partner.name}, Style: ${partner.communicationStyle}` : "",
    history ? `History:\n${history}` : "",
    `User says: ${userMessage}`,
    "Provide empathetic, actionable coaching. Be concise. Suggest what to say or do next.",
  ].filter(Boolean).join("\n");
}

// POST /sos/complete
router.post("/complete", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, resolution, saveToMemoryVault } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");

    const session = sessionDoc.data()!;
    const durationSec = Math.floor((Date.now() - session.createdAt.toDate().getTime()) / 1000);

    await sessionRef.update({
      status: "completed",
      resolution: resolution || "resolved",
      duration: durationSec,
      endedAt: new Date(),
      updatedAt: new Date(),
    });

    // Award XP
    const xpResult = await awardXp(uid, "sos_resolved", 25);

    // Save to Memory Vault if requested
    let memoryId: string | null = null;
    if (saveToMemoryVault) {
      memoryId = uuidv4();
      const scenario = decrypt(session.scenario);
      await db.collection("users").doc(uid).collection("memories").doc(memoryId).set({
        title: `SOS: ${scenario.slice(0, 50)}`,
        content: `Resolved ${session.severity} situation. ${resolution || ""}`.trim(),
        category: "milestone",
        tags: ["sos", session.severity],
        sheSaid: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }

    res.json({
      sessionId,
      status: "completed",
      durationSec,
      xpAwarded: 25,
      totalXp: xpResult.newTotalXp,
      levelUp: xpResult.levelUp,
      newBadges: xpResult.badgeEarned,
      memoryId,
    });
  } catch (err) {
    next(err);
  }
});

export default router;
