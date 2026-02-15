// functions/src/scheduled/reminderCheck.ts
import * as functions from "firebase-functions/v2";
import { db } from "../config";
import { sendTemplatedNotification } from "../services/notificationService";
import { SupportedLocale } from "../types";

export const reminderCheck = functions.scheduler.onSchedule(
  { schedule: "every 15 minutes", timeoutSeconds: 120, memory: "512MiB" },
  async () => {
    const now = new Date();
    const todayStr = now.toISOString().split("T")[0];

    // Query active reminders
    const remindersSnap = await db.collection("reminders")
      .where("status", "==", "active")
      .get();

    for (const doc of remindersSnap.docs) {
      const reminder = doc.data();
      const eventDate = new Date(reminder.date);
      const daysUntil = Math.ceil((eventDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
      const tiers: number[] = reminder.reminderTiers || [7, 3, 1, 0];

      // Check if snoozed
      if (reminder.snoozedUntil && new Date(reminder.snoozedUntil) > now) continue;

      // Determine which tier to fire
      let templateKey: string | null = null;
      if (daysUntil === 0 && tiers.includes(0)) templateKey = "reminder_day_of";
      else if (daysUntil === 1 && tiers.includes(1)) templateKey = "reminder_1d";
      else if (daysUntil === 3 && tiers.includes(3)) templateKey = "reminder_3d";
      else if (daysUntil === 7 && tiers.includes(7)) templateKey = "reminder_7d";

      if (!templateKey) continue;

      // Dedup: check if already sent today
      const sentKey = `reminder_sent:${doc.id}:${templateKey}:${todayStr}`;
      const sentDoc = await db.collection("reminder_sent_log").doc(sentKey).get();
      if (sentDoc.exists) continue;

      // Get user language
      const userDoc = await db.collection("users").doc(reminder.userId).get();
      const locale: SupportedLocale = userDoc.data()?.language || "en";

      // Get partner name
      let partnerName = "her";
      if (reminder.linkedProfileId) {
        const profileDoc = await db.collection("profiles").doc(reminder.linkedProfileId).get();
        if (profileDoc.exists) partnerName = profileDoc.data()!.name;
      }

      await sendTemplatedNotification(
        reminder.userId,
        templateKey,
        { eventName: reminder.title, partnerName },
        locale,
        { reminderId: doc.id, type: "reminder" }
      );

      // Log to prevent re-sending
      await db.collection("reminder_sent_log").doc(sentKey).set({
        reminderId: doc.id,
        templateKey,
        sentAt: now.toISOString(),
      });
    }

    functions.logger.info("Reminder check complete", { processed: remindersSnap.size });
  }
);
