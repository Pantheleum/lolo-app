// functions/src/api/sos.ts
import { Router, Response, NextFunction } from "express";
import { db, CONFIG } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { awardXp } from "../services/gamificationService";
import { callGpt } from "../ai/providers/gpt";
import { v4 as uuidv4 } from "uuid";
import * as functions from "firebase-functions";

const router = Router();

// ============================================================
// POST /sos/activate — Start an SOS session with immediate advice
// ============================================================
router.post(
  "/activate",
  async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const uid = req.user.uid;
      const { scenario, urgency } = req.body;

      console.log("[SOS] Activate request:", JSON.stringify(req.body));

      if (!scenario || !urgency) {
        throw new AppError(400, "MISSING_FIELDS", "scenario and urgency are required");
      }

      // Get user profile for context
      const userDoc = await db.collection("users").doc(uid).get();
      const userData = userDoc.data() || {};
      const partnerName = userData.partnerNickname || userData.partnerName || "her";

      const sessionId = uuidv4();

      // Generate immediate advice using GPT
      const immediateAdvice = await generateImmediateAdvice(scenario, urgency, partnerName);

      await db.collection("users").doc(uid).collection("sosSessions").doc(sessionId).set({
        scenario,
        urgency,
        severity: null,
        status: "active",
        coachingMessages: [],
        stepsCompleted: 0,
        modelUsed: "gpt-4o-mini",
        duration: 0,
        immediateAdvice,
        createdAt: new Date(),
      });

      const now = new Date().toISOString();

      console.log("[SOS] Session created:", sessionId, "| Advice:", JSON.stringify(immediateAdvice).substring(0, 200));

      res.status(201).json({
        data: {
          sessionId,
          scenario,
          urgency,
          immediateAdvice,
          severityAssessmentRequired: true,
          estimatedResolutionSteps: 5,
          createdAt: now,
        },
      });
    } catch (err) {
      next(err);
    }
  }
);

// ============================================================
// POST /sos/assess — Score severity and return coaching plan
// ============================================================
router.post("/assess", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, howLongAgo, herCurrentState, isYourFault, whatHappened, additionalContext } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");
    if (sessionDoc.data()!.status !== "active") throw new AppError(409, "SESSION_INACTIVE", "Session is no longer active");

    const answers: Record<string, any> = { howLongAgo, herCurrentState, isYourFault, whatHappened };
    if (additionalContext !== undefined && additionalContext !== null) {
      answers.additionalContext = additionalContext;
    }

    // Score severity from answers
    const severityScore = calculateSeverity(answers);
    const severityLabel = severityScore >= 8 ? "critical" : severityScore >= 5 ? "high" : severityScore >= 3 ? "moderate" : "low";

    // Build coaching plan based on severity
    const coachingPlan = buildCoachingPlan(severityLabel, sessionDoc.data()!.scenario, whatHappened);

    await sessionRef.update({
      severity: severityLabel,
      severityScore,
      assessmentAnswers: answers,
      coachingPlan,
      assessedAt: new Date(),
      updatedAt: new Date(),
    });

    res.json({
      data: {
        sessionId,
        severityScore,
        severityLabel,
        coachingPlan,
      },
    });
  } catch (err) {
    next(err);
  }
});

// ============================================================
// GET /sos/coach — SSE streaming coaching steps
// ============================================================
router.get("/coach", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const sessionId = req.query.sessionId as string;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");

    const session = sessionDoc.data()!;
    if (session.status !== "active") throw new AppError(409, "SESSION_INACTIVE", "Session is no longer active");

    // SSE headers
    res.setHeader("Content-Type", "text/event-stream");
    res.setHeader("Cache-Control", "no-cache");
    res.setHeader("Connection", "keep-alive");
    res.setHeader("X-Accel-Buffering", "no");

    // Get user profile for context
    const userDoc = await db.collection("users").doc(uid).get();
    const userData = userDoc.data() || {};
    const partnerName = userData.partnerNickname || userData.partnerName || "her";
    const nationality = userData.partnerNationality || userData.nationality || "";
    const language = userData.language || "en";

    // Generate structured coaching steps using GPT
    const coachingPlan = session.coachingPlan || { totalSteps: 3 };
    const totalSteps = coachingPlan.totalSteps || 3;

    // Build language instruction for "sayThis" field
    const sayThisLanguageInstruction = buildSayThisLanguageInstruction(language, nationality);

    const systemPrompt = `You are LOLO, an expert relationship crisis coach. You help men navigate difficult situations with their partners in real-time.

You must respond with a JSON array of exactly ${totalSteps} coaching steps. Each step must have this exact structure:
{
  "stepNumber": <number>,
  "totalSteps": ${totalSteps},
  "sayThis": "<exact words to say to her>",
  "whyItWorks": "<brief explanation of why this approach works psychologically>",
  "doNotSay": ["<thing to avoid saying 1>", "<thing to avoid saying 2>"],
  "bodyLanguageTip": "<specific body language advice>",
  "toneAdvice": "<how to deliver these words>",
  "waitFor": "<what to wait for before moving to next step, or null>",
  "isLastStep": <true only for the final step>,
  "nextStepPrompt": "<what to do next, or null for last step>"
}

Rules:
- Write ONLY the JSON array, no other text
- The "sayThis" should be natural, authentic words — not scripted or robotic
- Tailor advice to the specific situation and severity
- Be culturally sensitive${nationality ? ` (partner is ${nationality})` : ""}
- The partner's name is "${partnerName}" — use it naturally in suggestions
- Each step should build on the previous one
- Include specific body language tips (eye contact, posture, touch)
- The tone advice should match the emotional state
${sayThisLanguageInstruction}`;

    const userPrompt = `Crisis situation:
- Scenario: ${session.scenario}
- Severity: ${session.severity || "moderate"}
- How long ago: ${session.assessmentAnswers?.howLongAgo || "unknown"}
- Her current state: ${session.assessmentAnswers?.herCurrentState || "unknown"}
- Is it his fault: ${session.assessmentAnswers?.isYourFault ? "Yes" : "No"}
- What happened: ${session.assessmentAnswers?.whatHappened || session.scenario}
${session.assessmentAnswers?.additionalContext ? `- Additional context: ${session.assessmentAnswers.additionalContext}` : ""}

Generate ${totalSteps} coaching steps to help him resolve this situation.`;

    try {
      const result = await callGpt("gpt-4o-mini", systemPrompt, userPrompt, 2000);

      // Parse the JSON array from GPT response
      let steps: any[];
      try {
        // Try to extract JSON from the response (handle markdown code blocks)
        let jsonStr = result.content.trim();
        if (jsonStr.startsWith("```")) {
          jsonStr = jsonStr.replace(/^```(?:json)?\n?/, "").replace(/\n?```$/, "");
        }
        steps = JSON.parse(jsonStr);
      } catch (parseErr) {
        functions.logger.error("Failed to parse coaching steps JSON", parseErr, result.content);
        // Fallback: create a single coaching step from the raw text
        steps = [{
          stepNumber: 1,
          totalSteps: 1,
          sayThis: result.content.slice(0, 200),
          whyItWorks: "Taking a thoughtful, empathetic approach shows you care.",
          doNotSay: ["Don't get defensive", "Don't dismiss her feelings"],
          bodyLanguageTip: "Maintain gentle eye contact, open posture, lean in slightly",
          toneAdvice: "Speak softly and slowly. Let her hear the sincerity in your voice.",
          waitFor: null,
          isLastStep: true,
          nextStepPrompt: null,
        }];
      }

      // Stream each step as an SSE event
      for (const step of steps) {
        step.sessionId = sessionId;
        res.write(`data: ${JSON.stringify(step)}\n\n`);
        // Small delay between steps for natural pacing
        await new Promise((resolve) => setTimeout(resolve, 500));
      }

      res.write("data: [DONE]\n\n");
      res.end();

      // Save coaching steps to Firestore
      await sessionRef.update({
        coachingMessages: steps,
        stepsCompleted: steps.length,
        modelUsed: "gpt-4o-mini",
        updatedAt: new Date(),
      });
    } catch (aiErr) {
      functions.logger.error("AI coaching error", aiErr);
      res.write(`data: ${JSON.stringify({ error: "AI service temporarily unavailable. Please try again." })}\n\n`);
      res.end();
    }
  } catch (err) {
    if (!res.headersSent) return next(err);
    functions.logger.error("SSE coaching error", err);
    res.end();
  }
});

// ============================================================
// PUT /sos/:id — Finish an SOS session
// ============================================================
router.put("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const sessionId = req.params.id;
    const { rating, resolution, saveToMemoryVault } = req.body;

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");

    const session = sessionDoc.data()!;
    const durationSec = Math.floor((Date.now() - session.createdAt.toDate().getTime()) / 1000);

    await sessionRef.update({
      status: "completed",
      rating: rating || null,
      resolution: resolution || "resolved",
      duration: durationSec,
      endedAt: new Date(),
      updatedAt: new Date(),
    });

    // Award XP
    let xpResult;
    try {
      xpResult = await awardXp(uid, "sos_resolved", 25);
    } catch (xpErr) {
      functions.logger.error("XP award failed", xpErr);
      xpResult = { newTotalXp: 0, levelUp: false, badgeEarned: null };
    }

    // Save to Memory Vault if requested
    let memoryId: string | null = null;
    if (saveToMemoryVault) {
      memoryId = uuidv4();
      await db.collection("users").doc(uid).collection("memories").doc(memoryId).set({
        title: `SOS: ${(session.scenario || "Crisis").slice(0, 50)}`,
        content: `Resolved ${session.severity || "unknown"} situation. ${resolution || ""}`.trim(),
        category: "milestone",
        tags: ["sos", session.severity || "resolved"],
        sheSaid: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }

    res.json({
      data: {
        sessionId,
        status: "completed",
        durationSec,
        rating,
        xpAwarded: 25,
        totalXp: xpResult.newTotalXp,
        levelUp: xpResult.levelUp,
        newBadges: xpResult.badgeEarned,
        memoryId,
      },
    });
  } catch (err) {
    next(err);
  }
});

// ============================================================
// Helper: Generate immediate advice using GPT
// ============================================================
async function generateImmediateAdvice(
  scenario: string,
  urgency: string,
  partnerName: string
): Promise<{ doNow: string; doNotDo: string; bodyLanguage: string }> {
  try {
    const systemPrompt = `You are LOLO, an expert relationship crisis coach. Generate immediate crisis advice in JSON format.
Respond with ONLY a JSON object (no other text) with these exact keys:
{
  "doNow": "<one specific action to take RIGHT NOW, max 2 sentences>",
  "doNotDo": "<one thing to absolutely NOT do, max 2 sentences>",
  "bodyLanguage": "<one specific body language tip, max 1 sentence>"
}

Rules:
- Be specific and actionable, not generic
- Tailor to the exact scenario and urgency
- Her name is "${partnerName}"
- Sound like a real coach, not a textbook`;

    const userPrompt = `Scenario: ${scenario}, Urgency: ${urgency}. Give immediate advice.`;

    const result = await callGpt("gpt-4o-mini", systemPrompt, userPrompt, 200);

    let jsonStr = result.content.trim();
    if (jsonStr.startsWith("```")) {
      jsonStr = jsonStr.replace(/^```(?:json)?\n?/, "").replace(/\n?```$/, "");
    }

    const parsed = JSON.parse(jsonStr);
    return {
      doNow: parsed.doNow || "Stay calm and listen. Don't react immediately.",
      doNotDo: parsed.doNotDo || "Don't raise your voice or get defensive.",
      bodyLanguage: parsed.bodyLanguage || "Face her, maintain soft eye contact, and keep your hands visible.",
    };
  } catch (err) {
    functions.logger.error("Failed to generate immediate advice", err);
    // Fallback advice
    return getDefaultAdvice(scenario);
  }
}

function getDefaultAdvice(scenario: string): { doNow: string; doNotDo: string; bodyLanguage: string } {
  const defaults: Record<string, { doNow: string; doNotDo: string; bodyLanguage: string }> = {
    sheIsAngry: {
      doNow: "Stay calm and let her express herself. Don't interrupt.",
      doNotDo: "Don't raise your voice, roll your eyes, or walk away.",
      bodyLanguage: "Face her, keep your hands relaxed and visible. Don't cross your arms.",
    },
    sheIsCrying: {
      doNow: "Sit close to her. Ask gently if you can hold her hand or give her a hug.",
      doNotDo: "Don't tell her to stop crying or say 'calm down'. Let her feel.",
      bodyLanguage: "Sit beside her, not across. Lean in. Offer a tissue.",
    },
    sheIsSilent: {
      doNow: "Give her space but stay present. Say 'I'm here when you're ready to talk.'",
      doNotDo: "Don't push her to talk or pretend everything is fine.",
      bodyLanguage: "Stay in the room. Put your phone down. Show you're available.",
    },
    forgotImportantDate: {
      doNow: "Acknowledge it immediately. Say 'I messed up and I'm sorry.'",
      doNotDo: "Don't make excuses or minimize it. Don't blame your schedule.",
      bodyLanguage: "Look her in the eyes when apologizing. Hold her hand if she lets you.",
    },
    saidWrongThing: {
      doNow: "Acknowledge what you said was hurtful. Say 'I shouldn't have said that.'",
      doNotDo: "Don't say 'you're overreacting' or try to justify what you said.",
      bodyLanguage: "Face her directly. Lower your voice. Show genuine remorse.",
    },
  };

  return defaults[scenario] || {
    doNow: "Take a breath. Be fully present with her right now.",
    doNotDo: "Don't get defensive or dismissive.",
    bodyLanguage: "Face her, maintain gentle eye contact, put your phone away.",
  };
}

// ============================================================
// Helper: Calculate severity score from assessment answers
// ============================================================
function calculateSeverity(answers: Record<string, any>): number {
  let score = 0;

  // Her current state (0-4 points)
  const state = (answers.herCurrentState || "").toLowerCase();
  if (state.includes("yelling") || state.includes("furious")) score += 4;
  else if (state.includes("crying")) score += 3;
  else if (state.includes("cold") || state.includes("silent")) score += 3;
  else if (state.includes("hurt")) score += 2;
  else if (state.includes("disappointed")) score += 2;
  else if (state.includes("confused")) score += 1;
  else if (state.includes("calm")) score += 1;

  // How long ago (0-3 points)
  const timing = (answers.howLongAgo || "").toLowerCase();
  if (timing.includes("right now")) score += 3;
  else if (timing.includes("few minutes")) score += 2;
  else if (timing.includes("within the hour")) score += 2;
  else if (timing.includes("earlier today")) score += 1;
  else if (timing.includes("yesterday")) score += 0;

  // Is your fault (0-2 points)
  if (answers.isYourFault === true) score += 2;

  // What happened length = complexity indicator (0-1 point)
  if (answers.whatHappened && answers.whatHappened.length > 100) score += 1;

  return Math.min(score, 10);
}

// ============================================================
// Helper: Build coaching plan from severity
// ============================================================
function buildCoachingPlan(severity: string, scenario: string, whatHappened: string) {
  const plans: Record<string, { totalSteps: number; estimatedMinutes: number; approach: string }> = {
    critical: { totalSteps: 5, estimatedMinutes: 20, approach: "Immediate de-escalation, then careful reconnection" },
    high: { totalSteps: 4, estimatedMinutes: 15, approach: "Empathetic acknowledgment, then guided resolution" },
    moderate: { totalSteps: 3, estimatedMinutes: 10, approach: "Understanding-first approach with clear communication" },
    low: { totalSteps: 2, estimatedMinutes: 5, approach: "Quick reconnection through genuine attention" },
  };

  const plan = plans[severity] || plans.moderate;

  // Generate a key insight based on scenario
  const insights: Record<string, string> = {
    sheIsAngry: "When she's angry, she needs to feel heard before she can hear you.",
    sheIsCrying: "Her tears aren't about making you feel guilty — she's processing pain.",
    sheIsSilent: "Silence is her way of protecting herself. Patience is your strongest tool.",
    caughtInLie: "Trust is broken. Actions will rebuild it, not words alone.",
    forgotImportantDate: "It's not about the date — it's about feeling valued and remembered.",
    saidWrongThing: "Words can wound deeply. Your genuine regret is the first step to healing.",
    sheWantsToTalk: "She's opening a door. Walk through it with full attention.",
    herFamilyConflict: "Family matters are sensitive. Take her side while being diplomatic.",
    jealousyIssue: "Jealousy comes from fear of losing you. Reassurance is key.",
  };

  return {
    ...plan,
    keyInsight: insights[scenario] || "Every crisis is an opportunity to show how much you care.",
  };
}

// ============================================================
// Helper: Build language instruction for "sayThis" field
// ============================================================
function buildSayThisLanguageInstruction(language: string, nationality: string): string {
  if (language === "ar") {
    // Determine Arabic dialect from nationality
    const gulfCountries = ["saudi", "saudi arabia", "uae", "emirates", "qatar", "bahrain", "kuwait", "oman"];
    const levantCountries = ["jordan", "lebanon", "syria", "palestine", "palestinian"];
    const northAfrica = ["egypt", "egyptian", "morocco", "moroccan", "tunisia", "tunisian", "algeria", "algerian", "libya", "libyan"];

    const nat = (nationality || "").toLowerCase();
    let dialect = "Modern Standard Arabic";

    if (gulfCountries.some(c => nat.includes(c))) {
      dialect = "Gulf Arabic (Khaleeji)";
    } else if (levantCountries.some(c => nat.includes(c))) {
      dialect = "Levantine Arabic (Shami)";
    } else if (northAfrica.some(c => nat.includes(c))) {
      if (nat.includes("egypt")) dialect = "Egyptian Arabic (Masri)";
      else dialect = "North African Arabic (Darija)";
    }

    return `- CRITICAL: The "sayThis" field MUST be written in ARABIC SCRIPT using ${dialect}. The "sayThis" is what the user will say to his partner, so it must be in her language. All other fields (whyItWorks, doNotSay, bodyLanguageTip, toneAdvice, etc.) should remain in English.`;
  }

  if (language === "ms") {
    const isIndonesian = (nationality || "").toLowerCase().includes("indonesia");
    const dialect = isIndonesian ? "Bahasa Indonesia" : "Bahasa Melayu";
    return `- CRITICAL: The "sayThis" field MUST be written in ${dialect}. The "sayThis" is what the user will say to his partner, so it must be in her language. All other fields (whyItWorks, doNotSay, bodyLanguageTip, toneAdvice, etc.) should remain in English.`;
  }

  // English — no special instruction needed
  return "";
}

export default router;
