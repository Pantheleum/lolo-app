// functions/src/api/gifts.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { callGpt } from "../ai/providers/gpt";
import * as functions from "firebase-functions";

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

    // Query all suggestions, filter in memory to avoid composite index issues
    const snapshot = await db
      .collection("users")
      .doc(uid)
      .collection("giftSuggestions")
      .orderBy("createdAt", "desc")
      .limit(100)
      .get();

    let gifts = snapshot.docs.flatMap((doc) => {
      const d = doc.data();
      const suggestions = d.suggestions || [];
      return suggestions.map((s: any) => ({
        id: s.id || doc.id,
        name: s.name || s.title || "Gift suggestion",
        description: s.description || "",
        priceRange: s.priceRange || s.estimatedPrice || "$10-50",
        category: s.category || d.occasion || "other",
        whySheLoveIt: s.whySheLoveIt || "",
        matchedTraits: s.matchedTraits || [],
        isLowBudget: s.isLowBudget || false,
        isSaved: s.isSaved || false,
        imageUrl: s.imageUrl || null,
        createdAt: d.createdAt,
      }));
    });

    // Filter by category in memory
    if (category) {
      const cat = (category as string).toLowerCase();
      gifts = gifts.filter((g: any) =>
        (g.category || "").toLowerCase() === cat || (g.occasion || "").toLowerCase() === cat
      );
    }

    // Filter by search in memory
    if (search) {
      const q = (search as string).toLowerCase();
      gifts = gifts.filter((g: any) =>
        (g.name || "").toLowerCase().includes(q) || (g.description || "").toLowerCase().includes(q)
      );
    }

    res.json({ data: gifts.slice(0, limit) });
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /gifts/recommend — AI-powered gift suggestions
// ============================================================
router.post("/recommend", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { occasion, budget, currency, city: reqCity, country: reqCountry } = req.body;

    console.log("[GIFTS] Recommend request:", { occasion, budget, currency, city: reqCity, country: reqCountry });

    // Get user profile for partner context
    const userDoc = await db.collection("users").doc(uid).get();
    const userData = userDoc.data() || {};
    const partnerName = userData.partnerNickname || userData.partnerName || "her";
    const nationality = userData.partnerNationality || userData.nationality || "";
    // Prefer location from request (GPS), fall back to profile
    const country = reqCountry || userData.country || userData.partnerCountry || "";
    const city = reqCity || userData.city || "";
    const language = userData.language || "en";

    // Build location context for culturally & locally relevant gifts
    let locationContext = "";
    if (country || city) {
      const loc = [city, country].filter(Boolean).join(", ");
      locationContext = `\n- The user is located in ${loc}. Suggest gifts that are available and relevant in this location. Consider local shops, experiences, and culturally appropriate options for this region.`;
    }

    const systemPrompt = `You are LOLO, an AI gift recommendation expert for men who want to surprise their partners.

Generate exactly 5 thoughtful, creative gift suggestions. Respond with ONLY a JSON array (no other text).

Each gift must have this structure:
{
  "name": "<gift name>",
  "description": "<2-3 sentences explaining what it is and why it's special>",
  "whySheLoveIt": "<1 sentence from her perspective — why she'd love this>",
  "priceRange": "<e.g. '$20-50' or '$100-200'>",
  "category": "<one of: flowers, jewelry, experience, fashion, beauty, food, tech, home, books, handmade, subscription, other>",
  "isLowBudget": <true if under $30, false otherwise>,
  "matchedTraits": ["<trait1>", "<trait2>"]
}

Rules:
- Be specific — "Personalized star map of the night you met" not just "a poster"
- Mix price ranges from affordable to premium
- Include at least one low-budget heartfelt option
- Include at least one experience (not physical item)
- Be culturally appropriate${nationality ? ` for ${nationality} women` : ""}${locationContext}
- Her name is "${partnerName}"
${budget ? `- Stay within budget: ${budget} ${currency || "USD"}` : ""}`;

    const userPrompt = occasion
      ? `Suggest 5 gifts for this occasion: ${occasion}`
      : "Suggest 5 thoughtful gifts to surprise her — no special occasion, just because.";

    const result = await callGpt("gpt-4o-mini", systemPrompt, userPrompt, 1500);

    let suggestions: any[];
    try {
      let jsonStr = result.content.trim();
      if (jsonStr.startsWith("```")) {
        jsonStr = jsonStr.replace(/^```(?:json)?\n?/, "").replace(/\n?```$/, "");
      }
      suggestions = JSON.parse(jsonStr);
    } catch (parseErr) {
      functions.logger.error("Failed to parse gift suggestions", parseErr);
      suggestions = [{
        name: "Handwritten Love Letter",
        description: "Write a heartfelt letter expressing what she means to you. Put it in a beautiful envelope with dried flowers.",
        whySheLoveIt: "Nothing beats knowing someone took time to pour their heart out on paper.",
        priceRange: "$5-10",
        category: "handmade",
        isLowBudget: true,
        matchedTraits: ["romantic", "thoughtful"],
      }];
    }

    // Store in Firestore
    const suggestionId = uuidv4();
    const now = new Date().toISOString();

    // Map category to image search term for Unsplash
    const categoryImageMap: Record<string, string> = {
      flowers: "flowers+bouquet",
      jewelry: "jewelry+gift",
      experience: "travel+adventure",
      fashion: "fashion+accessories",
      beauty: "beauty+skincare",
      food: "gourmet+food",
      tech: "gadget+technology",
      home: "home+decor",
      books: "books+reading",
      handmade: "handmade+craft",
      subscription: "gift+box",
      other: "gift+present",
    };

    const formattedSuggestions = suggestions.map((s: any, index: number) => {
      const cat = (s.category || "other").toLowerCase();
      const searchTerm = categoryImageMap[cat] || "gift+present";
      // Use picsum with a unique seed per suggestion for variety
      const imageUrl = `https://source.unsplash.com/400x300/?${searchTerm}&sig=${Date.now()}-${index}`;
      return {
        id: uuidv4(),
        name: s.name || s.title || "Gift idea",
        description: s.description || "",
        whySheLoveIt: s.whySheLoveIt || "",
        priceRange: s.priceRange || "$10-50",
        category: cat,
        isLowBudget: s.isLowBudget || false,
        matchedTraits: s.matchedTraits || [],
        isSaved: false,
        imageUrl,
      };
    });

    await db
      .collection("users")
      .doc(uid)
      .collection("giftSuggestions")
      .doc(suggestionId)
      .set({
        occasion: occasion || "just because",
        budget: budget || null,
        currency: currency || "USD",
        suggestions: formattedSuggestions,
        category: occasion || "other",
        modelUsed: "gpt-4o-mini",
        createdAt: now,
        updatedAt: now,
      });

    console.log("[GIFTS] Generated", formattedSuggestions.length, "suggestions");

    res.status(201).json({
      data: formattedSuggestions,
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
