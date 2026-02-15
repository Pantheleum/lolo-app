// functions/src/index.ts
import * as functions from "firebase-functions/v2";
import app from "./app";
import { db } from "./config";
import { processPendingNotifications } from "./services/notificationScheduler";
import { fullCalendarSync } from "./services/calendarSync";
import { sendTemplatedNotification } from "./services/notificationService";
import { SupportedLocale } from "./types";

// --- HTTP API ---
export const api = functions.https.onRequest(
  { cors: true, memory: "512MiB", timeoutSeconds: 60, region: "us-central1" },
  app
);

// --- Scheduled Functions ---
export { reminderCheck } from "./scheduled/reminderCheck";
export { dailyCardsGeneration } from "./scheduled/dailyCards";
export { streakUpdate } from "./scheduled/streakUpdate";

// --- Sprint 2: Notification processor (runs every 5 minutes) ---
export const notificationProcessor = functions.scheduler.onSchedule(
  { schedule: "every 5 minutes", timeoutSeconds: 120, memory: "512MiB" },
  async () => {
    const sent = await processPendingNotifications();
    functions.logger.info("Notification processor complete", { sent });
  }
);

// --- Sprint 2: Calendar sync trigger (runs every 6 hours) ---
export const calendarSyncJob = functions.scheduler.onSchedule(
  { schedule: "0 */6 * * *", timeoutSeconds: 300, memory: "512MiB" },
  async () => {
    // Find users with connected Google Calendar
    const tokenSnap = await db.collection("oauth_tokens")
      .where("provider", "==", "google").get();

    let synced = 0;
    let failed = 0;

    for (const doc of tokenSnap.docs) {
      const userId = doc.id.replace("_google", "");
      try {
        const result = await fullCalendarSync(userId);
        functions.logger.info("Calendar sync complete", {
          userId, exported: result.exported,
          imported: result.imported, conflicts: result.conflicts,
        });
        synced++;
      } catch (err) {
        functions.logger.error("Calendar sync failed", { userId, error: err });
        failed++;
      }
    }

    functions.logger.info("Calendar sync job complete", { synced, failed });
  }
);

// --- Sprint 2: Streak risk notification (runs daily at 8 PM UTC) ---
export const streakRiskCheck = functions.scheduler.onSchedule(
  { schedule: "0 20 * * *", timeoutSeconds: 120, memory: "256MiB" },
  async () => {
    const today = new Date().toISOString().split("T")[0];
    const gamSnap = await db.collection("gamification")
      .where("currentStreak", ">", 0).get();

    let notified = 0;

    for (const doc of gamSnap.docs) {
      const data = doc.data();
      if (data.lastActiveDate === today) continue; // Already active today

      const userId = doc.id;
      const userDoc = await db.collection("users").doc(userId).get();
      if (!userDoc.exists) continue;

      const locale: SupportedLocale = userDoc.data()?.language || "en";

      await sendTemplatedNotification(
        userId, "streak_at_risk",
        { streakDays: String(data.currentStreak) },
        locale,
        { type: "streak", streakDays: String(data.currentStreak) }
      );
      notified++;
    }

    functions.logger.info("Streak risk check complete", { notified });
  }
);
