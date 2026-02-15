// functions/src/services/subscriptionService.ts
import { db, redis } from "../config";
import { SubscriptionTier, AppError } from "../types";

// ── Tier Definitions ──
export const TIER_CONFIG = {
  free: {
    name: "Free",
    pricing: { USD: 0, SAR: 0, MYR: 0 },
    limits: { aiMessages: 5, sosSessions: 0, actionCards: 3, memories: 10, giftSuggestions: 3 },
    features: ["basic_messages", "basic_reminders", "basic_cards"],
  },
  pro: {
    name: "Pro",
    pricing: { USD: 6.99, SAR: 26.99, MYR: 29.99 },
    limits: { aiMessages: 50, sosSessions: 5, actionCards: 10, memories: 100, giftSuggestions: 20 },
    features: ["basic_messages", "basic_reminders", "basic_cards", "sos_mode", "advanced_cards", "memory_vault", "gift_suggestions", "streak_freeze"],
  },
  legend: {
    name: "Legend",
    pricing: { USD: 12.99, SAR: 49.99, MYR: 54.99 },
    limits: { aiMessages: -1, sosSessions: -1, actionCards: -1, memories: -1, giftSuggestions: -1 },
    features: ["basic_messages", "basic_reminders", "basic_cards", "sos_mode", "advanced_cards", "memory_vault", "gift_suggestions", "streak_freeze", "priority_ai", "custom_tones", "leaderboard", "export_data"],
  },
} as const;

type FeatureKey = typeof TIER_CONFIG[SubscriptionTier]["features"][number];
type LimitKey = keyof typeof TIER_CONFIG.free.limits;

export async function getTierFromFirestore(uid: string): Promise<SubscriptionTier> {
  const cached = await redis.get(`sub:tier:${uid}`);
  if (cached) return cached as SubscriptionTier;

  const userDoc = await db.collection("users").doc(uid).get();
  if (!userDoc.exists) throw new AppError(404, "USER_NOT_FOUND", "User not found");

  const tier = (userDoc.data()?.tier || "free") as SubscriptionTier;
  await redis.setex(`sub:tier:${uid}`, 300, tier);
  return tier;
}

export function isFeatureAllowed(tier: SubscriptionTier, feature: string): boolean {
  return (TIER_CONFIG[tier].features as readonly string[]).includes(feature);
}

export async function getUsageCounts(uid: string, period: "daily" | "monthly" = "monthly"): Promise<Record<string, number>> {
  const now = new Date();
  const startKey = period === "daily"
    ? now.toISOString().slice(0, 10)
    : `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;

  const cacheKey = `usage:${uid}:${startKey}`;
  const cached = await redis.get(cacheKey);
  if (cached) return JSON.parse(cached);

  const usageDoc = await db.collection("users").doc(uid).collection("usage").doc(startKey).get();
  const data = usageDoc.exists ? usageDoc.data()! : { aiMessages: 0, sosSessions: 0, actionCards: 0, memories: 0, giftSuggestions: 0 };
  await redis.setex(cacheKey, 60, JSON.stringify(data));
  return data as Record<string, number>;
}

export async function incrementUsage(uid: string, key: LimitKey, amount = 1): Promise<void> {
  const now = new Date();
  const monthKey = `${now.getFullYear()}-${String(now.getMonth() + 1).padStart(2, "0")}`;
  const ref = db.collection("users").doc(uid).collection("usage").doc(monthKey);

  await db.runTransaction(async (tx) => {
    const doc = await tx.get(ref);
    const current = doc.exists ? (doc.data()?.[key] || 0) : 0;
    tx.set(ref, { [key]: current + amount, updatedAt: new Date() }, { merge: true });
  });

  await redis.del(`usage:${uid}:${monthKey}`);
}

export async function checkLimit(uid: string, key: LimitKey): Promise<{ allowed: boolean; current: number; limit: number }> {
  const tier = await getTierFromFirestore(uid);
  const limit = TIER_CONFIG[tier].limits[key];
  if (limit === -1) return { allowed: true, current: 0, limit: -1 };

  const usage = await getUsageCounts(uid);
  const current = usage[key] || 0;
  return { allowed: current < limit, current, limit };
}

export function getRegionalPricing(tier: SubscriptionTier, currency: "USD" | "SAR" | "MYR") {
  return { tier, currency, price: TIER_CONFIG[tier].pricing[currency], name: TIER_CONFIG[tier].name };
}

export async function getSubscriptionDetails(uid: string) {
  const subDoc = await db.collection("users").doc(uid).collection("subscription").doc("current").get();
  if (!subDoc.exists) return { tier: "free" as SubscriptionTier, active: false, expiresAt: null, provider: null };
  return subDoc.data();
}

export async function updateSubscription(uid: string, data: {
  tier: SubscriptionTier;
  provider: "revenuecat";
  productId: string;
  expiresAt: Date;
  autoRenew: boolean;
  originalTransactionId: string;
}) {
  const batch = db.batch();
  const subRef = db.collection("users").doc(uid).collection("subscription").doc("current");
  const userRef = db.collection("users").doc(uid);

  batch.set(subRef, { ...data, active: true, updatedAt: new Date() }, { merge: true });
  batch.update(userRef, { tier: data.tier, updatedAt: new Date() });
  await batch.commit();

  await redis.del(`sub:tier:${uid}`);
  await redis.del(`sub:details:${uid}`);
}

export async function downgradeToFree(uid: string): Promise<void> {
  const batch = db.batch();
  batch.update(db.collection("users").doc(uid), { tier: "free", updatedAt: new Date() });
  batch.set(
    db.collection("users").doc(uid).collection("subscription").doc("current"),
    { tier: "free", active: false, downgradeAt: new Date(), autoRenew: false, updatedAt: new Date() },
    { merge: true }
  );
  await batch.commit();
  await redis.del(`sub:tier:${uid}`);
}
