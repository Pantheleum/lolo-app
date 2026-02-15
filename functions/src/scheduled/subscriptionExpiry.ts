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
