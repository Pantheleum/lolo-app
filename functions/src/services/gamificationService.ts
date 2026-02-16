// functions/src/services/gamificationService.ts
import { db, redis } from "../config";
import { ActionType } from "../types";

const XP_TABLE: Record<string, number> = {
  action_card_complete: 15,
  reminder_complete: 15,
  message_generated: 10,
  message_feedback: 5,
  gift_feedback: 10,
  sos_resolved: 30,
  memory_added: 10,
  profile_updated: 5,
  daily_login: 5,
  streak_milestone: 50,
};

const LEVEL_THRESHOLDS = [
  { level: 1, xp: 0, name: "Newbie" },
  { level: 2, xp: 100, name: "Getting Started" },
  { level: 3, xp: 300, name: "Attentive" },
  { level: 4, xp: 600, name: "Thoughtful" },
  { level: 5, xp: 1000, name: "Caring Partner" },
  { level: 6, xp: 1500, name: "Dedicated" },
  { level: 7, xp: 2000, name: "Devoted Partner" },
  { level: 8, xp: 3000, name: "Relationship Champion" },
  { level: 9, xp: 4500, name: "Love Expert" },
  { level: 10, xp: 6000, name: "Legend" },
];

const BADGE_DEFINITIONS = [
  { id: "streak_7", name: "Week Warrior", category: "streak", condition: (s: any) => s.currentStreak >= 7 },
  { id: "streak_14", name: "Two-Week Warrior", category: "streak", condition: (s: any) => s.currentStreak >= 14 },
  { id: "streak_30", name: "Monthly Master", category: "streak", condition: (s: any) => s.currentStreak >= 30 },
  { id: "streak_60", name: "Unbreakable", category: "streak", condition: (s: any) => s.currentStreak >= 60 },
  { id: "streak_100", name: "Century of Love", category: "streak", condition: (s: any) => s.currentStreak >= 100 },
  { id: "msgs_10", name: "Communicator", category: "messages", condition: (s: any) => s.messagesGenerated >= 10 },
  { id: "msgs_50", name: "Smooth Talker", category: "messages", condition: (s: any) => s.messagesGenerated >= 50 },
  { id: "cards_25", name: "Action Hero", category: "actions", condition: (s: any) => s.actionCardsCompleted >= 25 },
  { id: "sos_5", name: "Crisis Navigator", category: "sos", condition: (s: any) => s.sosResolved >= 5 },
  { id: "level_5", name: "Caring Partner", category: "milestone", condition: (s: any) => s.level >= 5 },
  { id: "level_10", name: "Legend Status", category: "milestone", condition: (s: any) => s.level >= 10 },
];

export const LEVELS = LEVEL_THRESHOLDS;
export const BADGES = BADGE_DEFINITIONS;

export function getLevelForXp(totalXp: number): { level: number; name: string; xpForNextLevel: number; xpRequired: number } {
  let current = LEVEL_THRESHOLDS[0];
  for (const t of LEVEL_THRESHOLDS) {
    if (totalXp >= t.xp) current = t;
    else break;
  }
  const nextIdx = LEVEL_THRESHOLDS.findIndex((t) => t.level === current.level + 1);
  const xpForNext = nextIdx >= 0 ? LEVEL_THRESHOLDS[nextIdx].xp : current.xp + 2000;
  return { level: current.level, name: current.name, xpForNextLevel: xpForNext, xpRequired: current.xp };
}


export function getNextLevel(currentLevel: number): { level: number; name: string; xpRequired: number } | null {
  const nextIdx = LEVEL_THRESHOLDS.findIndex((t) => t.level === currentLevel + 1);
  if (nextIdx < 0) return null;
  const next = LEVEL_THRESHOLDS[nextIdx];
  return { level: next.level, name: next.name, xpRequired: next.xp };
}

export async function updateStreak(userId: string): Promise<{ currentStreak: number; longestStreak: number; isNewRecord: boolean }> {
  const gamRef = db.collection("gamification").doc(userId);
  const gamDoc = await gamRef.get();

  if (!gamDoc.exists) {
    await gamRef.set({
      userId, totalXp: 0, level: 1, levelName: "Newbie",
      currentStreak: 1, longestStreak: 1, lastActiveDate: new Date().toISOString().split("T")[0],
      freezesAvailable: 1, freezesUsedThisMonth: 0, badges: [],
      messagesGenerated: 0, actionCardsCompleted: 0, sosResolved: 0,
      createdAt: new Date().toISOString(),
    });
    return { currentStreak: 1, longestStreak: 1, isNewRecord: true };
  }

  const data = gamDoc.data()!;
  const today = new Date().toISOString().split("T")[0];
  const lastActive = data.lastActiveDate;
  let currentStreak = data.currentStreak || 0;
  let longestStreak = data.longestStreak || 0;

  if (lastActive !== today) {
    const yesterday = new Date(Date.now() - 86400000).toISOString().split("T")[0];
    if (lastActive === yesterday) {
      currentStreak += 1;
    } else if (lastActive) {
      currentStreak = 1;
    } else {
      currentStreak = 1;
    }
  }

  const isNewRecord = currentStreak > longestStreak;
  if (isNewRecord) longestStreak = currentStreak;

  await gamRef.update({
    currentStreak,
    longestStreak,
    lastActiveDate: today,
    updatedAt: new Date().toISOString(),
  });

  await redis.del(`gamification:profile:${userId}`);

  return { currentStreak, longestStreak, isNewRecord };
}

export async function awardXp(
  userId: string,
  actionType: ActionType | string,
  overrideXp?: number
): Promise<{
  xpAwarded: number;
  newTotalXp: number;
  levelUp: boolean;
  newLevel: { level: number; name: string } | null;
  badgeEarned: { id: string; name: string } | null;
  streakUpdate: { currentDays: number; isNewRecord: boolean };
}> {
  const gamRef = db.collection("gamification").doc(userId);
  const gamDoc = await gamRef.get();

  if (!gamDoc.exists) {
    await gamRef.set({
      userId, totalXp: 0, level: 1, levelName: "Newbie",
      currentStreak: 0, longestStreak: 0, lastActiveDate: null,
      freezesAvailable: 1, freezesUsedThisMonth: 0, badges: [],
      messagesGenerated: 0, actionCardsCompleted: 0, sosResolved: 0,
      createdAt: new Date().toISOString(),
    });
  }

  const data = (await gamRef.get()).data()!;
  const baseXp = overrideXp || XP_TABLE[actionType] || 5;

  // Streak bonus
  const streakBonus = data.currentStreak >= 7 ? Math.min(Math.floor(data.currentStreak / 7) * 5, 25) : 0;
  const totalAwarded = baseXp + streakBonus;
  const newTotalXp = (data.totalXp || 0) + totalAwarded;
  const oldLevel = data.level || 1;
  const levelInfo = getLevelForXp(newTotalXp);
  const levelUp = levelInfo.level > oldLevel;

  // Update streak
  const today = new Date().toISOString().split("T")[0];
  const lastActive = data.lastActiveDate;
  let currentStreak = data.currentStreak || 0;
  let longestStreak = data.longestStreak || 0;

  if (lastActive !== today) {
    const yesterday = new Date(Date.now() - 86400000).toISOString().split("T")[0];
    if (lastActive === yesterday) {
      currentStreak += 1;
    } else if (lastActive) {
      currentStreak = 1;
    } else {
      currentStreak = 1;
    }
  }
  const isNewRecord = currentStreak > longestStreak;
  if (isNewRecord) longestStreak = currentStreak;

  // Increment action counters
  const counterField = actionType === "message_generated" ? "messagesGenerated"
    : actionType === "action_card_complete" ? "actionCardsCompleted"
    : actionType === "sos_resolved" ? "sosResolved"
    : null;

  const updates: Record<string, any> = {
    totalXp: newTotalXp,
    level: levelInfo.level,
    levelName: levelInfo.name,
    currentStreak,
    longestStreak,
    lastActiveDate: today,
    updatedAt: new Date().toISOString(),
  };
  if (counterField) updates[counterField] = (data[counterField] || 0) + 1;

  // Check badges
  let badgeEarned: { id: string; name: string } | null = null;
  const checkState = { ...data, ...updates, level: levelInfo.level };
  for (const badge of BADGE_DEFINITIONS) {
    if (!data.badges?.includes(badge.id) && badge.condition(checkState)) {
      badgeEarned = { id: badge.id, name: badge.name };
      updates.badges = [...(data.badges || []), badge.id];
      break;
    }
  }

  await gamRef.update(updates);
  await redis.del(`gamification:profile:${userId}`);
  await redis.del(`gamification:badges:${userId}`);

  // Log action
  await db.collection("xp_log").add({
    userId, actionType, xpAwarded: totalAwarded, baseXp, streakBonus,
    newTotalXp, levelUp, badgeEarned: badgeEarned?.id || null,
    timestamp: new Date().toISOString(),
  });

  return {
    xpAwarded: totalAwarded,
    newTotalXp,
    levelUp,
    newLevel: levelUp ? { level: levelInfo.level, name: levelInfo.name } : null,
    badgeEarned,
    streakUpdate: { currentDays: currentStreak, isNewRecord },
  };
}
