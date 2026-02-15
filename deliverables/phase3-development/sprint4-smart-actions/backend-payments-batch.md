# LOLO Backend Implementation -- Sprint 4: Payments, Smart Actions & Batch Jobs

**Task ID:** S4-02
**Prepared by:** Raj Patel, Backend Developer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 4 -- Smart Actions (Weeks 15-16)
**Dependencies:** Sprint 1 Foundation (S1-02B), Sprint 2 APIs (S2-02), Sprint 3 AI Engine (S3-002), API Contracts v1.0

---

## Table of Contents

1. [RevenueCat Webhooks + Subscription Service](#1-revenuecat-webhooks--subscription-service)
2. [Tier Enforcement Middleware](#2-tier-enforcement-middleware)
3. [Action Cards API](#3-action-cards-api)
4. [SOS API](#4-sos-api)
5. [Gamification API + Service](#5-gamification-api--service)
6. [Batch Jobs](#6-batch-jobs)
7. [Updated Exports & Route Registration](#7-updated-exports--route-registration)

---

## 1. RevenueCat Webhooks + Subscription Service

### 1.1 Subscription Service

```typescript
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
```

### 1.2 RevenueCat Webhook Handler

```typescript
// functions/src/webhooks/revenuecat.ts
import { Router, Request, Response, NextFunction } from "express";
import * as crypto from "crypto";
import { db, redis } from "../config";
import { AppError, SubscriptionTier } from "../types";
import { updateSubscription, downgradeToFree } from "../services/subscriptionService";
import { sendNotification } from "../services/notificationService";
import * as functions from "firebase-functions";

const router = Router();
const WEBHOOK_SECRET = process.env.REVENUECAT_WEBHOOK_SECRET || "";

// ── Signature Verification ──
function verifySignature(req: Request): boolean {
  const signature = req.headers["x-revenuecat-signature"] as string;
  if (!signature || !WEBHOOK_SECRET) return false;
  const expected = crypto.createHmac("sha256", WEBHOOK_SECRET).update(JSON.stringify(req.body)).digest("hex");
  return crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));
}

// ── Product ID → Tier Mapping ──
function tierFromProductId(productId: string): SubscriptionTier {
  if (productId.includes("legend")) return "legend";
  if (productId.includes("pro")) return "pro";
  return "free";
}

// ── Idempotency ──
async function isProcessed(eventId: string): Promise<boolean> {
  const exists = await redis.get(`rc:event:${eventId}`);
  return !!exists;
}

async function markProcessed(eventId: string): Promise<void> {
  await redis.setex(`rc:event:${eventId}`, 86400 * 7, "1");
}

// ── Event Logging ──
async function logWebhookEvent(event: Record<string, unknown>): Promise<void> {
  await db.collection("webhookEvents").add({
    provider: "revenuecat",
    ...event,
    processedAt: new Date(),
  });
}

// ── Event Handlers ──
async function handleInitialPurchase(event: any): Promise<void> {
  const { app_user_id, product_id, expiration_at_ms, original_transaction_id } = event;
  const tier = tierFromProductId(product_id);

  await updateSubscription(app_user_id, {
    tier,
    provider: "revenuecat",
    productId: product_id,
    expiresAt: new Date(expiration_at_ms),
    autoRenew: true,
    originalTransactionId: original_transaction_id,
  });

  await sendNotification({
    userId: app_user_id,
    title: "Welcome to LOLO " + (tier === "legend" ? "Legend" : "Pro") + "!",
    body: "Your subscription is now active. Enjoy all premium features.",
    type: "subscription",
    locale: "en",
  });

  functions.logger.info("INITIAL_PURCHASE processed", { uid: app_user_id, tier });
}

async function handleRenewal(event: any): Promise<void> {
  const { app_user_id, product_id, expiration_at_ms, original_transaction_id } = event;
  const tier = tierFromProductId(product_id);

  await updateSubscription(app_user_id, {
    tier,
    provider: "revenuecat",
    productId: product_id,
    expiresAt: new Date(expiration_at_ms),
    autoRenew: true,
    originalTransactionId: original_transaction_id,
  });

  functions.logger.info("RENEWAL processed", { uid: app_user_id, tier });
}

async function handleCancellation(event: any): Promise<void> {
  const { app_user_id, expiration_at_ms } = event;

  await db.collection("users").doc(app_user_id).collection("subscription").doc("current").update({
    autoRenew: false,
    cancelledAt: new Date(),
    effectiveEndDate: new Date(expiration_at_ms),
    updatedAt: new Date(),
  });

  await sendNotification({
    userId: app_user_id,
    title: "Subscription Cancelled",
    body: "Your premium access continues until the end of your billing period.",
    type: "subscription",
    locale: "en",
  });

  functions.logger.info("CANCELLATION processed", { uid: app_user_id });
}

async function handleBillingIssue(event: any): Promise<void> {
  const { app_user_id } = event;

  await db.collection("users").doc(app_user_id).collection("subscription").doc("current").update({
    billingIssue: true,
    billingIssueDetectedAt: new Date(),
    updatedAt: new Date(),
  });

  await sendNotification({
    userId: app_user_id,
    title: "Payment Issue",
    body: "We couldn't process your payment. Please update your payment method to keep premium access.",
    type: "subscription",
    locale: "en",
  });

  functions.logger.warn("BILLING_ISSUE detected", { uid: app_user_id });
}

async function handleExpiration(event: any): Promise<void> {
  const { app_user_id } = event;
  await downgradeToFree(app_user_id);

  await sendNotification({
    userId: app_user_id,
    title: "Subscription Expired",
    body: "Your premium subscription has expired. Upgrade anytime to restore full access.",
    type: "subscription",
    locale: "en",
  });

  functions.logger.info("EXPIRATION processed, downgraded to free", { uid: app_user_id });
}

// ── Main Webhook Endpoint ──
router.post("/", async (req: Request, res: Response, next: NextFunction) => {
  try {
    if (!verifySignature(req)) {
      throw new AppError(401, "INVALID_SIGNATURE", "Webhook signature verification failed");
    }

    const { event } = req.body;
    if (!event) throw new AppError(400, "MISSING_EVENT", "No event in payload");

    const eventId = event.id || `${event.type}_${event.app_user_id}_${Date.now()}`;

    if (await isProcessed(eventId)) {
      return res.status(200).json({ status: "already_processed" });
    }

    const eventData = event.subscriber || event;
    const eventType = event.type;

    await logWebhookEvent({ eventId, eventType, appUserId: eventData.app_user_id });

    switch (eventType) {
      case "INITIAL_PURCHASE":
        await handleInitialPurchase(eventData);
        break;
      case "RENEWAL":
        await handleRenewal(eventData);
        break;
      case "CANCELLATION":
        await handleCancellation(eventData);
        break;
      case "BILLING_ISSUE_DETECTED":
        await handleBillingIssue(eventData);
        break;
      case "SUBSCRIBER_ALIAS":
        break; // no-op
      case "EXPIRATION":
        await handleExpiration(eventData);
        break;
      default:
        functions.logger.warn("Unknown RevenueCat event type", { eventType });
    }

    await markProcessed(eventId);
    res.status(200).json({ status: "ok", eventId });
  } catch (err) {
    next(err);
  }
});

export default router;
```

### 1.3 Subscription API

```typescript
// functions/src/api/subscriptions.ts
import { Router, Response, NextFunction } from "express";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import {
  getTierFromFirestore,
  getSubscriptionDetails,
  getRegionalPricing,
  TIER_CONFIG,
  getUsageCounts,
} from "../services/subscriptionService";

const router = Router();

// GET /subscriptions/status
router.get("/status", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const cacheKey = `sub:status:${uid}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    const [tier, details, usage] = await Promise.all([
      getTierFromFirestore(uid),
      getSubscriptionDetails(uid),
      getUsageCounts(uid),
    ]);

    const config = TIER_CONFIG[tier];
    const response = {
      tier,
      name: config.name,
      active: details?.active ?? (tier !== "free"),
      expiresAt: details?.expiresAt || null,
      autoRenew: details?.autoRenew ?? false,
      billingIssue: details?.billingIssue ?? false,
      usage,
      limits: config.limits,
      features: config.features,
    };

    await redis.setex(cacheKey, 120, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// POST /subscriptions/verify
router.post("/verify", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { receiptData, platform } = req.body;
    if (!receiptData || !platform) {
      throw new AppError(400, "MISSING_FIELDS", "receiptData and platform are required");
    }

    // In production, validate receipt with RevenueCat API
    const rcApiKey = process.env.REVENUECAT_API_KEY;
    const response = await fetch(`https://api.revenuecat.com/v1/subscribers/${req.user.uid}`, {
      method: "GET",
      headers: {
        Authorization: `Bearer ${rcApiKey}`,
        "Content-Type": "application/json",
      },
    });

    if (!response.ok) {
      throw new AppError(502, "REVENUECAT_ERROR", "Failed to verify with RevenueCat");
    }

    const rcData = await response.json();
    const entitlements = rcData.subscriber?.entitlements || {};
    let verifiedTier: "free" | "pro" | "legend" = "free";

    if (entitlements.legend?.is_active) verifiedTier = "legend";
    else if (entitlements.pro?.is_active) verifiedTier = "pro";

    if (verifiedTier !== "free") {
      const ent = entitlements[verifiedTier];
      await db.collection("users").doc(req.user.uid).collection("subscription").doc("current").set({
        tier: verifiedTier,
        active: true,
        provider: "revenuecat",
        productId: ent.product_identifier,
        expiresAt: new Date(ent.expires_date),
        autoRenew: !ent.unsubscribe_detected_at,
        originalTransactionId: ent.original_purchase_date,
        verifiedAt: new Date(),
        updatedAt: new Date(),
      }, { merge: true });

      await db.collection("users").doc(req.user.uid).update({ tier: verifiedTier });
      await redis.del(`sub:tier:${req.user.uid}`);
    }

    res.json({ verified: true, tier: verifiedTier });
  } catch (err) {
    next(err);
  }
});

// POST /subscriptions/restore
router.post("/restore", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const rcApiKey = process.env.REVENUECAT_API_KEY;
    const response = await fetch(`https://api.revenuecat.com/v1/subscribers/${req.user.uid}`, {
      headers: { Authorization: `Bearer ${rcApiKey}` },
    });

    if (!response.ok) throw new AppError(502, "REVENUECAT_ERROR", "Failed to restore purchases");

    const rcData = await response.json();
    const entitlements = rcData.subscriber?.entitlements || {};
    let restoredTier: "free" | "pro" | "legend" = "free";

    if (entitlements.legend?.is_active) restoredTier = "legend";
    else if (entitlements.pro?.is_active) restoredTier = "pro";

    if (restoredTier !== "free") {
      const ent = entitlements[restoredTier];
      await db.collection("users").doc(req.user.uid).collection("subscription").doc("current").set({
        tier: restoredTier,
        active: true,
        provider: "revenuecat",
        productId: ent.product_identifier,
        expiresAt: new Date(ent.expires_date),
        autoRenew: !ent.unsubscribe_detected_at,
        restoredAt: new Date(),
        updatedAt: new Date(),
      }, { merge: true });
      await db.collection("users").doc(req.user.uid).update({ tier: restoredTier });
      await redis.del(`sub:tier:${req.user.uid}`);
    }

    res.json({ restored: restoredTier !== "free", tier: restoredTier });
  } catch (err) {
    next(err);
  }
});

// GET /subscriptions/offerings
router.get("/offerings", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const currency = (req.query.currency as "USD" | "SAR" | "MYR") || "USD";
    const validCurrencies = ["USD", "SAR", "MYR"];
    if (!validCurrencies.includes(currency)) {
      throw new AppError(400, "INVALID_CURRENCY", "Supported: USD, SAR, MYR");
    }

    const cacheKey = `offerings:${currency}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    const offerings = {
      currency,
      plans: [
        { ...getRegionalPricing("free", currency), limits: TIER_CONFIG.free.limits, features: TIER_CONFIG.free.features },
        { ...getRegionalPricing("pro", currency), limits: TIER_CONFIG.pro.limits, features: TIER_CONFIG.pro.features, trialDays: 7 },
        { ...getRegionalPricing("legend", currency), limits: TIER_CONFIG.legend.limits, features: TIER_CONFIG.legend.features, trialDays: 7 },
      ],
    };

    await redis.setex(cacheKey, 3600, JSON.stringify(offerings));
    res.json(offerings);
  } catch (err) {
    next(err);
  }
});

export default router;
```

---

## 2. Tier Enforcement Middleware

```typescript
// functions/src/middleware/tierEnforcement.ts
import { Response, NextFunction } from "express";
import { AuthenticatedRequest, AppError } from "../types";
import { getTierFromFirestore, isFeatureAllowed, checkLimit, TIER_CONFIG } from "../services/subscriptionService";

type LimitKey = "aiMessages" | "sosSessions" | "actionCards" | "memories" | "giftSuggestions";

export function requireFeature(feature: string) {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const tier = await getTierFromFirestore(req.user.uid);
      if (!isFeatureAllowed(tier, feature)) {
        throw new AppError(403, "TIER_LIMIT_EXCEEDED", `Feature "${feature}" requires a higher subscription tier`, {
          currentTier: tier,
          requiredFeature: feature,
          upgradeTiers: (["pro", "legend"] as const).filter((t) => isFeatureAllowed(t, feature)),
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}

export function requireTier(...allowedTiers: string[]) {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const tier = await getTierFromFirestore(req.user.uid);
      if (!allowedTiers.includes(tier)) {
        throw new AppError(403, "TIER_LIMIT_EXCEEDED", `This endpoint requires ${allowedTiers.join(" or ")} tier`, {
          currentTier: tier,
          requiredTiers: allowedTiers,
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}

export function enforceLimit(limitKey: LimitKey) {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const { allowed, current, limit } = await checkLimit(req.user.uid, limitKey);
      if (!allowed) {
        throw new AppError(403, "TIER_LIMIT_EXCEEDED", `Monthly ${limitKey} limit reached`, {
          currentUsage: current,
          monthlyLimit: limit,
          limitKey,
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}
```

---

## 3. Action Cards API

```typescript
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
```

---

## 4. SOS API

```typescript
// functions/src/api/sos.ts
import { Router, Response, NextFunction } from "express";
import { db, redis, CONFIG } from "../config";
import { AuthenticatedRequest, AppError, SubscriptionTier } from "../types";
import { requireFeature, enforceLimit } from "../middleware/tierEnforcement";
import { getTierFromFirestore, incrementUsage } from "../services/subscriptionService";
import { awardXp } from "../services/gamificationService";
import { encrypt, decrypt } from "../services/encryptionService";
import { v4 as uuidv4 } from "uuid";
import * as functions from "firebase-functions";

const router = Router();

// POST /sos/activate — tier check: Pro+
router.post(
  "/activate",
  requireFeature("sos_mode"),
  enforceLimit("sosSessions"),
  async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const uid = req.user.uid;
      const { scenario, urgency, partnerProfileId } = req.body;

      if (!scenario || !urgency) {
        throw new AppError(400, "MISSING_FIELDS", "scenario and urgency are required");
      }

      const sessionId = uuidv4();
      const encryptedScenario = encrypt(scenario);

      await db.collection("users").doc(uid).collection("sosSessions").doc(sessionId).set({
        scenario: encryptedScenario,
        urgency,
        severity: null,
        status: "active",
        coachingMessages: [],
        partnerProfileId: partnerProfileId || null,
        stepsCompleted: 0,
        modelUsed: null,
        duration: 0,
        createdAt: new Date(),
      });

      await incrementUsage(uid, "sosSessions");

      res.status(201).json({
        sessionId,
        status: "active",
        message: "SOS session activated. Proceed to /assess for situation analysis.",
      });
    } catch (err) {
      next(err);
    }
  }
);

// POST /sos/assess
router.post("/assess", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, answers } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");
    if (sessionDoc.data()!.status !== "active") throw new AppError(409, "SESSION_INACTIVE", "Session is no longer active");

    // Score severity from answers
    const severityScore = calculateSeverity(answers || {});
    const severityLabel = severityScore >= 8 ? "critical" : severityScore >= 5 ? "high" : severityScore >= 3 ? "medium" : "low";

    await sessionRef.update({
      severity: severityLabel,
      severityScore,
      assessmentAnswers: answers,
      assessedAt: new Date(),
      updatedAt: new Date(),
    });

    res.json({
      sessionId,
      severity: severityLabel,
      severityScore,
      recommendedApproach: getApproachForSeverity(severityLabel),
    });
  } catch (err) {
    next(err);
  }
});

function calculateSeverity(answers: Record<string, any>): number {
  let score = 0;
  if (answers.sheIsCrying) score += 3;
  if (answers.sheIsAngry) score += 2;
  if (answers.sheIsSilent) score += 2;
  if (answers.involvesFamily) score += 2;
  if (answers.isPublic) score += 1;
  if (answers.urgency === "happening_now") score += 2;
  else if (answers.urgency === "just_happened") score += 1;
  return Math.min(score, 10);
}

function getApproachForSeverity(severity: string) {
  const approaches: Record<string, object> = {
    critical: { steps: 5, tone: "calm_urgent", includeScript: true, priorityModel: true },
    high: { steps: 4, tone: "empathetic", includeScript: true, priorityModel: true },
    medium: { steps: 3, tone: "supportive", includeScript: false, priorityModel: false },
    low: { steps: 2, tone: "encouraging", includeScript: false, priorityModel: false },
  };
  return approaches[severity] || approaches.medium;
}

// POST /sos/coach — SSE streaming
router.post("/coach", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, userMessage, step } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");

    const session = sessionDoc.data()!;
    if (session.status !== "active") throw new AppError(409, "SESSION_INACTIVE", "Session is no longer active");
    if ((session.stepsCompleted || 0) >= CONFIG.MAX_SOS_STEPS) {
      throw new AppError(409, "MAX_STEPS_REACHED", "Maximum coaching steps reached");
    }

    // SSE headers
    res.setHeader("Content-Type", "text/event-stream");
    res.setHeader("Cache-Control", "no-cache");
    res.setHeader("Connection", "keep-alive");
    res.setHeader("X-Accel-Buffering", "no");

    // Add user message to transcript
    const userMsg = { role: "user", text: userMessage || "", timestamp: new Date() };

    // Build AI prompt from session context
    const partnerDoc = session.partnerProfileId
      ? await db.collection("users").doc(uid).collection("partnerProfiles").doc(session.partnerProfileId).get()
      : null;

    const prompt = buildSOSPrompt(session, userMessage, partnerDoc?.data(), step);

    // Stream AI response via AI router
    const aiRouterUrl = process.env.AI_ROUTER_INTERNAL_URL || "http://localhost:5001/api/v1/ai/route";
    const tier = await getTierFromFirestore(uid);
    const aiResponse = await fetch(aiRouterUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-Internal-Key": process.env.INTERNAL_API_KEY || "" },
      body: JSON.stringify({
        requestId: uuidv4(),
        userId: uid,
        tier,
        requestType: "sos_coaching",
        parameters: { tone: "empathetic", length: "medium", language: req.user.language },
        context: { prompt, severity: session.severity, step },
        stream: true,
      }),
    });

    if (!aiResponse.ok || !aiResponse.body) {
      res.write(`data: ${JSON.stringify({ error: "AI service unavailable" })}\n\n`);
      res.end();
      return;
    }

    let fullResponse = "";
    const reader = aiResponse.body.getReader();
    const decoder = new TextDecoder();

    while (true) {
      const { done, value } = await reader.read();
      if (done) break;
      const chunk = decoder.decode(value, { stream: true });
      fullResponse += chunk;
      res.write(`data: ${JSON.stringify({ chunk, done: false })}\n\n`);
    }

    res.write(`data: ${JSON.stringify({ chunk: "", done: true })}\n\n`);
    res.end();

    // Update session transcript
    const aiMsg = { role: "ai", text: fullResponse, timestamp: new Date() };
    await sessionRef.update({
      coachingMessages: [...(session.coachingMessages || []), userMsg, aiMsg],
      stepsCompleted: (session.stepsCompleted || 0) + 1,
      modelUsed: "ai_router",
      updatedAt: new Date(),
    });
  } catch (err) {
    if (!res.headersSent) return next(err);
    functions.logger.error("SSE coaching error", err);
    res.end();
  }
});

function buildSOSPrompt(session: any, userMessage: string, partner: any, step: number): string {
  const scenario = decrypt(session.scenario);
  const history = (session.coachingMessages || []).map((m: any) => `${m.role}: ${m.text}`).join("\n");
  return [
    `SOS Coaching - Step ${step || 1}`,
    `Scenario: ${scenario}`,
    `Severity: ${session.severity}`,
    partner ? `Partner: ${partner.name}, Style: ${partner.communicationStyle}` : "",
    history ? `History:\n${history}` : "",
    `User says: ${userMessage}`,
    "Provide empathetic, actionable coaching. Be concise. Suggest what to say or do next.",
  ].filter(Boolean).join("\n");
}

// POST /sos/complete
router.post("/complete", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { sessionId, resolution, saveToMemoryVault } = req.body;

    if (!sessionId) throw new AppError(400, "MISSING_SESSION", "sessionId is required");

    const sessionRef = db.collection("users").doc(uid).collection("sosSessions").doc(sessionId);
    const sessionDoc = await sessionRef.get();

    if (!sessionDoc.exists) throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found");

    const session = sessionDoc.data()!;
    const durationSec = Math.floor((Date.now() - session.createdAt.toDate().getTime()) / 1000);

    await sessionRef.update({
      status: "completed",
      resolution: resolution || "resolved",
      duration: durationSec,
      endedAt: new Date(),
      updatedAt: new Date(),
    });

    // Award XP
    const xpResult = await awardXp(uid, "sos_resolved", 25);

    // Save to Memory Vault if requested
    let memoryId: string | null = null;
    if (saveToMemoryVault) {
      memoryId = uuidv4();
      const scenario = decrypt(session.scenario);
      await db.collection("users").doc(uid).collection("memories").doc(memoryId).set({
        title: `SOS: ${scenario.slice(0, 50)}`,
        content: `Resolved ${session.severity} situation. ${resolution || ""}`.trim(),
        category: "milestone",
        tags: ["sos", session.severity],
        sheSaid: false,
        createdAt: new Date(),
        updatedAt: new Date(),
      });
    }

    res.json({
      sessionId,
      status: "completed",
      durationSec,
      xpAwarded: 25,
      totalXp: xpResult.totalXp,
      levelUp: xpResult.levelUp,
      newBadges: xpResult.newBadges,
      memoryId,
    });
  } catch (err) {
    next(err);
  }
});

export default router;
```

---

## 5. Gamification API + Service

### 5.1 Gamification Service

```typescript
// functions/src/services/gamificationService.ts
import { db, redis } from "../config";
import { sendNotification } from "../services/notificationService";
import * as functions from "firebase-functions";

// ── XP Table ──
const XP_ACTIONS: Record<string, number> = {
  message_sent: 10,
  card_completed: 15,
  action_card_complete: 15,
  sos_resolved: 25,
  memory_added: 5,
  streak_day: 5,
  gift_feedback: 5,
  profile_updated: 10,
  daily_login: 3,
  reminder_complete: 10,
};

// ── Level Thresholds (20 levels) ──
const LEVELS: { level: number; name: string; xpRequired: number }[] = [
  { level: 1, name: "Newbie", xpRequired: 0 },
  { level: 2, name: "Listener", xpRequired: 50 },
  { level: 3, name: "Apprentice", xpRequired: 150 },
  { level: 4, name: "Attentive", xpRequired: 300 },
  { level: 5, name: "Thoughtful", xpRequired: 500 },
  { level: 6, name: "Caring", xpRequired: 800 },
  { level: 7, name: "Devoted", xpRequired: 1200 },
  { level: 8, name: "Romantic", xpRequired: 1700 },
  { level: 9, name: "Passionate", xpRequired: 2300 },
  { level: 10, name: "Champion", xpRequired: 3000 },
  { level: 11, name: "Sweetheart", xpRequired: 4000 },
  { level: 12, name: "Soulmate", xpRequired: 5200 },
  { level: 13, name: "Enchanter", xpRequired: 6500 },
  { level: 14, name: "Guardian", xpRequired: 8000 },
  { level: 15, name: "Protector", xpRequired: 10000 },
  { level: 16, name: "Hero", xpRequired: 12500 },
  { level: 17, name: "Knight", xpRequired: 15500 },
  { level: 18, name: "King", xpRequired: 19000 },
  { level: 19, name: "Legend", xpRequired: 23000 },
  { level: 20, name: "LOLO Master", xpRequired: 28000 },
];

// ── 30 Badges ──
const BADGES = [
  { id: "first_message", name: "First Words", description: "Send your first message", category: "messages", condition: { action: "message_sent", count: 1 } },
  { id: "10_messages", name: "Conversationalist", description: "Send 10 messages", category: "messages", condition: { action: "message_sent", count: 10 } },
  { id: "50_messages", name: "Sweet Talker", description: "Send 50 messages", category: "messages", condition: { action: "message_sent", count: 50 } },
  { id: "100_messages", name: "Wordsmith", description: "Send 100 messages", category: "messages", condition: { action: "message_sent", count: 100 } },
  { id: "500_messages", name: "Poet Laureate", description: "Send 500 messages", category: "messages", condition: { action: "message_sent", count: 500 } },
  { id: "first_card", name: "Action Taker", description: "Complete first action card", category: "actions", condition: { action: "action_card_complete", count: 1 } },
  { id: "10_cards", name: "Go-Getter", description: "Complete 10 cards", category: "actions", condition: { action: "action_card_complete", count: 10 } },
  { id: "50_cards", name: "Unstoppable", description: "Complete 50 cards", category: "actions", condition: { action: "action_card_complete", count: 50 } },
  { id: "100_cards", name: "Card Master", description: "Complete 100 cards", category: "actions", condition: { action: "action_card_complete", count: 100 } },
  { id: "first_sos", name: "Crisis Handler", description: "Resolve first SOS", category: "sos", condition: { action: "sos_resolved", count: 1 } },
  { id: "5_sos", name: "Cool Head", description: "Resolve 5 SOS sessions", category: "sos", condition: { action: "sos_resolved", count: 5 } },
  { id: "20_sos", name: "Zen Master", description: "Resolve 20 SOS sessions", category: "sos", condition: { action: "sos_resolved", count: 20 } },
  { id: "first_memory", name: "Memory Keeper", description: "Add first memory", category: "milestone", condition: { action: "memory_added", count: 1 } },
  { id: "25_memories", name: "Historian", description: "Add 25 memories", category: "milestone", condition: { action: "memory_added", count: 25 } },
  { id: "first_gift", name: "Gift Giver", description: "First gift feedback", category: "gifts", condition: { action: "gift_feedback", count: 1 } },
  { id: "20_gifts", name: "Santa", description: "20 gift feedbacks", category: "gifts", condition: { action: "gift_feedback", count: 20 } },
  { id: "streak_3", name: "Getting Started", description: "3-day streak", category: "streak", condition: { streak: 3 } },
  { id: "streak_7", name: "Week Warrior", description: "7-day streak", category: "streak", condition: { streak: 7 } },
  { id: "streak_14", name: "Fortnight Force", description: "14-day streak", category: "streak", condition: { streak: 14 } },
  { id: "streak_30", name: "Monthly Master", description: "30-day streak", category: "streak", condition: { streak: 30 } },
  { id: "streak_60", name: "Two Month Titan", description: "60-day streak", category: "streak", condition: { streak: 60 } },
  { id: "streak_90", name: "Quarter Legend", description: "90-day streak", category: "streak", condition: { streak: 90 } },
  { id: "streak_180", name: "Half-Year Hero", description: "180-day streak", category: "streak", condition: { streak: 180 } },
  { id: "streak_365", name: "Year of Love", description: "365-day streak", category: "streak", condition: { streak: 365 } },
  { id: "level_5", name: "Rising Star", description: "Reach level 5", category: "milestone", condition: { level: 5 } },
  { id: "level_10", name: "Champion", description: "Reach level 10", category: "milestone", condition: { level: 10 } },
  { id: "level_15", name: "Protector", description: "Reach level 15", category: "milestone", condition: { level: 15 } },
  { id: "level_20", name: "LOLO Master", description: "Reach level 20", category: "milestone", condition: { level: 20 } },
  { id: "all_card_types", name: "Versatile", description: "Complete SAY, DO, BUY, GO cards", category: "actions", condition: { special: "all_card_types" } },
  { id: "first_week", name: "Welcome", description: "Active for 7 days", category: "milestone", condition: { daysActive: 7 } },
];

function getLevelForXp(totalXp: number): { level: number; name: string; xpRequired: number } {
  for (let i = LEVELS.length - 1; i >= 0; i--) {
    if (totalXp >= LEVELS[i].xpRequired) return LEVELS[i];
  }
  return LEVELS[0];
}

function getNextLevel(currentLevel: number) {
  return LEVELS.find((l) => l.level === currentLevel + 1) || null;
}

export async function awardXp(
  userId: string,
  action: string,
  amount?: number
): Promise<{ totalXp: number; levelUp: boolean; newLevel?: number; newLevelName?: string; newBadges: string[] }> {
  const xpToAdd = amount ?? XP_ACTIONS[action] ?? 0;
  if (xpToAdd === 0) return { totalXp: 0, levelUp: false, newBadges: [] };

  const statsRef = db.collection("users").doc(userId).collection("gamification").doc("stats");
  const countsRef = db.collection("users").doc(userId).collection("gamification").doc("counts");

  let result = { totalXp: 0, levelUp: false, newLevel: undefined as number | undefined, newLevelName: undefined as string | undefined, newBadges: [] as string[] };

  await db.runTransaction(async (tx) => {
    const statsDoc = await tx.get(statsRef);
    const countsDoc = await tx.get(countsRef);

    const stats = statsDoc.exists ? statsDoc.data()! : { xp: 0, level: 1, currentStreak: 0, longestStreak: 0, lastActiveDate: "", badges: [], weeklyStats: { xpEarned: 0 }, monthlyStats: { xpEarned: 0 } };
    const counts = countsDoc.exists ? countsDoc.data()! : {};

    const newXp = (stats.xp || 0) + xpToAdd;
    const oldLevel = getLevelForXp(stats.xp || 0);
    const newLevelInfo = getLevelForXp(newXp);
    const leveledUp = newLevelInfo.level > oldLevel.level;

    // Update action counts
    const newCount = (counts[action] || 0) + 1;
    tx.set(countsRef, { [action]: newCount, updatedAt: new Date() }, { merge: true });

    // Check badges
    const existingBadgeIds = (stats.badges || []).map((b: any) => b.id);
    const newBadges: { id: string; name: string; earnedAt: Date }[] = [];

    for (const badge of BADGES) {
      if (existingBadgeIds.includes(badge.id)) continue;
      const cond = badge.condition as any;
      let earned = false;
      if (cond.action && cond.action === action && newCount >= cond.count) earned = true;
      if (cond.streak && (stats.currentStreak || 0) >= cond.streak) earned = true;
      if (cond.level && newLevelInfo.level >= cond.level) earned = true;
      if (earned) newBadges.push({ id: badge.id, name: badge.name, earnedAt: new Date() });
    }

    tx.set(statsRef, {
      xp: newXp,
      level: newLevelInfo.level,
      levelName: newLevelInfo.name,
      badges: [...(stats.badges || []), ...newBadges],
      weeklyStats: { ...stats.weeklyStats, xpEarned: (stats.weeklyStats?.xpEarned || 0) + xpToAdd },
      monthlyStats: { ...stats.monthlyStats, xpEarned: (stats.monthlyStats?.xpEarned || 0) + xpToAdd },
      updatedAt: new Date(),
    }, { merge: true });

    result = {
      totalXp: newXp,
      levelUp: leveledUp,
      newLevel: leveledUp ? newLevelInfo.level : undefined,
      newLevelName: leveledUp ? newLevelInfo.name : undefined,
      newBadges: newBadges.map((b) => b.id),
    };
  });

  await redis.del(`gamification:profile:${userId}`);

  if (result.levelUp) {
    await sendNotification({
      userId,
      title: "Level Up!",
      body: `You reached Level ${result.newLevel}: ${result.newLevelName}!`,
      type: "gamification",
      locale: "en",
    });
  }

  return result;
}

export async function updateStreak(userId: string): Promise<{ streak: number; broken: boolean; frozen: boolean }> {
  const statsRef = db.collection("users").doc(userId).collection("gamification").doc("stats");
  let result = { streak: 0, broken: false, frozen: false };

  await db.runTransaction(async (tx) => {
    const doc = await tx.get(statsRef);
    const stats = doc.exists ? doc.data()! : { currentStreak: 0, longestStreak: 0, lastActiveDate: "", freezesAvailable: 0 };

    const today = new Date().toISOString().slice(0, 10);
    const lastActive = stats.lastActiveDate || "";

    if (lastActive === today) {
      result = { streak: stats.currentStreak, broken: false, frozen: false };
      return;
    }

    const yesterday = new Date(Date.now() - 86400000).toISOString().slice(0, 10);

    if (lastActive === yesterday) {
      // Consecutive day
      const newStreak = (stats.currentStreak || 0) + 1;
      const longest = Math.max(newStreak, stats.longestStreak || 0);
      tx.update(statsRef, { currentStreak: newStreak, longestStreak: longest, lastActiveDate: today, updatedAt: new Date() });
      result = { streak: newStreak, broken: false, frozen: false };
    } else if (stats.freezesAvailable > 0) {
      // Use streak freeze
      tx.update(statsRef, {
        freezesAvailable: stats.freezesAvailable - 1,
        freezesUsedThisMonth: (stats.freezesUsedThisMonth || 0) + 1,
        lastActiveDate: today,
        updatedAt: new Date(),
      });
      result = { streak: stats.currentStreak, broken: false, frozen: true };
    } else {
      // Streak broken
      tx.update(statsRef, { currentStreak: 1, lastActiveDate: today, updatedAt: new Date() });
      result = { streak: 1, broken: true, frozen: false };
    }
  });

  await redis.del(`gamification:profile:${userId}`);
  return result;
}

export { LEVELS, BADGES, XP_ACTIONS, getLevelForXp, getNextLevel };
```

### 5.2 Gamification API

```typescript
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
    res.json(profile);
  } catch (err) {
    next(err);
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
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// GET /gamification/badges
router.get("/badges", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const statsDoc = await db.collection("users").doc(uid).collection("gamification").doc("stats").get();
    const earnedBadges: { id: string; earnedAt: any }[] = statsDoc.exists ? (statsDoc.data()!.badges || []) : [];
    const earnedIds = new Set(earnedBadges.map((b) => b.id));

    const allBadges = BADGES.map((badge) => {
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

    res.json({
      totalEarned: earnedBadges.length,
      totalAvailable: BADGES.length,
      badges: allBadges,
      byCategory,
    });
  } catch (err) {
    next(err);
  }
});

export default router;
```

---

## 6. Batch Jobs

### 6.1 Daily Cards Generator

```typescript
// functions/src/scheduled/dailyCards.ts
import * as functions from "firebase-functions";
import { db, redis } from "../config";
import { v4 as uuidv4 } from "uuid";
import { getTierFromFirestore, TIER_CONFIG } from "../services/subscriptionService";

const TIMEZONE_BUCKETS = [
  { id: "utc_minus", offset: -5, cron: "0 7 * * *" },   // Americas → 2am local
  { id: "utc_zero", offset: 0, cron: "0 2 * * *" },      // Europe/Africa → 2am UTC
  { id: "utc_plus_3", offset: 3, cron: "0 23 * * *" },   // Middle East → 2am AST (prev day UTC)
  { id: "utc_plus_8", offset: 8, cron: "0 18 * * *" },   // Malaysia/Asia → 2am MYT (prev day UTC)
];

const BATCH_SIZE = 50;
const CARDS_PER_TIER = { free: 3, pro: 10, legend: 20 };
const DLQ_COLLECTION = "deadLetterQueue";

interface CardGenerationResult {
  userId: string;
  cardsGenerated: number;
  error?: string;
}

async function getUsersForBucket(bucketId: string, lastDocId?: string): Promise<FirebaseFirestore.QueryDocumentSnapshot[]> {
  const timezoneMap: Record<string, string[]> = {
    utc_minus: ["America/New_York", "America/Chicago", "America/Los_Angeles"],
    utc_zero: ["Europe/London", "UTC", "Africa/Lagos"],
    utc_plus_3: ["Asia/Riyadh", "Asia/Dubai", "Asia/Baghdad"],
    utc_plus_8: ["Asia/Kuala_Lumpur", "Asia/Singapore", "Asia/Shanghai"],
  };

  const timezones = timezoneMap[bucketId] || ["UTC"];
  let query: FirebaseFirestore.Query = db.collection("users")
    .where("settings.timezone", "in", timezones)
    .where("onboardingComplete", "==", true)
    .limit(BATCH_SIZE);

  if (lastDocId) {
    const lastDoc = await db.collection("users").doc(lastDocId).get();
    if (lastDoc.exists) query = query.startAfter(lastDoc);
  }

  const snapshot = await query.get();
  return snapshot.docs;
}

async function generateCardsForUser(userId: string): Promise<CardGenerationResult> {
  try {
    const tier = await getTierFromFirestore(userId);
    const cardCount = CARDS_PER_TIER[tier];
    const today = new Date().toISOString().slice(0, 10);

    // Check if cards already generated today
    const existing = await db.collection("users").doc(userId).collection("actionCards")
      .where("createdAt", ">=", new Date(today + "T00:00:00Z"))
      .where("createdAt", "<=", new Date(today + "T23:59:59Z"))
      .limit(1).get();

    if (!existing.empty) return { userId, cardsGenerated: 0 };

    // Fetch partner profile for context
    const partnerSnap = await db.collection("users").doc(userId).collection("partnerProfiles").limit(1).get();
    const partner = partnerSnap.empty ? null : partnerSnap.docs[0].data();

    // Fetch recent card history to avoid repeats
    const recentCards = await db.collection("users").doc(userId).collection("actionCards")
      .orderBy("createdAt", "desc").limit(20).get();
    const recentTypes = recentCards.docs.map((d) => d.data().type);

    // Call AI router for card generation
    const aiRouterUrl = process.env.AI_ROUTER_INTERNAL_URL || "http://localhost:5001/api/v1/ai/route";
    const aiResponse = await fetch(aiRouterUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-Internal-Key": process.env.INTERNAL_API_KEY || "" },
      body: JSON.stringify({
        requestId: uuidv4(),
        userId,
        tier,
        requestType: "action_card",
        parameters: { count: cardCount, language: "en", avoidTypes: recentTypes.slice(0, 5) },
        context: { partner, recentCardTypes: recentTypes },
      }),
    });

    if (!aiResponse.ok) throw new Error(`AI router returned ${aiResponse.status}`);
    const aiData = await aiResponse.json();
    const cards = aiData.cards || aiData.content || [];

    // Write cards in batch
    const batch = db.batch();
    const generatedCards = Array.isArray(cards) ? cards : [{ type: "DO", title: "Do something kind today", body: "Show appreciation.", difficulty: "easy" }];

    for (let i = 0; i < Math.min(generatedCards.length, cardCount); i++) {
      const card = generatedCards[i];
      const cardId = uuidv4();
      batch.set(db.collection("users").doc(userId).collection("actionCards").doc(cardId), {
        type: card.type || "DO",
        title: card.title || "Action Card",
        body: card.body || "",
        context: card.context || null,
        difficulty: card.difficulty || "medium",
        status: "pending",
        xpEarned: 0,
        generatedBy: "batch_daily",
        qualityScore: card.qualityScore || null,
        partnerProfileId: partnerSnap.empty ? null : partnerSnap.docs[0].id,
        createdAt: new Date(),
      });
    }

    await batch.commit();
    await redis.del(`cards:daily:${userId}:${today}`);

    return { userId, cardsGenerated: Math.min(generatedCards.length, cardCount) };
  } catch (error: any) {
    functions.logger.error("Card generation failed", { userId, error: error.message });
    return { userId, cardsGenerated: 0, error: error.message };
  }
}

async function sendToDLQ(userId: string, error: string, jobType: string): Promise<void> {
  await db.collection(DLQ_COLLECTION).add({
    userId,
    jobType,
    error,
    retryCount: 0,
    maxRetries: 3,
    createdAt: new Date(),
    nextRetryAt: new Date(Date.now() + 300000), // 5 min
    status: "pending",
  });
}

// Main scheduled function — runs per timezone bucket
export const dailyCardsUtcZero = functions.pubsub
  .schedule("0 2 * * *")
  .timeZone("UTC")
  .onRun(async () => {
    return processCardsForBucket("utc_zero");
  });

export const dailyCardsUtcPlus3 = functions.pubsub
  .schedule("0 23 * * *")
  .timeZone("UTC")
  .onRun(async () => {
    return processCardsForBucket("utc_plus_3");
  });

export const dailyCardsUtcPlus8 = functions.pubsub
  .schedule("0 18 * * *")
  .timeZone("UTC")
  .onRun(async () => {
    return processCardsForBucket("utc_plus_8");
  });

export const dailyCardsUtcMinus = functions.pubsub
  .schedule("0 7 * * *")
  .timeZone("UTC")
  .onRun(async () => {
    return processCardsForBucket("utc_minus");
  });

async function processCardsForBucket(bucketId: string): Promise<void> {
  const startTime = Date.now();
  let totalProcessed = 0;
  let totalCards = 0;
  let totalErrors = 0;
  let lastDocId: string | undefined;

  functions.logger.info(`Daily cards batch started for bucket: ${bucketId}`);

  while (true) {
    const users = await getUsersForBucket(bucketId, lastDocId);
    if (users.length === 0) break;

    const results = await Promise.allSettled(
      users.map((userDoc) => generateCardsForUser(userDoc.id))
    );

    for (const result of results) {
      if (result.status === "fulfilled") {
        totalProcessed++;
        totalCards += result.value.cardsGenerated;
        if (result.value.error) {
          totalErrors++;
          await sendToDLQ(result.value.userId, result.value.error, "daily_cards");
        }
      } else {
        totalErrors++;
      }
    }

    lastDocId = users[users.length - 1].id;
    if (users.length < BATCH_SIZE) break;

    // Cost guard: max 10 min
    if (Date.now() - startTime > 540000) {
      functions.logger.warn("Daily cards batch timed out", { bucketId, totalProcessed });
      break;
    }
  }

  // Log cost tracking
  await db.collection("batchJobLogs").add({
    jobType: "daily_cards",
    bucketId,
    totalProcessed,
    totalCards,
    totalErrors,
    durationMs: Date.now() - startTime,
    completedAt: new Date(),
  });

  functions.logger.info("Daily cards batch complete", { bucketId, totalProcessed, totalCards, totalErrors });
}

// DLQ retry processor
export const retryDLQ = functions.pubsub
  .schedule("every 15 minutes")
  .onRun(async () => {
    const now = new Date();
    const pending = await db.collection(DLQ_COLLECTION)
      .where("status", "==", "pending")
      .where("nextRetryAt", "<=", now)
      .limit(20)
      .get();

    for (const doc of pending.docs) {
      const data = doc.data();
      if (data.retryCount >= data.maxRetries) {
        await doc.ref.update({ status: "failed", updatedAt: now });
        continue;
      }

      try {
        if (data.jobType === "daily_cards") {
          await generateCardsForUser(data.userId);
        }
        await doc.ref.update({ status: "completed", updatedAt: now });
      } catch {
        await doc.ref.update({
          retryCount: data.retryCount + 1,
          nextRetryAt: new Date(Date.now() + 300000 * (data.retryCount + 1)),
          updatedAt: now,
        });
      }
    }
  });
```

### 6.2 Streak Update Job

```typescript
// functions/src/scheduled/streakUpdate.ts
import * as functions from "firebase-functions";
import { db, redis } from "../config";
import { sendNotification } from "../services/notificationService";
import { awardXp } from "../services/gamificationService";

const BATCH_SIZE = 100;

export const midnightStreakUpdate = functions.pubsub
  .schedule("0 0 * * *")
  .timeZone("UTC")
  .onRun(async () => {
    const startTime = Date.now();
    let processed = 0;
    let streaksKept = 0;
    let streaksBroken = 0;
    let freezesUsed = 0;
    let lastDocId: string | undefined;

    functions.logger.info("Streak update job started");

    const today = new Date().toISOString().slice(0, 10);
    const yesterday = new Date(Date.now() - 86400000).toISOString().slice(0, 10);

    while (true) {
      let query: FirebaseFirestore.Query = db.collectionGroup("gamification")
        .where("__name__", ">=", "stats")
        .where("__name__", "<=", "stats")
        .limit(BATCH_SIZE);

      // Note: collection group pagination requires different approach
      const snapshot = await query.get();
      if (snapshot.empty) break;

      for (const doc of snapshot.docs) {
        const stats = doc.data();
        const userId = doc.ref.parent.parent?.id;
        if (!userId) continue;

        const lastActive = stats.lastActiveDate || "";
        processed++;

        if (lastActive === today || lastActive === yesterday) {
          // User was active, streak continues
          if (lastActive === yesterday && stats.currentStreak > 0) {
            streaksKept++;
            // Award streak XP
            await awardXp(userId, "streak_day", 5);
          }
          continue;
        }

        // User missed a day
        if (stats.freezesAvailable > 0 && stats.currentStreak > 0) {
          // Auto-use streak freeze
          await doc.ref.update({
            freezesAvailable: stats.freezesAvailable - 1,
            freezesUsedThisMonth: (stats.freezesUsedThisMonth || 0) + 1,
            updatedAt: new Date(),
          });
          freezesUsed++;

          await sendNotification({
            userId,
            title: "Streak Freeze Used",
            body: `Your ${stats.currentStreak}-day streak was saved! ${stats.freezesAvailable - 1} freezes left.`,
            type: "streak",
            locale: "en",
          });
        } else if (stats.currentStreak > 2) {
          // Break streak only if it was meaningful
          await doc.ref.update({ currentStreak: 0, updatedAt: new Date() });
          streaksBroken++;

          await sendNotification({
            userId,
            title: "Streak Lost",
            body: `Your ${stats.currentStreak}-day streak ended. Start a new one today!`,
            type: "streak",
            locale: "en",
          });
        }

        await redis.del(`gamification:profile:${userId}`);
      }

      // Simple pagination: break after first batch for collection group
      break;
    }

    await db.collection("batchJobLogs").add({
      jobType: "streak_update",
      processed,
      streaksKept,
      streaksBroken,
      freezesUsed,
      durationMs: Date.now() - startTime,
      completedAt: new Date(),
    });

    functions.logger.info("Streak update complete", { processed, streaksKept, streaksBroken, freezesUsed });
  });

// Weekly stats reset (every Monday at midnight UTC)
export const weeklyStatsReset = functions.pubsub
  .schedule("0 0 * * 1")
  .timeZone("UTC")
  .onRun(async () => {
    let processed = 0;
    const snapshot = await db.collectionGroup("gamification")
      .where("__name__", ">=", "stats")
      .where("__name__", "<=", "stats")
      .limit(500)
      .get();

    const batch = db.batch();
    for (const doc of snapshot.docs) {
      batch.update(doc.ref, {
        weeklyStats: { cardsCompleted: 0, messagesGenerated: 0, xpEarned: 0 },
        updatedAt: new Date(),
      });
      processed++;
    }
    await batch.commit();

    functions.logger.info("Weekly stats reset", { processed });
  });

// Monthly freeze replenishment (1st of month)
export const monthlyFreezeReplenish = functions.pubsub
  .schedule("0 1 1 * *")
  .timeZone("UTC")
  .onRun(async () => {
    const freezesByTier = { free: 0, pro: 2, legend: 5 };
    let processed = 0;

    const usersSnap = await db.collection("users")
      .where("onboardingComplete", "==", true)
      .limit(500)
      .get();

    const batch = db.batch();
    for (const userDoc of usersSnap.docs) {
      const tier = userDoc.data().tier || "free";
      const freezes = freezesByTier[tier as keyof typeof freezesByTier] || 0;
      if (freezes === 0) continue;

      const statsRef = db.collection("users").doc(userDoc.id).collection("gamification").doc("stats");
      batch.set(statsRef, {
        freezesAvailable: freezes,
        freezesUsedThisMonth: 0,
        monthlyStats: { cardsCompleted: 0, messagesGenerated: 0, xpEarned: 0, giftsGiven: 0 },
        updatedAt: new Date(),
      }, { merge: true });
      processed++;
    }
    await batch.commit();

    functions.logger.info("Monthly freeze replenish complete", { processed });
  });
```

### 6.3 Subscription Expiry Job

```typescript
// functions/src/scheduled/subscriptionExpiry.ts
import * as functions from "firebase-functions";
import { db, redis } from "../config";
import { downgradeToFree } from "../services/subscriptionService";
import { sendNotification } from "../services/notificationService";

export const checkSubscriptionExpiry = functions.pubsub
  .schedule("0 3 * * *")
  .timeZone("UTC")
  .onRun(async () => {
    const now = new Date();
    const oneDayFromNow = new Date(Date.now() + 86400000);
    const threeDaysFromNow = new Date(Date.now() + 3 * 86400000);
    const sevenDaysFromNow = new Date(Date.now() + 7 * 86400000);

    let reminders7d = 0, reminders3d = 0, reminders1d = 0, expired = 0, billingIssues = 0;

    // 7-day reminder
    const sevenDaySnap = await db.collectionGroup("subscription")
      .where("active", "==", true)
      .where("autoRenew", "==", false)
      .where("expiresAt", "<=", sevenDaysFromNow)
      .where("expiresAt", ">", threeDaysFromNow)
      .limit(200)
      .get();

    for (const doc of sevenDaySnap.docs) {
      const userId = doc.ref.parent.parent?.id;
      if (!userId) continue;
      const data = doc.data();
      if (data.reminder7dSent) continue;

      await sendNotification({
        userId,
        title: "Subscription Expiring Soon",
        body: "Your premium subscription expires in 7 days. Renew to keep full access.",
        type: "subscription",
        locale: "en",
      });
      await doc.ref.update({ reminder7dSent: true, updatedAt: new Date() });
      reminders7d++;
    }

    // 3-day reminder
    const threeDaySnap = await db.collectionGroup("subscription")
      .where("active", "==", true)
      .where("autoRenew", "==", false)
      .where("expiresAt", "<=", threeDaysFromNow)
      .where("expiresAt", ">", oneDayFromNow)
      .limit(200)
      .get();

    for (const doc of threeDaySnap.docs) {
      const userId = doc.ref.parent.parent?.id;
      if (!userId) continue;
      const data = doc.data();
      if (data.reminder3dSent) continue;

      await sendNotification({
        userId,
        title: "3 Days Left on Premium",
        body: "Your subscription expires in 3 days. Don't lose your streak freezes and premium features!",
        type: "subscription",
        locale: "en",
      });
      await doc.ref.update({ reminder3dSent: true, updatedAt: new Date() });
      reminders3d++;
    }

    // 1-day reminder
    const oneDaySnap = await db.collectionGroup("subscription")
      .where("active", "==", true)
      .where("autoRenew", "==", false)
      .where("expiresAt", "<=", oneDayFromNow)
      .where("expiresAt", ">", now)
      .limit(200)
      .get();

    for (const doc of oneDaySnap.docs) {
      const userId = doc.ref.parent.parent?.id;
      if (!userId) continue;
      const data = doc.data();
      if (data.reminder1dSent) continue;

      await sendNotification({
        userId,
        title: "Last Day of Premium!",
        body: "Your subscription expires tomorrow. Renew now to avoid losing access.",
        type: "subscription",
        locale: "en",
      });
      await doc.ref.update({ reminder1dSent: true, updatedAt: new Date() });
      reminders1d++;
    }

    // Expired subscriptions — downgrade
    const expiredSnap = await db.collectionGroup("subscription")
      .where("active", "==", true)
      .where("expiresAt", "<=", now)
      .limit(200)
      .get();

    for (const doc of expiredSnap.docs) {
      const userId = doc.ref.parent.parent?.id;
      if (!userId) continue;

      try {
        await downgradeToFree(userId);
        expired++;
        functions.logger.info("Subscription expired, downgraded", { userId });
      } catch (err: any) {
        functions.logger.error("Failed to downgrade expired sub", { userId, error: err.message });
      }
    }

    // Billing issues — check grace period (7 days)
    const billingSnap = await db.collectionGroup("subscription")
      .where("billingIssue", "==", true)
      .where("active", "==", true)
      .limit(200)
      .get();

    for (const doc of billingSnap.docs) {
      const data = doc.data();
      const userId = doc.ref.parent.parent?.id;
      if (!userId) continue;

      const issueDate = data.billingIssueDetectedAt?.toDate() || now;
      const daysSinceIssue = (now.getTime() - issueDate.getTime()) / 86400000;

      if (daysSinceIssue >= 7) {
        await downgradeToFree(userId);
        await doc.ref.update({ billingIssue: false, billingGraceExpired: true, updatedAt: new Date() });
        billingIssues++;
      } else if (daysSinceIssue >= 3 && !data.billingReminder2Sent) {
        await sendNotification({
          userId,
          title: "Payment Still Failing",
          body: "Your payment issue hasn't been resolved. Update your payment method to avoid losing premium access.",
          type: "subscription",
          locale: "en",
        });
        await doc.ref.update({ billingReminder2Sent: true, updatedAt: new Date() });
      }
    }

    await db.collection("batchJobLogs").add({
      jobType: "subscription_expiry",
      reminders7d,
      reminders3d,
      reminders1d,
      expired,
      billingIssues,
      durationMs: Date.now() - now.getTime(),
      completedAt: new Date(),
    });

    functions.logger.info("Subscription expiry check complete", { reminders7d, reminders3d, reminders1d, expired, billingIssues });
  });
```

---

## 7. Updated Exports & Route Registration

### 7.1 Updated app.ts Routes

```typescript
// Add to functions/src/app.ts — new imports and routes

import subscriptionsRouter from "./api/subscriptions";
import revenuecatWebhook from "./webhooks/revenuecat";

// Add BEFORE authMiddleware (webhook needs its own auth):
app.use("/api/v1/webhooks/revenuecat", revenuecatWebhook);

// Add WITH authMiddleware:
app.use("/api/v1/subscriptions", authMiddleware, rateLimitMiddleware, subscriptionsRouter);
```

### 7.2 Updated index.ts Exports

```typescript
// Add to functions/src/index.ts

import {
  dailyCardsUtcZero,
  dailyCardsUtcPlus3,
  dailyCardsUtcPlus8,
  dailyCardsUtcMinus,
  retryDLQ,
} from "./scheduled/dailyCards";

import {
  midnightStreakUpdate,
  weeklyStatsReset,
  monthlyFreezeReplenish,
} from "./scheduled/streakUpdate";

import { checkSubscriptionExpiry } from "./scheduled/subscriptionExpiry";

// Scheduled exports
export const scheduledDailyCardsUtcZero = dailyCardsUtcZero;
export const scheduledDailyCardsUtcPlus3 = dailyCardsUtcPlus3;
export const scheduledDailyCardsUtcPlus8 = dailyCardsUtcPlus8;
export const scheduledDailyCardsUtcMinus = dailyCardsUtcMinus;
export const scheduledRetryDLQ = retryDLQ;
export const scheduledStreakUpdate = midnightStreakUpdate;
export const scheduledWeeklyStatsReset = weeklyStatsReset;
export const scheduledMonthlyFreezeReplenish = monthlyFreezeReplenish;
export const scheduledSubscriptionExpiry = checkSubscriptionExpiry;
```

### 7.3 New Firestore Indexes Required

```json
{
  "indexes": [
    {
      "collectionGroup": "subscription",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "active", "order": "ASCENDING" },
        { "fieldPath": "autoRenew", "order": "ASCENDING" },
        { "fieldPath": "expiresAt", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "subscription",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "active", "order": "ASCENDING" },
        { "fieldPath": "expiresAt", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "subscription",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "billingIssue", "order": "ASCENDING" },
        { "fieldPath": "active", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "usage",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "updatedAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "actionCards",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "type", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

### 7.4 Environment Variables Required

```env
# RevenueCat
REVENUECAT_WEBHOOK_SECRET=rc_whsec_...
REVENUECAT_API_KEY=appl_...

# Internal
INTERNAL_API_KEY=lolo_internal_...
AI_ROUTER_INTERNAL_URL=http://localhost:5001/api/v1/ai/route

# Encryption (from Sprint 1)
ENCRYPTION_KEY=base64_encoded_32_byte_key
```

---

**End of Sprint 4 Backend Implementation — Raj Patel**
