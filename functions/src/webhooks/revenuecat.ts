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
    return res.status(200).json({ status: "ok", eventId });
  } catch (err) {
    next(err);
  }
});

export default router;
