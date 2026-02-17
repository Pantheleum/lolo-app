// functions/src/api/gifts.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

const router = Router();

// ============================================================
// GET /gifts/categories — browse gift suggestions with filters
// ============================================================
router.get("/categories", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { page, pageSize, category, search, lowBudget } = req.query;
    const limit = Math.min(parseInt(pageSize as string) || 20, 50);

    console.log("[GIFTS] Browse request:", { category, page, pageSize, search });

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(uid)
      .collection("giftSuggestions")
      .orderBy("createdAt", "desc");

    if (category) {
      query = query.where("category", "==", category);
    }

    const snapshot = await query.limit(limit).get();

    const gifts = snapshot.docs.flatMap((doc) => {
      const d = doc.data();
      const suggestions = d.suggestions || [];
      return suggestions.map((s: any) => ({
        id: s.id || doc.id,
        title: s.title || "Gift suggestion",
        description: s.description || "",
        estimatedPrice: s.estimatedPrice || d.budget || null,
        category: s.category || d.occasion || "general",
        matchScore: s.matchScore || 0,
        occasion: d.occasion || "",
        currency: d.currency || "USD",
        createdAt: d.createdAt,
      }));
    });

    res.json({ data: gifts });
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /gifts/suggest — suggest gifts (placeholder for AI)
// ============================================================
router.post("/suggest", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const {
      occasion,
      budget,
      currency,
      partnerProfileId,
      interests,
      preferences,
    } = req.body;

    if (!occasion) {
      throw new AppError(400, "MISSING_FIELDS", "occasion is required");
    }

    const suggestionId = uuidv4();
    const now = new Date().toISOString();

    // TODO: Call AI router for real gift suggestions
    // For now, store the request and return placeholder suggestions
    const suggestionData = {
      occasion,
      budget: budget || null,
      currency: currency || "USD",
      partnerProfileId: partnerProfileId || null,
      interests: interests || [],
      preferences: preferences || null,
      suggestions: [
        {
          id: uuidv4(),
          title: `[Placeholder gift for ${occasion}]`,
          description: "AI-generated gift suggestion placeholder",
          estimatedPrice: budget || null,
          category: "general",
          matchScore: 0.85,
        },
      ],
      feedbackRating: null,
      feedbackComment: null,
      metadata: {
        modelUsed: "placeholder",
        latencyMs: 0,
      },
      createdAt: now,
      updatedAt: now,
    };

    await db
      .collection("users")
      .doc(uid)
      .collection("giftSuggestions")
      .doc(suggestionId)
      .set(suggestionData);

    // Invalidate history cache
    const cacheKeys = await redis.keys(`gifts:history:${uid}:*`);
    if (cacheKeys.length > 0) await redis.del(...cacheKeys);

    res.status(201).json({
      data: {
        id: suggestionId,
        occasion,
        suggestions: suggestionData.suggestions,
        metadata: suggestionData.metadata,
        createdAt: now,
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// GET /gifts/history — returns gift suggestion history
// ============================================================
router.get("/history", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { occasion, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    const cacheKey = `gifts:history:${uid}:${occasion || "all"}:${lastDocId || "start"}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(uid)
      .collection("giftSuggestions")
      .orderBy("createdAt", "desc");

    if (occasion) {
      query = query.where("occasion", "==", occasion);
    }

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(uid)
        .collection("giftSuggestions")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    const snapshot = await query.limit(limit + 1).get();
    const hasMore = snapshot.docs.length > limit;
    const docs = hasMore ? snapshot.docs.slice(0, limit) : snapshot.docs;

    const gifts = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        occasion: d.occasion,
        budget: d.budget || null,
        currency: d.currency,
        suggestions: d.suggestions || [],
        feedbackRating: d.feedbackRating || null,
        createdAt: d.createdAt,
      };
    });

    const response = {
      data: gifts,
      pagination: {
        hasMore,
        lastDocId: docs.length > 0 ? docs[docs.length - 1].id : null,
        count: gifts.length,
      },
    };

    await redis.setex(cacheKey, 120, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /gifts/:id/feedback — saves feedback for a gift suggestion
// ============================================================
router.post("/:id/feedback", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const suggestionId = req.params.id;
    const { rating, comment, selectedGiftId } = req.body;

    if (rating === undefined || rating === null) {
      throw new AppError(400, "MISSING_FIELDS", "rating is required");
    }

    if (typeof rating !== "number" || rating < 1 || rating > 5) {
      throw new AppError(400, "INVALID_RATING", "rating must be a number between 1 and 5");
    }

    const suggestionRef = db
      .collection("users")
      .doc(uid)
      .collection("giftSuggestions")
      .doc(suggestionId);

    const suggestionDoc = await suggestionRef.get();
    if (!suggestionDoc.exists) {
      throw new AppError(404, "SUGGESTION_NOT_FOUND", "Gift suggestion not found");
    }

    await suggestionRef.update({
      feedbackRating: rating,
      feedbackComment: comment || null,
      selectedGiftId: selectedGiftId || null,
      feedbackAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    });

    // Invalidate history cache
    const cacheKeys = await redis.keys(`gifts:history:${uid}:*`);
    if (cacheKeys.length > 0) await redis.del(...cacheKeys);

    res.json({
      data: {
        suggestionId,
        rating,
        comment: comment || null,
        selectedGiftId: selectedGiftId || null,
        feedbackAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

export default router;
