// functions/src/api/settings.ts
import { Router, Response, NextFunction } from "express";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

const router = Router();

const DEFAULT_SETTINGS = {
  language: "en",
  theme: "system",
  notifications: {
    enabled: true,
    reminders: true,
    dailyCards: true,
    weeklyReport: true,
    promotions: false,
    quietHoursStart: null as string | null,
    quietHoursEnd: null as string | null,
  },
};

// ============================================================
// Helper: invalidate settings cache
// ============================================================
async function invalidateSettingsCache(uid: string): Promise<void> {
  await redis.del(`settings:${uid}`);
}

// ============================================================
// GET /settings — returns user settings
// ============================================================
router.get("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;

    const cacheKey = `settings:${uid}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    const settingsDoc = await db
      .collection("users")
      .doc(uid)
      .collection("settings")
      .doc("preferences")
      .get();

    let settings;
    if (!settingsDoc.exists) {
      // Return defaults if no settings document exists yet
      settings = { ...DEFAULT_SETTINGS };
    } else {
      settings = { ...DEFAULT_SETTINGS, ...settingsDoc.data() };
    }

    const response = { data: settings };

    await redis.setex(cacheKey, 600, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// PUT /settings — updates user settings (language, notifications, theme)
// ============================================================
router.put("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { language, theme, notifications } = req.body;

    const updates: Record<string, any> = {
      updatedAt: new Date().toISOString(),
    };

    if (language !== undefined) {
      const validLanguages = ["en", "ar", "ms"];
      if (!validLanguages.includes(language)) {
        throw new AppError(400, "INVALID_LANGUAGE", `language must be one of: ${validLanguages.join(", ")}`);
      }
      updates.language = language;
    }

    if (theme !== undefined) {
      const validThemes = ["light", "dark", "system"];
      if (!validThemes.includes(theme)) {
        throw new AppError(400, "INVALID_THEME", `theme must be one of: ${validThemes.join(", ")}`);
      }
      updates.theme = theme;
    }

    if (notifications !== undefined) {
      if (typeof notifications !== "object" || notifications === null) {
        throw new AppError(400, "INVALID_NOTIFICATIONS", "notifications must be an object");
      }
      // Merge notification preferences
      const settingsDoc = await db
        .collection("users")
        .doc(uid)
        .collection("settings")
        .doc("preferences")
        .get();

      const currentNotifications = settingsDoc.exists
        ? settingsDoc.data()?.notifications || DEFAULT_SETTINGS.notifications
        : DEFAULT_SETTINGS.notifications;

      updates.notifications = { ...currentNotifications, ...notifications };
    }

    await db
      .collection("users")
      .doc(uid)
      .collection("settings")
      .doc("preferences")
      .set(updates, { merge: true });

    await invalidateSettingsCache(uid);

    // Return the full updated settings
    const updatedDoc = await db
      .collection("users")
      .doc(uid)
      .collection("settings")
      .doc("preferences")
      .get();

    const settings = { ...DEFAULT_SETTINGS, ...updatedDoc.data() };

    res.json({ data: settings });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// PUT /settings/notifications — updates notification preferences
// ============================================================
router.put("/notifications", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const {
      enabled,
      reminders,
      dailyCards,
      weeklyReport,
      promotions,
      quietHoursStart,
      quietHoursEnd,
    } = req.body;

    // Build notification updates from provided fields only
    const notificationUpdates: Record<string, any> = {};

    if (enabled !== undefined) notificationUpdates.enabled = Boolean(enabled);
    if (reminders !== undefined) notificationUpdates.reminders = Boolean(reminders);
    if (dailyCards !== undefined) notificationUpdates.dailyCards = Boolean(dailyCards);
    if (weeklyReport !== undefined) notificationUpdates.weeklyReport = Boolean(weeklyReport);
    if (promotions !== undefined) notificationUpdates.promotions = Boolean(promotions);
    if (quietHoursStart !== undefined) notificationUpdates.quietHoursStart = quietHoursStart;
    if (quietHoursEnd !== undefined) notificationUpdates.quietHoursEnd = quietHoursEnd;

    if (Object.keys(notificationUpdates).length === 0) {
      throw new AppError(400, "NO_UPDATES", "No notification fields provided to update");
    }

    // Get current notifications and merge
    const settingsDoc = await db
      .collection("users")
      .doc(uid)
      .collection("settings")
      .doc("preferences")
      .get();

    const currentNotifications = settingsDoc.exists
      ? settingsDoc.data()?.notifications || DEFAULT_SETTINGS.notifications
      : DEFAULT_SETTINGS.notifications;

    const mergedNotifications = { ...currentNotifications, ...notificationUpdates };

    await db
      .collection("users")
      .doc(uid)
      .collection("settings")
      .doc("preferences")
      .set(
        {
          notifications: mergedNotifications,
          updatedAt: new Date().toISOString(),
        },
        { merge: true }
      );

    await invalidateSettingsCache(uid);

    res.json({
      data: {
        notifications: mergedNotifications,
        updatedAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

export default router;
