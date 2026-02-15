// functions/src/scheduled/streakUpdate.ts
import * as functions from "firebase-functions/v2";
import { db } from "../config";
import { sendTemplatedNotification } from "../services/notificationService";
import { SupportedLocale } from "../types";

export const streakUpdate = functions.scheduler.onSchedule(
  { schedule: "0 * * * *", timeoutSeconds: 120, memory: "512MiB" },
  async () => {
    const now = new Date();
    const currentHourUTC = now.getUTCHours();
    const targetOffset = -currentHourUTC;

    // Users whose midnight just passed (check at 1 AM local = offset+1)
    const checkOffset = -(currentHourUTC - 1);

    const yesterday = new Date(now.getTime() - 86400000).toISOString().split("T")[0];
    const twoDaysAgo = new Date(now.getTime() - 2 * 86400000).toISOString().split("T")[0];

    const gamSnap = await db.collection("gamification").get();

    for (const doc of gamSnap.docs) {
      const data = doc.data();
      const userId = doc.id;
      const lastActive = data.lastActiveDate;
      const currentStreak = data.currentStreak || 0;

      if (currentStreak === 0) continue;
      if (lastActive === yesterday || lastActive === now.toISOString().split("T")[0]) continue;

      // User missed yesterday
      if (lastActive === twoDaysAgo || (lastActive && lastActive < twoDaysAgo)) {
        // Check for streak freeze
        if (data.freezesAvailable > 0 && lastActive === twoDaysAgo) {
          await doc.ref.update({
            freezesAvailable: data.freezesAvailable - 1,
            freezesUsedThisMonth: (data.freezesUsedThisMonth || 0) + 1,
            lastFreezeUsed: now.toISOString(),
          });

          functions.logger.info("Streak freeze applied", { userId, streak: currentStreak });
          continue;
        }

        // Reset streak
        await doc.ref.update({
          currentStreak: 0,
          streakBrokenAt: now.toISOString(),
          previousStreak: currentStreak,
        });

        functions.logger.info("Streak reset", { userId, previousStreak: currentStreak });
      }

      // Send "streak at risk" notification if active yesterday but not today yet
      if (lastActive === yesterday && currentStreak >= 3) {
        const userDoc = await db.collection("users").doc(userId).get();
        if (!userDoc.exists) continue;
        const locale: SupportedLocale = userDoc.data()!.language || "en";

        await sendTemplatedNotification(
          userId,
          "streak_at_risk",
          { streakDays: String(currentStreak) },
          locale,
          { type: "gamification" }
        );
      }
    }

    functions.logger.info("Streak update complete");
  }
);
