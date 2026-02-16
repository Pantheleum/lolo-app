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
    return res.json(response);
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
    return res.json(offerings);
  } catch (err) {
    next(err);
  }
});

export default router;
