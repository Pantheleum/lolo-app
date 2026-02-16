// functions/src/api/gamification.ts
import { Router, Response, NextFunction } from "express";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { getLevelForXp, getNextLevel, LEVELS, BADGES, updateStreak } from "../services/gamificationService";

const router = Router();

// GET /gamification/profile
router.get("/profile", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const cacheKey = `gamification:profile:${uid}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    const statsDoc = await db.collection("users").doc(uid).collection("gamification").doc("stats").get();
    const stats = statsDoc.exists ? statsDoc.data()! : { xp: 0, level: 1, currentStreak: 0, longestStreak: 0, badges: [], weeklyStats: {}, monthlyStats: {} };

    const levelInfo = getLevelForXp(stats.xp || 0);
    const nextLevelInfo = getNextLevel(levelInfo.level);

    const profile = {
      userId: uid,
      totalXp: stats.xp || 0,
      level: levelInfo.level,
      levelName: levelInfo.name,
      xpToNextLevel: nextLevelInfo ? nextLevelInfo.xpRequired - (stats.xp || 0) : 0,
      nextLevelName: nextLevelInfo?.name || null,
      progressPercent: nextLevelInfo
        ? Math.round(((stats.xp - levelInfo.xpRequired) / (nextLevelInfo.xpRequired - levelInfo.xpRequired)) * 100)
        : 100,
      currentStreak: stats.currentStreak || 0,
      longestStreak: stats.longestStreak || 0,
      lastActiveDate: stats.lastActiveDate || null,
      freezesAvailable: stats.freezesAvailable || 0,
      badgeCount: (stats.badges || []).length,
      totalBadges: BADGES.length,
      weeklyStats: stats.weeklyStats || {},
      monthlyStats: stats.monthlyStats || {},
    };

    await redis.setex(cacheKey, 120, JSON.stringify(profile));
    return res.json(profile);
  } catch (err) {
    return next(err);
  }
});

// GET /gamification/leaderboard
router.get("/leaderboard", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const period = (req.query.period as string) || "weekly";
    const cacheKey = `leaderboard:${period}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    // Query top 50 users by XP using collection group query
    const snapshot = await db.collectionGroup("gamification")
      .where("__name__", ">=", "stats")
      .where("__name__", "<=", "stats")
      .orderBy("__name__")
      .limit(200)
      .get();

    const entries: { userId: string; xp: number; level: number; levelName: string; streak: number; displayName?: string }[] = [];

    for (const doc of snapshot.docs) {
      const data = doc.data();
      const xpField = period === "weekly" ? data.weeklyStats?.xpEarned : data.xp;
      const userId = doc.ref.parent.parent?.id;
      if (!userId || !xpField) continue;
      entries.push({
        userId,
        xp: xpField || 0,
        level: data.level || 1,
        levelName: getLevelForXp(data.xp || 0).name,
        streak: data.currentStreak || 0,
      });
    }

    entries.sort((a, b) => b.xp - a.xp);
    const top50 = entries.slice(0, 50);

    // Fetch display names
    const userIds = top50.map((e) => e.userId);
    const userDocs = await Promise.all(userIds.map((id) => db.collection("users").doc(id).get()));
    const nameMap = new Map<string, string>();
    userDocs.forEach((doc) => { if (doc.exists) nameMap.set(doc.id, doc.data()!.displayName || "Anonymous"); });

    const leaderboard = top50.map((e, i) => ({
      rank: i + 1,
      userId: e.userId,
      displayName: nameMap.get(e.userId) || "Anonymous",
      xp: e.xp,
      level: e.level,
      levelName: e.levelName,
      streak: e.streak,
    }));

    // Find current user's rank
    const myEntry = entries.find((e) => e.userId === req.user.uid);
    const myRank = myEntry ? entries.indexOf(myEntry) + 1 : null;

    const response = { period, leaderboard, myRank, totalParticipants: entries.length };
    await redis.setex(cacheKey, 300, JSON.stringify(response));
    return res.json(response);
  } catch (err) {
    return next(err);
  }
});

// GET /gamification/badges
router.get("/badges", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const statsDoc = await db.collection("users").doc(uid).collection("gamification").doc("stats").get();
    const earnedBadges: { id: string; earnedAt: any }[] = statsDoc.exists ? (statsDoc.data()!.badges || []) : [];
    const earnedIds = new Set(earnedBadges.map((b) => b.id));

    const allBadges = BADGES.map((badge: { id: string; name: string; category: string; earnedAt?: any; earned?: boolean }) => {
      const earned = earnedBadges.find((b) => b.id === badge.id);
      return {
        ...badge,
        earned: earnedIds.has(badge.id),
        earnedAt: earned?.earnedAt || null,
      };
    });

    const byCategory: Record<string, typeof allBadges> = {};
    allBadges.forEach((b) => {
      if (!byCategory[b.category]) byCategory[b.category] = [];
      byCategory[b.category].push(b);
    });

    return res.json({
      totalEarned: earnedBadges.length,
      totalAvailable: BADGES.length,
      badges: allBadges,
      byCategory,
    });
  } catch (err) {
    return next(err);
  }
});

export default router;
