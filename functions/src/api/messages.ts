// functions/src/api/messages.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { callGpt } from "../ai/providers/gpt";

const router = Router();

// ============================================================
// POST /messages/generate — generate an AI message using GPT-4o-mini
// ============================================================
router.post("/generate", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const {
      mode,
      tone,
      length,
      language,
      includePartnerName,
      contextText,
      humorLevel,
    } = req.body;

    if (!mode || !tone) {
      throw new AppError(400, "MISSING_FIELDS", "mode and tone are required");
    }

    // Get partner name from user profile
    const userDoc = await db.collection("users").doc(uid).get();
    const userData = userDoc.data() || {};
    const partnerName = userData.partnerNickname || userData.partnerName || "her";
    const userName = userData.displayName || "King";

    const msgLength = length || "medium";
    const msgLanguage = language || req.locale || "en";
    const humor = humorLevel || 50;

    const lengthGuide = msgLength === "short" ? "1-2 sentences" :
      msgLength === "long" ? "4-6 sentences" : "2-3 sentences";

    const languageInstruction = msgLanguage === "ar"
      ? "Write the message in Arabic."
      : msgLanguage === "ms"
        ? "Write the message in Malay."
        : "Write the message in English.";

    const systemPrompt = `You are LOLO, an AI relationship coach helping men communicate better with their partners. Generate a ${mode} message with a ${tone} tone.

Rules:
- Write ONLY the message text, no quotes, no labels, no explanations
- ${lengthGuide}
- Humor level: ${humor}/100 (0=serious, 100=very funny)
- ${includePartnerName !== false ? `Use the partner's name "${partnerName}" naturally in the message` : "Do NOT include any name"}
- Be authentic, emotionally intelligent, and culturally sensitive
- ${languageInstruction}
- Never be generic or cliché — make it feel personal and real`;

    const userPrompt = contextText
      ? `Generate a ${mode} message. Additional context: ${contextText}`
      : `Generate a ${mode} message for my partner.`;

    const startTime = Date.now();
    const result = await callGpt("gpt-4o-mini", systemPrompt, userPrompt, 500);
    const latencyMs = Date.now() - startTime;

    const messageId = uuidv4();
    const now = new Date().toISOString();

    const messageData = {
      mode,
      tone,
      length: msgLength,
      language: msgLanguage,
      content: result.content,
      isFavorite: false,
      rating: 0,
      status: "generated",
      metadata: {
        modelUsed: "gpt-4o-mini",
        tokensUsed: result.tokensUsed,
        latencyMs,
        cached: false,
      },
      createdAt: now,
      updatedAt: now,
    };

    await db
      .collection("users")
      .doc(uid)
      .collection("messages")
      .doc(messageId)
      .set(messageData);

    res.status(201).json({
      data: {
        id: messageId,
        content: result.content,
        mode,
        tone,
        length: msgLength,
        languageCode: msgLanguage,
        modelBadge: "GPT-4o mini",
        isFavorite: false,
        rating: 0,
        includePartnerName: includePartnerName !== false,
        createdAt: now,
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// GET /messages/history — returns message history with pagination
// ============================================================
router.get("/history", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { mode, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(uid)
      .collection("messages")
      .orderBy("createdAt", "desc");

    if (mode) {
      query = query.where("mode", "==", mode);
    }

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(uid)
        .collection("messages")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    const snapshot = await query.limit(limit + 1).get();
    const hasMore = snapshot.docs.length > limit;
    const docs = hasMore ? snapshot.docs.slice(0, limit) : snapshot.docs;

    const messages = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        mode: d.mode,
        tone: d.tone,
        content: d.content,
        language: d.language,
        feedbackRating: d.feedbackRating || null,
        createdAt: d.createdAt,
      };
    });

    const response = {
      data: messages,
      pagination: {
        hasMore,
        lastDocId: docs.length > 0 ? docs[docs.length - 1].id : null,
        count: messages.length,
      },
    };

    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /messages/:id/feedback — saves feedback rating for a message
// ============================================================
router.post("/:id/feedback", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const messageId = req.params.id;
    const { rating, comment } = req.body;

    if (rating === undefined || rating === null) {
      throw new AppError(400, "MISSING_FIELDS", "rating is required");
    }

    if (typeof rating !== "number" || rating < 1 || rating > 5) {
      throw new AppError(400, "INVALID_RATING", "rating must be a number between 1 and 5");
    }

    const messageRef = db
      .collection("users")
      .doc(uid)
      .collection("messages")
      .doc(messageId);

    const messageDoc = await messageRef.get();
    if (!messageDoc.exists) {
      throw new AppError(404, "MESSAGE_NOT_FOUND", "Message not found");
    }

    await messageRef.update({
      feedbackRating: rating,
      feedbackComment: comment || null,
      feedbackAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    });

    res.json({
      data: {
        messageId,
        rating,
        comment: comment || null,
        feedbackAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

export default router;
