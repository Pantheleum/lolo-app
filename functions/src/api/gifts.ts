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

    // Load partner profile for personalized suggestions
    let partnerProfile: any = {};
    const profilesSnap = await db.collection("users").doc(uid).collection("profiles").limit(1).get();
    if (!profilesSnap.empty) {
      partnerProfile = profilesSnap.docs[0].data() || {};
    }

    const zodiacSign = partnerProfile.zodiacSign || "";
    const loveLanguage = partnerProfile.loveLanguage || "";
    const hobbies = (partnerProfile.preferences?.hobbies || []).join(", ");
    const favorites = partnerProfile.preferences?.favorites || {};
    const dislikes = (partnerProfile.preferences?.dislikes || []).join(", ");
    const favoriteColors = favorites.colors ? (Array.isArray(favorites.colors) ? favorites.colors.join(", ") : favorites.colors) : "";
    const favoriteCuisines = favorites.cuisines ? (Array.isArray(favorites.cuisines) ? favorites.cuisines.join(", ") : favorites.cuisines) : "";
    const favoriteFlowers = favorites.flowers ? (Array.isArray(favorites.flowers) ? favorites.flowers.join(", ") : favorites.flowers) : "";
    const favoriteBrands = favorites.brands ? (Array.isArray(favorites.brands) ? favorites.brands.join(", ") : favorites.brands) : "";

    // Build rich partner context
    let partnerContext = `\n\nPARTNER PROFILE:`;
    partnerContext += `\n- Name: ${partnerName}`;
    if (nationality) partnerContext += `\n- Nationality: ${nationality}`;
    if (zodiacSign) partnerContext += `\n- Zodiac sign: ${zodiacSign}`;
    if (loveLanguage) partnerContext += `\n- Love language: ${loveLanguage}`;
    if (hobbies) partnerContext += `\n- Hobbies/Interests: ${hobbies}`;
    if (favoriteColors) partnerContext += `\n- Favorite colors: ${favoriteColors}`;
    if (favoriteCuisines) partnerContext += `\n- Favorite cuisines: ${favoriteCuisines}`;
    if (favoriteFlowers) partnerContext += `\n- Favorite flowers: ${favoriteFlowers}`;
    if (favoriteBrands) partnerContext += `\n- Favorite brands: ${favoriteBrands}`;
    if (dislikes) partnerContext += `\n- Dislikes/Avoid: ${dislikes}`;

    // Build location context
    let locationContext = "";
    if (country || city) {
      const loc = [city, country].filter(Boolean).join(", ");
      locationContext = `\n\nLOCATION: ${loc}`;
    }

    const systemPrompt = `You are LOLO, an elite personal gift concierge. You give SPECIFIC, real-world gift recommendations — not generic ideas.

Generate exactly 5 gift suggestions. Respond with ONLY a JSON array (no other text).

Each gift must have this structure:
{
  "name": "<SPECIFIC gift — include brand, restaurant name, or exact product>",
  "description": "<2-3 sentences with specific details — name the actual brand, place, or product. Explain why it matches her personality>",
  "whySheLoveIt": "<1 sentence from her perspective, referencing her specific traits/interests>",
  "priceRange": "<actual price range in local currency if location known, e.g. 'RM 50-100' or '$20-50'>",
  "category": "<one of: flowers, jewelry, experience, fashion, beauty, food, tech, home, books, handmade, subscription, other>",
  "isLowBudget": <true if under $30 equivalent, false otherwise>,
  "matchedTraits": ["<specific trait from her profile that this matches>", "<another trait>"]
}

CRITICAL RULES:
- Be EXTREMELY SPECIFIC. Never say "local restaurant" — name the actual restaurant. Never say "a nice perfume" — name the exact perfume (e.g. "Jo Malone Peony & Blush Suede").
- If location is provided, recommend REAL places, shops, and experiences in that city (e.g. "Dinner at Marini's on 57, KL" not "a fancy dinner").
- Match gifts to her specific personality traits, hobbies, and preferences from her profile.
- Use LOCAL CURRENCY for the location (RM for Malaysia, SAR for Saudi Arabia, etc.)
- Mix categories: include at least one experience, one physical item, and one heartfelt/handmade option.
- Avoid anything in her "dislikes" list.
- If she loves specific brands/cuisines/flowers, incorporate those.
${budget ? `- Stay within budget: ${budget} ${currency || "USD"}` : "- Mix price ranges from affordable to premium"}${partnerContext}${locationContext}`;

    const userPrompt = occasion
      ? `Suggest 5 specific, personalized gifts for: ${occasion}`
      : "Suggest 5 specific, personalized gifts to surprise her — no special occasion, just because.";

    const result = await callGpt("gpt-4o-mini", systemPrompt, userPrompt, 2000);

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
