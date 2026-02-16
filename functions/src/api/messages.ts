// functions/src/api/messages.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

const router = Router();

// ============================================================
// POST /messages/generate — generate an AI message (placeholder)
// ============================================================
router.post("/generate", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const {
      mode,
      tone,
      length,
      language,
      partnerProfileId,
      customContext,
    } = req.body;

    if (!mode || !tone) {
      throw new AppError(400, "MISSING_FIELDS", "mode and tone are required");
    }

    const messageId = uuidv4();
    const now = new Date().toISOString();

    // TODO: Call AI router for real message generation
    // For now, store the request and return a placeholder
    const messageData = {
      mode,
      tone,
      length: length || "medium",
      language: language || req.locale || "en",
      partnerProfileId: partnerProfileId || null,
      customContext: customContext || null,
      content: `[AI-generated ${mode} message placeholder]`,
      alternatives: [] as string[],
      status: "generated",
      feedbackRating: null,
      feedbackComment: null,
      metadata: {
        modelUsed: "placeholder",
        tokensUsed: { input: 0, output: 0 },
        latencyMs: 0,
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

    // Invalidate history cache
    const cacheKeys = await redis.keys(`messages:history:${uid}:*`);
    if (cacheKeys.length > 0) await redis.del(...cacheKeys);

    res.status(201).json({
      data: {
        id: messageId,
        content: messageData.content,
        alternatives: messageData.alternatives,
        mode,
        tone,
        language: messageData.language,
        metadata: messageData.metadata,
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

    const cacheKey = `messages:history:${uid}:${mode || "all"}:${lastDocId || "start"}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

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

    await redis.setex(cacheKey, 120, JSON.stringify(response));
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

    // Invalidate history cache
    const cacheKeys = await redis.keys(`messages:history:${uid}:*`);
    if (cacheKeys.length > 0) await redis.del(...cacheKeys);

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
