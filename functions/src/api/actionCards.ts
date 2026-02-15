// functions/src/api/actionCards.ts
import { Router, Response, NextFunction } from "express";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { getTierFromFirestore, TIER_CONFIG, incrementUsage } from "../services/subscriptionService";
import { awardXp } from "../services/gamificationService";
import { enforceLimit } from "../middleware/tierEnforcement";
import { v4 as uuidv4 } from "uuid";

const router = Router();

const CARDS_PER_TIER = { free: 3, pro: 10, legend: 20 } as const;
const XP_BY_DIFFICULTY = { easy: 10, medium: 15, hard: 25 } as const;

// GET /action-cards/daily
router.get("/daily", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const today = new Date().toISOString().slice(0, 10);
    const cacheKey = `cards:daily:${uid}:${today}`;

    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    const tier = await getTierFromFirestore(uid);
    const maxCards = CARDS_PER_TIER[tier];

    const snapshot = await db.collection("users").doc(uid).collection("actionCards")
      .where("status", "==", "pending")
      .where("createdAt", ">=", new Date(today + "T00:00:00Z"))
      .where("createdAt", "<=", new Date(today + "T23:59:59Z"))
      .orderBy("createdAt", "desc")
      .limit(maxCards)
      .get();

    const cards = snapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const response = { tier, maxCards, count: cards.length, date: today, cards };

    await redis.setex(cacheKey, 300, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// POST /action-cards/:id/complete
router.post("/:id/complete", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const cardId = req.params.id;
    const cardRef = db.collection("users").doc(uid).collection("actionCards").doc(cardId);
    const cardDoc = await cardRef.get();

    if (!cardDoc.exists) throw new AppError(404, "CARD_NOT_FOUND", "Action card not found");

    const card = cardDoc.data()!;
    if (card.status === "completed") throw new AppError(409, "ALREADY_COMPLETED", "Card already completed");

    const difficulty = card.difficulty as keyof typeof XP_BY_DIFFICULTY;
    const xpAmount = XP_BY_DIFFICULTY[difficulty] || 15;

    await cardRef.update({
      status: "completed",
      completedAt: new Date(),
      xpEarned: xpAmount,
      updatedAt: new Date(),
    });

    const xpResult = await awardXp(uid, "action_card_complete", xpAmount);
    await incrementUsage(uid, "actionCards");

    const today = new Date().toISOString().slice(0, 10);
    await redis.del(`cards:daily:${uid}:${today}`);

    res.json({
      cardId,
      status: "completed",
      xpAwarded: xpAmount,
      totalXp: xpResult.totalXp,
      levelUp: xpResult.levelUp,
      newBadges: xpResult.newBadges,
    });
  } catch (err) {
    next(err);
  }
});

// POST /action-cards/:id/skip
router.post("/:id/skip", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const cardRef = db.collection("users").doc(uid).collection("actionCards").doc(req.params.id);
    const cardDoc = await cardRef.get();

    if (!cardDoc.exists) throw new AppError(404, "CARD_NOT_FOUND", "Action card not found");
    if (cardDoc.data()!.status !== "pending") throw new AppError(409, "INVALID_STATUS", "Can only skip pending cards");

    await cardRef.update({ status: "skipped", skippedAt: new Date(), skipReason: req.body.reason || null, updatedAt: new Date() });

    const today = new Date().toISOString().slice(0, 10);
    await redis.del(`cards:daily:${uid}:${today}`);

    res.json({ cardId: req.params.id, status: "skipped" });
  } catch (err) {
    next(err);
  }
});

// POST /action-cards/:id/save
router.post("/:id/save", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const cardRef = db.collection("users").doc(uid).collection("actionCards").doc(req.params.id);
    const cardDoc = await cardRef.get();

    if (!cardDoc.exists) throw new AppError(404, "CARD_NOT_FOUND", "Action card not found");

    await cardRef.update({ status: "saved", savedAt: new Date(), updatedAt: new Date() });

    const today = new Date().toISOString().slice(0, 10);
    await redis.del(`cards:daily:${uid}:${today}`);

    res.json({ cardId: req.params.id, status: "saved" });
  } catch (err) {
    next(err);
  }
});

// GET /action-cards/history
router.get("/history", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { status, type, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    let query: FirebaseFirestore.Query = db.collection("users").doc(uid).collection("actionCards")
      .orderBy("createdAt", "desc");

    if (status) query = query.where("status", "==", status);
    if (type) query = query.where("type", "==", type);

    if (lastDocId) {
      const lastDoc = await db.collection("users").doc(uid).collection("actionCards").doc(lastDocId as string).get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    const snapshot = await query.limit(limit + 1).get();
    const hasMore = snapshot.docs.length > limit;
    const docs = hasMore ? snapshot.docs.slice(0, limit) : snapshot.docs;

    const cards = docs.map((doc) => ({ id: doc.id, ...doc.data() }));
    const nextCursor = hasMore ? docs[docs.length - 1].id : null;

    res.json({ cards, hasMore, nextCursor, count: cards.length });
  } catch (err) {
    next(err);
  }
});

export default router;
