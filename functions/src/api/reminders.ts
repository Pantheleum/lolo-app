// functions/src/api/reminders.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import {
  createReminderSchema,
  updateReminderSchema,
  snoozeReminderSchema,
  completeReminderSchema,
} from "../validators/schemas";
import { awardXp } from "../services/gamificationService";
import {
  scheduleReminderNotifications,
  cancelReminderNotifications,
  rescheduleReminderNotifications,
} from "../services/notificationScheduler";
import {
  computeNextOccurrence,
  validateRecurrenceRule,
  RecurrenceRule,
} from "../services/recurrenceEngine";

const router = Router();

// ============================================================
// Helper: invalidate all reminder caches for a user
// ============================================================
async function invalidateReminderCaches(uid: string): Promise<void> {
  const keys = await redis.keys(`reminders:*:${uid}:*`);
  if (keys.length > 0) await redis.del(...keys);
  const upcomingKeys = await redis.keys(`reminders:upcoming:${uid}:*`);
  if (upcomingKeys.length > 0) await redis.del(...upcomingKeys);
}

// ============================================================
// Helper: get user timezone from settings
// ============================================================
async function getUserTimezone(uid: string): Promise<string> {
  const cached = await redis.get(`user:tz:${uid}`);
  if (cached) return cached;

  const settingsDoc = await db.collection("users").doc(uid).get();
  const tz = settingsDoc.data()?.settings?.timezone || "UTC";
  await redis.setex(`user:tz:${uid}`, 3600, tz);
  return tz;
}

// ============================================================
// GET /reminders -- list with filters, pagination
// ============================================================
router.get("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { type, status, limit: limitStr, lastDocId, startDate, endDate } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);
    const filterStatus = (status as string) || "active";
    const filterType = type as string | undefined;

    // Cache key
    const cacheKey = `reminders:list:${req.user.uid}:${filterType || "all"}:${filterStatus}:${lastDocId || "start"}`;
    const cached = await redis.get(cacheKey);
    if (cached) {
      return res.json(JSON.parse(cached));
    }

    // Build query
    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .where("deletedAt", "==", null);

    if (filterStatus !== "all") {
      if (filterStatus === "active") {
        query = query.where("completed", "==", false);
      } else if (filterStatus === "completed") {
        query = query.where("completed", "==", true);
      } else if (filterStatus === "snoozed") {
        query = query.where("snoozedUntil", "!=", null);
      }
    }

    if (filterType && filterType !== "all") {
      query = query.where("category", "==", filterType);
    }

    if (startDate) {
      query = query.where("date", ">=", startDate as string);
    }
    if (endDate) {
      query = query.where("date", "<=", endDate as string);
    }

    query = query.orderBy("date", "asc");

    // Cursor pagination
    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(req.user.uid)
        .collection("reminders")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) {
        query = query.startAfter(lastDoc);
      }
    }

    query = query.limit(limit + 1);
    const snapshot = await query.get();
    const docs = snapshot.docs.slice(0, limit);
    const hasMore = snapshot.docs.length > limit;

    // Total count
    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .where("deletedAt", "==", null)
      .count()
      .get();

    const data = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        userId: req.user.uid,
        title: d.title,
        description: d.notes || null,
        type: d.category,
        date: d.date,
        time: d.time || null,
        isRecurring: d.recurrence !== "none",
        recurrenceRule: d.recurrence,
        reminderTiers: d.reminderTiers || [7, 3, 1, 0],
        status: d.completed ? "completed" : d.snoozedUntil ? "snoozed" : "active",
        snoozedUntil: d.snoozedUntil || null,
        linkedProfileId: d.partnerProfileId || null,
        linkedGiftSuggestion: d.giftSuggest || false,
        createdAt: d.createdAt,
        updatedAt: d.updatedAt,
      };
    });

    const response = {
      data,
      pagination: {
        hasMore,
        lastDocId: docs.length > 0 ? docs[docs.length - 1].id : null,
        totalCount: countSnap.data().count,
      },
    };

    await redis.setex(cacheKey, 120, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /reminders -- create with recurrence + escalation setup
// ============================================================
router.post("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createReminderSchema.parse(req.body);

    // Validate recurrence rule
    if (body.isRecurring && body.recurrenceRule !== "none") {
      const valid = validateRecurrenceRule(body.recurrenceRule, body.date);
      if (!valid.isValid) {
        throw new AppError(400, "INVALID_RECURRENCE", valid.error!);
      }
    }

    // Validate date is not in the past for non-recurring
    const eventDate = new Date(body.date);
    const now = new Date();
    if (!body.isRecurring && eventDate < now) {
      throw new AppError(400, "INVALID_DATE", "Date cannot be in the past for non-recurring reminders");
    }

    const timezone = await getUserTimezone(req.user.uid);
    const reminderId = uuidv4();
    const reminderTiers = body.reminderTiers || [7, 3, 1, 0];

    const reminderData = {
      title: body.title,
      notes: body.description || null,
      category: body.type,
      date: body.date,
      time: body.time || null,
      recurrence: body.isRecurring ? body.recurrenceRule : "none",
      reminderTiers,
      completed: false,
      snoozedUntil: null,
      escalationSent: { "7d": false, "3d": false, "1d": false, same: false },
      giftSuggest: body.type === "birthday" || body.type === "anniversary",
      partnerProfileId: body.linkedProfileId || null,
      deletedAt: null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };

    await db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .doc(reminderId)
      .set(reminderData);

    // Schedule escalation notifications
    const scheduledNotifications = await scheduleReminderNotifications({
      userId: req.user.uid,
      reminderId,
      eventTitle: body.title,
      eventDate: body.date,
      eventTime: body.time || null,
      tiers: reminderTiers,
      timezone,
      linkedProfileId: body.linkedProfileId || null,
    });

    await invalidateReminderCaches(req.user.uid);

    res.status(201).json({
      data: {
        id: reminderId,
        title: body.title,
        type: body.type,
        date: body.date,
        reminderTiers,
        status: "active",
        scheduledNotifications,
        createdAt: reminderData.createdAt,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Validation failed", { errors: err.errors }));
    }
    next(err);
  }
});

// ============================================================
// PUT /reminders/:id -- update (owner validation)
// ============================================================
router.put("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updateReminderSchema.parse(req.body);

    const reminderRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .doc(id);

    const reminderDoc = await reminderRef.get();
    if (!reminderDoc.exists || reminderDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Reminder not found");
    }

    const updates: Record<string, any> = { updatedAt: new Date().toISOString() };

    if (body.title !== undefined) updates.title = body.title;
    if (body.description !== undefined) updates.notes = body.description;
    if (body.date !== undefined) updates.date = body.date;
    if (body.time !== undefined) updates.time = body.time;
    if (body.isRecurring !== undefined) {
      updates.recurrence = body.isRecurring ? (body.recurrenceRule || "yearly") : "none";
    }
    if (body.recurrenceRule !== undefined) updates.recurrence = body.recurrenceRule;
    if (body.reminderTiers !== undefined) updates.reminderTiers = body.reminderTiers;

    await reminderRef.update(updates);

    // Reschedule notifications if date or tiers changed
    if (body.date || body.reminderTiers || body.time) {
      const timezone = await getUserTimezone(req.user.uid);
      const current = reminderDoc.data()!;
      await cancelReminderNotifications(req.user.uid, id);
      await scheduleReminderNotifications({
        userId: req.user.uid,
        reminderId: id,
        eventTitle: body.title || current.title,
        eventDate: body.date || current.date,
        eventTime: body.time || current.time || null,
        tiers: body.reminderTiers || current.reminderTiers || [7, 3, 1, 0],
        timezone,
        linkedProfileId: current.partnerProfileId || null,
      });
    }

    await invalidateReminderCaches(req.user.uid);

    res.json({
      data: {
        id,
        title: body.title || reminderDoc.data()!.title,
        date: body.date || reminderDoc.data()!.date,
        updatedAt: updates.updatedAt,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Validation failed", { errors: err.errors }));
    }
    next(err);
  }
});

// ============================================================
// DELETE /reminders/:id -- soft delete
// ============================================================
router.delete("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;

    const reminderRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .doc(id);

    const reminderDoc = await reminderRef.get();
    if (!reminderDoc.exists || reminderDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Reminder not found");
    }

    // Soft delete
    await reminderRef.update({
      deletedAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    });

    // Cancel all scheduled notifications
    const cancelledCount = await cancelReminderNotifications(req.user.uid, id);

    await invalidateReminderCaches(req.user.uid);

    res.json({
      data: {
        message: "Reminder deleted",
        cancelledNotifications: cancelledCount,
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// POST /reminders/:id/snooze -- set snooze duration
// ============================================================
router.post("/:id/snooze", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = snoozeReminderSchema.parse(req.body);

    const reminderRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .doc(id);

    const reminderDoc = await reminderRef.get();
    if (!reminderDoc.exists || reminderDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Reminder not found");
    }

    // Calculate snooze end time
    const snoozeDurations: Record<string, number> = {
      "1h": 60 * 60 * 1000,
      "3h": 3 * 60 * 60 * 1000,
      "1d": 24 * 60 * 60 * 1000,
      "3d": 3 * 24 * 60 * 60 * 1000,
      "1w": 7 * 24 * 60 * 60 * 1000,
    };

    const durationMs = snoozeDurations[body.duration];
    if (!durationMs) {
      throw new AppError(400, "INVALID_DURATION", "Invalid snooze duration");
    }

    const snoozedUntil = new Date(Date.now() + durationMs).toISOString();

    await reminderRef.update({
      snoozedUntil,
      updatedAt: new Date().toISOString(),
    });

    // Calculate next notification after snooze
    const reminder = reminderDoc.data()!;
    const eventDate = new Date(reminder.date);
    const snoozeEnd = new Date(snoozedUntil);
    const daysUntilEvent = Math.ceil(
      (eventDate.getTime() - snoozeEnd.getTime()) / (1000 * 60 * 60 * 24)
    );

    const tiers: number[] = reminder.reminderTiers || [7, 3, 1, 0];
    const nextTier = tiers.find((t) => t <= daysUntilEvent) ?? 0;
    const nextNotificationDate = new Date(
      eventDate.getTime() - nextTier * 24 * 60 * 60 * 1000
    );
    const nextNotification =
      nextNotificationDate > snoozeEnd
        ? nextNotificationDate.toISOString()
        : snoozedUntil;

    await invalidateReminderCaches(req.user.uid);

    res.json({
      data: {
        id,
        status: "snoozed",
        snoozedUntil,
        nextNotification,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_DURATION", "Invalid snooze duration"));
    }
    next(err);
  }
});

// ============================================================
// POST /reminders/:id/complete -- mark complete + award XP
// ============================================================
router.post("/:id/complete", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = completeReminderSchema.parse(req.body);

    const reminderRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .doc(id);

    const reminderDoc = await reminderRef.get();
    if (!reminderDoc.exists || reminderDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Reminder not found");
    }

    const reminder = reminderDoc.data()!;
    if (reminder.completed) {
      throw new AppError(409, "ALREADY_COMPLETED", "Reminder already completed");
    }

    const now = new Date().toISOString();
    const updates: Record<string, any> = {
      completed: true,
      completedAt: now,
      completionNotes: body.notes || null,
      snoozedUntil: null,
      updatedAt: now,
    };

    await reminderRef.update(updates);

    // Award XP
    const xpResult = await awardXp(req.user.uid, "reminder_complete");

    // Cancel remaining scheduled notifications
    await cancelReminderNotifications(req.user.uid, id);

    // Handle recurrence: schedule next occurrence
    let nextOccurrence: string | null = null;
    if (reminder.recurrence && reminder.recurrence !== "none") {
      nextOccurrence = computeNextOccurrence(reminder.date, reminder.recurrence);
      if (nextOccurrence) {
        const nextReminderId = uuidv4();
        const timezone = await getUserTimezone(req.user.uid);

        await db
          .collection("users")
          .doc(req.user.uid)
          .collection("reminders")
          .doc(nextReminderId)
          .set({
            ...reminder,
            date: nextOccurrence,
            completed: false,
            completedAt: null,
            completionNotes: null,
            snoozedUntil: null,
            escalationSent: { "7d": false, "3d": false, "1d": false, same: false },
            deletedAt: null,
            createdAt: now,
            updatedAt: now,
          });

        // Schedule notifications for next occurrence
        await scheduleReminderNotifications({
          userId: req.user.uid,
          reminderId: nextReminderId,
          eventTitle: reminder.title,
          eventDate: nextOccurrence,
          eventTime: reminder.time || null,
          tiers: reminder.reminderTiers || [7, 3, 1, 0],
          timezone,
          linkedProfileId: reminder.partnerProfileId || null,
        });
      }
    }

    await invalidateReminderCaches(req.user.uid);

    res.json({
      data: {
        id,
        status: "completed",
        completedAt: now,
        xpAwarded: xpResult.xpAwarded,
        nextOccurrence,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    }
    next(err);
  }
});

// ============================================================
// GET /reminders/upcoming -- next 7/30 days grouped by date
// ============================================================
router.get("/upcoming", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const days = parseInt(req.query.days as string) || 7;
    if (![7, 30].includes(days)) {
      throw new AppError(400, "INVALID_REQUEST", "Days must be 7 or 30");
    }

    const cacheKey = `reminders:upcoming:${req.user.uid}:${days}`;
    const cached = await redis.get(cacheKey);
    if (cached) {
      return res.json(JSON.parse(cached));
    }

    const now = new Date();
    const endDate = new Date(now.getTime() + days * 24 * 60 * 60 * 1000);
    const nowStr = now.toISOString().split("T")[0];
    const endStr = endDate.toISOString().split("T")[0];

    const snapshot = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("reminders")
      .where("deletedAt", "==", null)
      .where("completed", "==", false)
      .where("date", ">=", nowStr)
      .where("date", "<=", endStr)
      .orderBy("date", "asc")
      .get();

    const urgencyLevels = (daysUntil: number): string => {
      if (daysUntil <= 0) return "critical";
      if (daysUntil <= 1) return "high";
      if (daysUntil <= 3) return "medium";
      return "low";
    };

    const suggestedActions: Record<string, string> = {
      critical: "Act now -- today is the day!",
      high: "Final preparations -- make it count tomorrow",
      medium: "Start planning her gift or surprise",
      low: "You have time, but start thinking ahead",
    };

    const data = snapshot.docs.map((doc) => {
      const d = doc.data();
      const eventDate = new Date(d.date);
      const daysUntil = Math.ceil(
        (eventDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24)
      );
      const urgency = urgencyLevels(daysUntil);

      return {
        id: doc.id,
        title: d.title,
        type: d.category,
        date: d.date,
        daysUntil,
        urgencyLevel: urgency,
        linkedProfileId: d.partnerProfileId || null,
        suggestedAction: suggestedActions[urgency],
      };
    });

    const nextEvent = data.length > 0 ? { title: data[0].title, daysUntil: data[0].daysUntil } : null;

    const response = {
      data,
      summary: {
        totalUpcoming: data.length,
        nextEvent,
      },
    };

    await redis.setex(cacheKey, 60, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

export default router;
