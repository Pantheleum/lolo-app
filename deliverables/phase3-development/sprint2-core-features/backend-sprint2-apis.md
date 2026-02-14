# LOLO Backend Implementation -- Sprint 2: Core Feature APIs

**Task ID:** S2-02
**Prepared by:** Raj Patel, Backend Developer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 2 -- Core Features (Weeks 11-12)
**Dependencies:** Sprint 1 Foundation (backend-functions-auth.md, backend-firebase-schema.md), API Contracts v1.0

---

## Table of Contents

1. [Reminder API Endpoints](#1-reminder-api-endpoints)
2. [Memory Vault API](#2-memory-vault-api)
3. [Partner Profile API](#3-partner-profile-api)
4. [Notification Scheduling Engine](#4-notification-scheduling-engine)
5. [Calendar Sync Service](#5-calendar-sync-service)
6. [Action Cards Daily Generation (Enhanced)](#6-action-cards-daily-generation-enhanced)
7. [New Zod Validation Schemas](#7-new-zod-validation-schemas)
8. [Updated Function Exports](#8-updated-function-exports)

---

## 1. Reminder API Endpoints

### api/reminders.ts

```typescript
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
```

### services/recurrenceEngine.ts

```typescript
// functions/src/services/recurrenceEngine.ts

export type RecurrenceRule = "none" | "daily" | "weekly" | "monthly" | "yearly";

interface RecurrenceValidation {
  isValid: boolean;
  error?: string;
}

/**
 * Validate a recurrence rule against an event date
 */
export function validateRecurrenceRule(
  rule: string,
  dateStr: string
): RecurrenceValidation {
  const validRules: RecurrenceRule[] = ["none", "daily", "weekly", "monthly", "yearly"];
  if (!validRules.includes(rule as RecurrenceRule)) {
    return { isValid: false, error: `Invalid recurrence rule: ${rule}` };
  }

  const date = new Date(dateStr);
  if (isNaN(date.getTime())) {
    return { isValid: false, error: "Invalid date format" };
  }

  return { isValid: true };
}

/**
 * Compute the next occurrence date based on recurrence rule
 */
export function computeNextOccurrence(
  currentDateStr: string,
  rule: RecurrenceRule,
  endDateStr?: string
): string | null {
  if (rule === "none") return null;

  const current = new Date(currentDateStr);
  let next: Date;

  switch (rule) {
    case "daily":
      next = new Date(current);
      next.setDate(next.getDate() + 1);
      break;
    case "weekly":
      next = new Date(current);
      next.setDate(next.getDate() + 7);
      break;
    case "monthly":
      next = new Date(current);
      next.setMonth(next.getMonth() + 1);
      // Handle month overflow (e.g., Jan 31 -> Feb 28)
      if (next.getDate() !== current.getDate()) {
        next.setDate(0); // last day of previous month
      }
      break;
    case "yearly":
      next = new Date(current);
      next.setFullYear(next.getFullYear() + 1);
      // Handle leap year (Feb 29 -> Feb 28)
      if (next.getMonth() !== current.getMonth()) {
        next.setDate(0);
      }
      break;
    default:
      return null;
  }

  // Check end date
  if (endDateStr) {
    const endDate = new Date(endDateStr);
    if (next > endDate) return null;
  }

  return next.toISOString().split("T")[0];
}

/**
 * Get all occurrences within a date range (for calendar view)
 */
export function getOccurrencesInRange(
  startDateStr: string,
  rule: RecurrenceRule,
  rangeStartStr: string,
  rangeEndStr: string,
  endDateStr?: string
): string[] {
  if (rule === "none") {
    const d = new Date(startDateStr);
    const rs = new Date(rangeStartStr);
    const re = new Date(rangeEndStr);
    return d >= rs && d <= re ? [startDateStr] : [];
  }

  const occurrences: string[] = [];
  let current = startDateStr;
  const rangeEnd = new Date(rangeEndStr);
  const rangeStart = new Date(rangeStartStr);
  let maxIterations = 366; // safety limit

  while (maxIterations-- > 0) {
    const currentDate = new Date(current);

    if (currentDate > rangeEnd) break;

    if (currentDate >= rangeStart) {
      occurrences.push(current);
    }

    const next = computeNextOccurrence(current, rule, endDateStr);
    if (!next) break;
    current = next;
  }

  return occurrences;
}
```

---

## 2. Memory Vault API

### api/memories.ts

```typescript
// functions/src/api/memories.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import * as admin from "firebase-admin";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import {
  createMemorySchema,
  updateMemorySchema,
  createWishlistSchema,
} from "../validators/schemas";
import { encrypt, decrypt } from "../services/encryptionService";
import { awardXp } from "../services/gamificationService";

const router = Router();

// Tier limits for memories
const MEMORY_LIMITS: Record<string, number> = {
  free: 20,
  pro: 200,
  legend: Infinity,
};

const MEDIA_PER_MEMORY_LIMITS: Record<string, number> = {
  free: 3,
  pro: 10,
  legend: 10,
};

// ============================================================
// Helper: invalidate memory caches
// ============================================================
async function invalidateMemoryCaches(uid: string): Promise<void> {
  const keys = await redis.keys(`memories:*:${uid}:*`);
  if (keys.length > 0) await redis.del(...keys);
  const timeline = await redis.keys(`memories:timeline:${uid}:*`);
  if (timeline.length > 0) await redis.del(...timeline);
  await redis.del(`memories:wishlist:${uid}`);
  await redis.del(`gifts:wishlist:${uid}`);
}

// ============================================================
// Helper: check memory count against tier limit
// ============================================================
async function checkMemoryLimit(uid: string, tier: string): Promise<void> {
  const limit = MEMORY_LIMITS[tier] || 20;
  if (limit === Infinity) return;

  const countSnap = await db
    .collection("users")
    .doc(uid)
    .collection("memories")
    .where("deletedAt", "==", null)
    .count()
    .get();

  if (countSnap.data().count >= limit) {
    throw new AppError(
      403,
      "TIER_LIMIT_EXCEEDED",
      `Memory storage limit reached (${limit}). Upgrade to store more.`
    );
  }
}

// ============================================================
// Helper: build tag index for search
// ============================================================
function buildSearchableText(title: string, description?: string, tags?: string[]): string {
  const parts = [title.toLowerCase()];
  if (description) parts.push(description.toLowerCase());
  if (tags) parts.push(...tags.map((t) => t.toLowerCase()));
  return parts.join(" ");
}

// ============================================================
// GET /memories -- list with pagination, category filter, search
// ============================================================
router.get("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const {
      category,
      hasMedia,
      search,
      startDate,
      endDate,
      limit: limitStr,
      lastDocId,
    } = req.query;

    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    // Cache key (skip cache if search is used)
    const searchTerm = search as string | undefined;
    const cacheKey = searchTerm
      ? null
      : `memories:list:${req.user.uid}:${category || "all"}:${lastDocId || "start"}`;

    if (cacheKey) {
      const cached = await redis.get(cacheKey);
      if (cached) return res.json(JSON.parse(cached));
    }

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null);

    if (category && category !== "all") {
      query = query.where("category", "==", category);
    }

    if (startDate) {
      query = query.where("date", ">=", startDate as string);
    }
    if (endDate) {
      query = query.where("date", "<=", endDate as string);
    }

    query = query.orderBy("createdAt", "desc");

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(req.user.uid)
        .collection("memories")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) {
        query = query.startAfter(lastDoc);
      }
    }

    // Fetch more if search filtering is needed
    const fetchLimit = searchTerm ? 200 : limit + 1;
    const snapshot = await query.limit(fetchLimit).get();

    let docs = snapshot.docs;

    // Client-side search filter (Firestore does not support full-text search natively)
    if (searchTerm) {
      const term = searchTerm.toLowerCase();
      docs = docs.filter((doc) => {
        const d = doc.data();
        const searchable = d.searchableText || "";
        return searchable.includes(term);
      });
    }

    // Filter by hasMedia
    if (hasMedia !== undefined) {
      const wantMedia = hasMedia === "true";
      docs = docs.filter((doc) => {
        const d = doc.data();
        const mediaCount = d.mediaUrls?.length || 0;
        return wantMedia ? mediaCount > 0 : mediaCount === 0;
      });
    }

    const paginatedDocs = docs.slice(0, limit);
    const hasMore = docs.length > limit;

    const data = paginatedDocs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        title: d.title,
        description: d.encryptedContent ? decrypt(d.encryptedContent) : d.description || "",
        category: d.category,
        date: d.date,
        mood: d.mood || null,
        mediaUrls: d.mediaUrls || [],
        mediaCount: d.mediaUrls?.length || 0,
        tags: d.tags || [],
        isFavorite: d.isFavorite || false,
        linkedProfileId: d.partnerProfileId || null,
        createdAt: d.createdAt,
        updatedAt: d.updatedAt,
      };
    });

    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .count()
      .get();

    const response = {
      data,
      pagination: {
        hasMore,
        lastDocId: paginatedDocs.length > 0 ? paginatedDocs[paginatedDocs.length - 1].id : null,
        totalCount: countSnap.data().count,
      },
    };

    if (cacheKey) {
      await redis.setex(cacheKey, 120, JSON.stringify(response));
    }
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /memories -- create with encryption for sensitive fields
// ============================================================
router.post("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createMemorySchema.parse(req.body);

    // Check tier limits
    await checkMemoryLimit(req.user.uid, req.user.tier);

    const memoryId = uuidv4();
    const searchableText = buildSearchableText(body.title, body.description, body.tags);

    // Encrypt description if marked as private
    const encryptedContent = body.isPrivate && body.description
      ? encrypt(body.description)
      : null;

    const memoryData = {
      title: body.title,
      description: body.isPrivate ? "[ENCRYPTED]" : (body.description || ""),
      encryptedContent,
      category: body.type,
      date: body.date,
      mood: (body as any).mood || null,
      tags: body.tags || [],
      mediaUrls: [],
      isFavorite: (body as any).isFavorite || false,
      isPrivate: body.isPrivate,
      sheSaid: body.type === "wishlist",
      partnerProfileId: (body as any).linkedProfileId || null,
      searchableText,
      deletedAt: null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };

    await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(memoryId)
      .set(memoryData);

    // Award XP
    const xpResult = await awardXp(req.user.uid, "memory_added");

    // Get updated count
    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .count()
      .get();

    await invalidateMemoryCaches(req.user.uid);

    res.status(201).json({
      data: {
        id: memoryId,
        title: body.title,
        category: body.type,
        date: body.date,
        xpAwarded: xpResult.xpAwarded,
        totalMemories: countSnap.data().count,
        memoryLimit: MEMORY_LIMITS[req.user.tier] || 20,
        createdAt: memoryData.createdAt,
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
// PUT /memories/:id -- update
// ============================================================
router.put("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updateMemorySchema.parse(req.body);

    const memoryRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(id);

    const memoryDoc = await memoryRef.get();
    if (!memoryDoc.exists || memoryDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Memory not found");
    }

    const current = memoryDoc.data()!;
    const updates: Record<string, any> = { updatedAt: new Date().toISOString() };

    if (body.title !== undefined) updates.title = body.title;
    if (body.description !== undefined) {
      if (current.isPrivate) {
        updates.encryptedContent = encrypt(body.description);
        updates.description = "[ENCRYPTED]";
      } else {
        updates.description = body.description;
      }
    }
    if (body.category !== undefined) updates.category = body.category;
    if (body.date !== undefined) updates.date = body.date;
    if ((body as any).mood !== undefined) updates.mood = (body as any).mood;
    if (body.tags !== undefined) updates.tags = body.tags;
    if ((body as any).isFavorite !== undefined) updates.isFavorite = (body as any).isFavorite;

    // Rebuild searchable text
    updates.searchableText = buildSearchableText(
      body.title || current.title,
      body.description || (current.isPrivate ? "" : current.description),
      body.tags || current.tags
    );

    await memoryRef.update(updates);
    await invalidateMemoryCaches(req.user.uid);

    res.json({
      data: {
        id,
        title: body.title || current.title,
        updatedAt: updates.updatedAt,
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
// DELETE /memories/:id -- soft delete
// ============================================================
router.delete("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;

    const memoryRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(id);

    const memoryDoc = await memoryRef.get();
    if (!memoryDoc.exists || memoryDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Memory not found");
    }

    const memoryData = memoryDoc.data()!;
    const mediaUrls: string[] = memoryData.mediaUrls || [];

    // Soft delete the memory
    await memoryRef.update({
      deletedAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    });

    // Delete associated media from Firebase Storage (background)
    let mediaFilesDeleted = 0;
    if (mediaUrls.length > 0) {
      const bucket = admin.storage().bucket();
      for (const url of mediaUrls) {
        try {
          const filePath = extractStoragePath(url);
          if (filePath) {
            await bucket.file(filePath).delete();
            mediaFilesDeleted++;
          }
        } catch {
          // Log but do not fail if individual file deletion fails
        }
      }
    }

    await invalidateMemoryCaches(req.user.uid);

    res.json({
      data: {
        message: "Memory deleted",
        mediaFilesDeleted,
        deletedAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// POST /memories/:id/media -- upload photo (multipart)
// ============================================================
router.post("/:id/media", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;

    const memoryRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(id);

    const memoryDoc = await memoryRef.get();
    if (!memoryDoc.exists || memoryDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Memory not found");
    }

    const memoryData = memoryDoc.data()!;
    const currentMedia: string[] = memoryData.mediaUrls || [];
    const maxMedia = MEDIA_PER_MEMORY_LIMITS[req.user.tier] || 3;

    if (currentMedia.length >= maxMedia) {
      throw new AppError(403, "MEDIA_LIMIT_EXCEEDED", `Memory already has ${maxMedia} media files`);
    }

    // Parse multipart upload via busboy
    const busboy = require("busboy");
    const bb = busboy({
      headers: req.headers,
      limits: { fileSize: 10 * 1024 * 1024 }, // 10MB for images
    });

    const ALLOWED_MIME_TYPES = [
      "image/jpeg",
      "image/png",
      "image/heic",
      "image/webp",
      "video/mp4",
      "video/quicktime",
    ];

    let fileProcessed = false;
    let caption = "";

    bb.on("field", (name: string, val: string) => {
      if (name === "caption") caption = val.substring(0, 200);
    });

    bb.on("file", async (_fieldname: string, stream: any, info: any) => {
      if (fileProcessed) {
        stream.resume();
        return;
      }
      fileProcessed = true;

      const { filename, mimeType } = info;

      if (!ALLOWED_MIME_TYPES.includes(mimeType)) {
        stream.resume();
        throw new AppError(400, "INVALID_FILE_TYPE", "Unsupported file format");
      }

      const isVideo = mimeType.startsWith("video/");
      const ext = filename.split(".").pop() || (isVideo ? "mp4" : "jpg");
      const mediaId = uuidv4();
      const storagePath = `users/${req.user.uid}/memories/${id}/${mediaId}.${ext}`;

      const bucket = admin.storage().bucket();
      const file = bucket.file(storagePath);

      const writeStream = file.createWriteStream({
        metadata: {
          contentType: mimeType,
          metadata: {
            userId: req.user.uid,
            memoryId: id,
            mediaId,
            uploadedAt: new Date().toISOString(),
          },
        },
      });

      let totalSize = 0;
      const chunks: Buffer[] = [];

      stream.on("data", (chunk: Buffer) => {
        totalSize += chunk.length;
        const sizeLimit = isVideo ? 50 * 1024 * 1024 : 10 * 1024 * 1024;
        if (totalSize > sizeLimit) {
          stream.destroy();
          writeStream.destroy();
          return;
        }
        chunks.push(chunk);
        writeStream.write(chunk);
      });

      stream.on("end", async () => {
        writeStream.end();

        // Make file publicly accessible via signed URL
        await file.makePublic();
        const downloadUrl = `https://storage.googleapis.com/${bucket.name}/${storagePath}`;

        // Generate thumbnail path (would be handled by a Storage trigger in production)
        const thumbnailPath = `users/${req.user.uid}/memories/${id}/thumb_${mediaId}.${ext}`;
        const thumbnailUrl = `https://storage.googleapis.com/${bucket.name}/${thumbnailPath}`;

        // Update memory with new media URL
        const updatedMediaUrls = [...currentMedia, downloadUrl];
        await memoryRef.update({
          mediaUrls: updatedMediaUrls,
          updatedAt: new Date().toISOString(),
        });

        // Store media metadata
        await db
          .collection("users")
          .doc(req.user.uid)
          .collection("memories")
          .doc(id)
          .collection("media")
          .doc(mediaId)
          .set({
            mediaId,
            url: downloadUrl,
            thumbnailUrl,
            mimeType,
            sizeBytes: totalSize,
            caption: caption || null,
            storagePath,
            uploadedAt: new Date().toISOString(),
          });

        await invalidateMemoryCaches(req.user.uid);

        res.status(201).json({
          data: {
            mediaId,
            memoryId: id,
            url: downloadUrl,
            thumbnailUrl,
            mimeType,
            sizeBytes: totalSize,
            caption: caption || null,
            uploadedAt: new Date().toISOString(),
          },
        });
      });
    });

    bb.on("error", (err: Error) => {
      next(new AppError(400, "UPLOAD_FAILED", err.message));
    });

    req.pipe(bb);
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// GET /memories/timeline -- chronological with date grouping
// ============================================================
router.get("/timeline", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const year = parseInt(req.query.year as string) || new Date().getFullYear();

    const cacheKey = `memories:timeline:${req.user.uid}:${year}`;
    const cached = await redis.get(cacheKey);
    if (cached) {
      return res.json(JSON.parse(cached));
    }

    const yearStart = `${year}-01-01`;
    const yearEnd = `${year}-12-31`;

    const snapshot = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .where("date", ">=", yearStart)
      .where("date", "<=", yearEnd)
      .orderBy("date", "desc")
      .get();

    // Group by month
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ];
    const monthNamesAr = [
      "يناير", "فبراير", "مارس", "أبريل", "مايو", "يونيو",
      "يوليو", "أغسطس", "سبتمبر", "أكتوبر", "نوفمبر", "ديسمبر",
    ];
    const monthNamesMs = [
      "Januari", "Februari", "Mac", "April", "Mei", "Jun",
      "Julai", "Ogos", "September", "Oktober", "November", "Disember",
    ];

    const localeMonths: Record<string, string[]> = {
      en: monthNames,
      ar: monthNamesAr,
      ms: monthNamesMs,
    };

    const monthGroups: Record<number, any[]> = {};
    for (const doc of snapshot.docs) {
      const d = doc.data();
      const monthNum = new Date(d.date).getMonth() + 1;
      if (!monthGroups[monthNum]) monthGroups[monthNum] = [];
      monthGroups[monthNum].push({
        id: doc.id,
        title: d.title,
        date: d.date,
        category: d.category,
        mood: d.mood || null,
        thumbnailUrl: d.mediaUrls?.[0] || null,
        isFavorite: d.isFavorite || false,
      });
    }

    const months = Object.entries(monthGroups)
      .map(([monthStr, memories]) => {
        const month = parseInt(monthStr);
        const names = localeMonths[req.locale] || monthNames;
        return {
          month,
          monthName: monthNames[month - 1],
          monthNameLocalized: names[month - 1],
          memoryCount: memories.length,
          memories,
        };
      })
      .sort((a, b) => b.month - a.month);

    // Get all years with memories
    const allMemories = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .select("date")
      .get();

    const yearsSet = new Set<number>();
    allMemories.docs.forEach((doc) => {
      const y = new Date(doc.data().date).getFullYear();
      yearsSet.add(y);
    });

    const response = {
      data: {
        year,
        months,
        totalMemories: snapshot.size,
        yearsAvailable: Array.from(yearsSet).sort((a, b) => b - a),
      },
    };

    await redis.setex(cacheKey, 300, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// GET /memories/wishlist -- filter by sheSaid=true
// ============================================================
router.get("/wishlist", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { priority, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    const cacheKey = `memories:wishlist:${req.user.uid}`;
    const cached = await redis.get(cacheKey);
    if (cached && !lastDocId) {
      return res.json(JSON.parse(cached));
    }

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(req.user.uid)
      .collection("wishlist")
      .where("deletedAt", "==", null);

    if (priority && priority !== "all") {
      query = query.where("priority", "==", priority);
    }

    query = query.orderBy("addedAt", "desc");

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(req.user.uid)
        .collection("wishlist")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    query = query.limit(limit + 1);
    const snapshot = await query.get();
    const docs = snapshot.docs.slice(0, limit);
    const hasMore = snapshot.docs.length > limit;

    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("wishlist")
      .where("deletedAt", "==", null)
      .count()
      .get();

    const data = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        item: d.item,
        category: d.category || null,
        priority: d.priority || "medium",
        estimatedPrice: d.estimatedPrice || null,
        currency: d.currency || null,
        link: d.link || null,
        notes: d.notes || null,
        source: d.source || "user_added",
        isGifted: d.isGifted || false,
        giftedDate: d.giftedDate || null,
        addedAt: d.addedAt,
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

    if (!lastDocId) {
      await redis.setex(cacheKey, 300, JSON.stringify(response));
    }
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /memories/wishlist -- create wish entry
// ============================================================
router.post("/wishlist", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createWishlistSchema.parse(req.body);
    const wishId = uuidv4();

    const wishData = {
      item: body.item,
      category: body.category || null,
      priority: body.priority || "medium",
      estimatedPrice: body.estimatedPrice || null,
      currency: body.currency || null,
      link: body.link || null,
      notes: body.notes || null,
      source: "user_added",
      isGifted: false,
      giftedDate: null,
      deletedAt: null,
      addedAt: new Date().toISOString(),
    };

    await db
      .collection("users")
      .doc(req.user.uid)
      .collection("wishlist")
      .doc(wishId)
      .set(wishData);

    await invalidateMemoryCaches(req.user.uid);

    res.status(201).json({
      data: {
        id: wishId,
        item: body.item,
        priority: wishData.priority,
        addedAt: wishData.addedAt,
      },
    });
  } catch (err: any) {
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Missing item name"));
    }
    next(err);
  }
});

// ============================================================
// Helper: extract storage path from URL
// ============================================================
function extractStoragePath(url: string): string | null {
  try {
    const match = url.match(/storage\.googleapis\.com\/[^/]+\/(.+)/);
    return match ? decodeURIComponent(match[1]) : null;
  } catch {
    return null;
  }
}

export default router;
```

---

## 3. Partner Profile API

### api/profiles.ts

```typescript
// functions/src/api/profiles.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis, CONFIG } from "../config";
import { AuthenticatedRequest, AppError, ZodiacSign } from "../types";
import {
  createPartnerProfileSchema,
  updatePartnerProfileSchema,
  updatePreferencesSchema,
  updateCulturalContextSchema,
} from "../validators/schemas";

const router = Router();

// ============================================================
// Helper: calculate profile completion percentage
// ============================================================
function calculateCompletionPercent(profile: Record<string, any>): number {
  const fields: { key: string; weight: number }[] = [
    { key: "name", weight: 15 },
    { key: "birthday", weight: 10 },
    { key: "zodiacSign", weight: 10 },
    { key: "loveLanguage", weight: 10 },
    { key: "communicationStyle", weight: 10 },
    { key: "relationshipStatus", weight: 10 },
    { key: "anniversaryDate", weight: 5 },
    { key: "photoUrl", weight: 5 },
    { key: "preferences", weight: 15 },
    { key: "culturalContext", weight: 10 },
  ];

  let score = 0;
  for (const { key, weight } of fields) {
    const val = profile[key];
    if (val === null || val === undefined || val === "") continue;
    if (key === "preferences") {
      const prefs = val as Record<string, any>;
      const subKeys = ["favorites", "dislikes", "hobbies"];
      const filledSub = subKeys.filter((sk) => {
        const sv = prefs[sk];
        return sv && (Array.isArray(sv) ? sv.length > 0 : true);
      });
      score += Math.round((filledSub.length / subKeys.length) * weight);
    } else if (key === "culturalContext") {
      const ctx = val as Record<string, any>;
      const filledSub = ["background", "religiousObservance"].filter((sk) => ctx[sk]);
      score += Math.round((filledSub.length / 2) * weight);
    } else {
      score += weight;
    }
  }
  return Math.min(100, score);
}

// ============================================================
// Helper: load zodiac defaults from metadata collection
// ============================================================
async function loadZodiacDefaults(sign: ZodiacSign, locale: string): Promise<any | null> {
  const cacheKey = `zodiac:defaults:${sign}:${locale}`;
  const cached = await redis.get(cacheKey);
  if (cached) return JSON.parse(cached);

  const metaDoc = await db.collection("metadata").doc("zodiacProfiles").get();
  if (!metaDoc.exists) return null;

  const signData = metaDoc.data()!.signs?.[sign];
  if (!signData) return null;

  const defaults = {
    sign,
    element: signData.element,
    modality: signData.modality,
    personality: signData.loveTraits || [],
    communicationTips: signData.communicationTips || [],
    emotionalNeeds: signData.romanticNeeds || [],
    conflictStyle: signData.conflictStyle || "",
    giftPreferences: signData.giftPreferences || [],
    loveLanguageAffinity: signData.loveLanguageAffinity || null,
    bestApproachDuring: signData.bestApproachDuring || {},
  };

  await redis.setex(cacheKey, CONFIG.CACHE_TTL_ZODIAC, JSON.stringify(defaults));
  return defaults;
}

// POST /profiles -- create (limit: 1 per user for MVP)
router.post("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createPartnerProfileSchema.parse(req.body);

    const existingSnap = await db
      .collection("users").doc(req.user.uid)
      .collection("partnerProfiles")
      .where("deletedAt", "==", null).limit(1).get();

    if (!existingSnap.empty) {
      throw new AppError(409, "PROFILE_ALREADY_EXISTS", "User already has a partner profile");
    }

    const profileId = uuidv4();
    const profileData: Record<string, any> = {
      name: body.name, birthday: body.birthday || null,
      zodiacSign: body.zodiacSign || null, loveLanguage: body.loveLanguage || null,
      communicationStyle: body.communicationStyle || null,
      relationshipStatus: body.relationshipStatus,
      anniversaryDate: body.anniversaryDate || null, photoUrl: body.photoUrl || null,
      keyDates: [], preferences: { favorites: {}, dislikes: [], hobbies: [] },
      culturalContext: { background: null, religiousObservance: null, dialect: null },
      deletedAt: null,
      createdAt: new Date().toISOString(), updatedAt: new Date().toISOString(),
    };
    profileData.completionPercent = calculateCompletionPercent(profileData);

    await db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(profileId).set(profileData);

    res.status(201).json({
      data: {
        id: profileId, userId: req.user.uid, name: body.name,
        birthday: body.birthday || null, zodiacSign: body.zodiacSign || null,
        loveLanguage: body.loveLanguage || null,
        communicationStyle: body.communicationStyle || null,
        relationshipStatus: body.relationshipStatus,
        anniversaryDate: body.anniversaryDate || null, photoUrl: body.photoUrl || null,
        profileCompletionPercent: profileData.completionPercent,
        createdAt: profileData.createdAt, updatedAt: profileData.updatedAt,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed", { errors: err.errors }));
    next(err);
  }
});

// GET /profiles/:id -- get with zodiac defaults merged
router.get("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const cacheKey = `profile:${id}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json({ data: JSON.parse(cached) });

    const profileDoc = await db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id).get();

    if (!profileDoc.exists || profileDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Profile not found");
    }
    const profile = profileDoc.data()!;

    let zodiacTraits = null;
    if (profile.zodiacSign) {
      zodiacTraits = await loadZodiacDefaults(profile.zodiacSign, req.locale);
    }

    const data = {
      id, userId: req.user.uid, name: profile.name,
      birthday: profile.birthday || null, zodiacSign: profile.zodiacSign || null,
      zodiacTraits: zodiacTraits ? {
        personality: zodiacTraits.personality,
        communicationTips: zodiacTraits.communicationTips,
        emotionalNeeds: zodiacTraits.emotionalNeeds,
        conflictStyle: zodiacTraits.conflictStyle,
        giftPreferences: zodiacTraits.giftPreferences,
      } : null,
      loveLanguage: profile.loveLanguage || null,
      communicationStyle: profile.communicationStyle || null,
      relationshipStatus: profile.relationshipStatus,
      anniversaryDate: profile.anniversaryDate || null,
      photoUrl: profile.photoUrl || null,
      preferences: profile.preferences || {},
      culturalContext: profile.culturalContext || {},
      profileCompletionPercent: profile.completionPercent || 0,
      createdAt: profile.createdAt, updatedAt: profile.updatedAt,
    };

    await redis.setex(cacheKey, CONFIG.CACHE_TTL_PROFILE, JSON.stringify(data));
    res.json({ data });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// PUT /profiles/:id -- update fields
router.put("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updatePartnerProfileSchema.parse(req.body);

    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Profile not found");
    }

    const current = profileDoc.data()!;
    const updates: Record<string, any> = { updatedAt: new Date().toISOString() };
    for (const key of ["name","birthday","zodiacSign","loveLanguage","communicationStyle","relationshipStatus","anniversaryDate","photoUrl"]) {
      if ((body as any)[key] !== undefined) updates[key] = (body as any)[key];
    }
    updates.completionPercent = calculateCompletionPercent({ ...current, ...updates });

    await profileRef.update(updates);
    await redis.del(`profile:${id}`);

    res.json({ data: { id, name: updates.name || current.name, profileCompletionPercent: updates.completionPercent, updatedAt: updates.updatedAt } });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

// DELETE /profiles/:id -- soft delete
router.delete("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Profile not found");
    }
    await profileRef.update({ deletedAt: new Date().toISOString(), updatedAt: new Date().toISOString() });
    await redis.del(`profile:${id}`);
    res.json({ data: { message: "Profile deleted successfully", deletedAt: new Date().toISOString() } });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// GET /profiles/:id/zodiac-defaults
router.get("/:id/zodiac-defaults", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    let sign = req.query.sign as ZodiacSign | undefined;
    const validSigns: ZodiacSign[] = ["aries","taurus","gemini","cancer","leo","virgo","libra","scorpio","sagittarius","capricorn","aquarius","pisces"];

    if (!sign) {
      const profileDoc = await db.collection("users").doc(req.user.uid)
        .collection("partnerProfiles").doc(id).get();
      if (!profileDoc.exists || !profileDoc.data()?.zodiacSign) {
        throw new AppError(400, "INVALID_ZODIAC_SIGN", "No zodiac sign set on profile");
      }
      sign = profileDoc.data()!.zodiacSign;
    }
    if (!validSigns.includes(sign!)) throw new AppError(400, "INVALID_ZODIAC_SIGN", `Invalid sign: ${sign}`);

    const defaults = await loadZodiacDefaults(sign!, req.locale);
    if (!defaults) throw new AppError(404, "NOT_FOUND", "Zodiac data not found");
    res.json({ data: defaults });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// PUT /profiles/:id/preferences
router.put("/:id/preferences", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updatePreferencesSchema.parse(req.body);

    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) throw new AppError(404, "NOT_FOUND", "Profile not found");

    const current = profileDoc.data()!;
    const updatedPrefs = { ...(current.preferences || {}) };
    if (body.favorites) updatedPrefs.favorites = { ...(updatedPrefs.favorites || {}), ...body.favorites };
    if (body.dislikes !== undefined) updatedPrefs.dislikes = body.dislikes;
    if (body.hobbies !== undefined) updatedPrefs.hobbies = body.hobbies;
    if (body.stressCoping !== undefined) updatedPrefs.stressCoping = body.stressCoping;
    if (body.notes !== undefined) updatedPrefs.notes = body.notes;

    const completionPercent = calculateCompletionPercent({ ...current, preferences: updatedPrefs });
    await profileRef.update({ preferences: updatedPrefs, completionPercent, updatedAt: new Date().toISOString() });
    await redis.del(`profile:${id}`);

    res.json({ data: { id, preferences: updatedPrefs, profileCompletionPercent: completionPercent, updatedAt: new Date().toISOString() } });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

// PUT /profiles/:id/cultural-context
router.put("/:id/cultural-context", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updateCulturalContextSchema.parse(req.body);

    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) throw new AppError(404, "NOT_FOUND", "Profile not found");

    const current = profileDoc.data()!;
    const updatedCtx = { ...(current.culturalContext || {}) };
    if (body.background !== undefined) updatedCtx.background = body.background;
    if (body.religiousObservance !== undefined) updatedCtx.religiousObservance = body.religiousObservance;
    if (body.dialect !== undefined) updatedCtx.dialect = body.dialect;

    // Auto-add Islamic holidays
    const autoAddedHolidays: { name: string; date: string }[] = [];
    if (updatedCtx.religiousObservance === "high" || updatedCtx.religiousObservance === "moderate") {
      const holidays = [
        { name: "Ramadan Start", date: "2026-02-18" },
        { name: "Eid al-Fitr", date: "2026-03-20" },
        { name: "Eid al-Adha", date: "2026-05-27" },
      ];
      for (const h of holidays) {
        autoAddedHolidays.push(h);
        const existing = await db.collection("users").doc(req.user.uid)
          .collection("reminders").where("title", "==", h.name).where("date", "==", h.date).limit(1).get();
        if (existing.empty) {
          await db.collection("users").doc(req.user.uid).collection("reminders").add({
            title: h.name, notes: "Auto-added Islamic holiday", category: "islamic_holiday",
            date: h.date, recurrence: "yearly", reminderTiers: [7, 3, 1, 0],
            completed: false, snoozedUntil: null,
            escalationSent: { "7d": false, "3d": false, "1d": false, same: false },
            giftSuggest: true, partnerProfileId: id, isAutoGenerated: true,
            deletedAt: null, createdAt: new Date().toISOString(), updatedAt: new Date().toISOString(),
          });
        }
      }
    }

    const completionPercent = calculateCompletionPercent({ ...current, culturalContext: updatedCtx });
    await profileRef.update({ culturalContext: updatedCtx, completionPercent, updatedAt: new Date().toISOString() });
    await redis.del(`profile:${id}`);

    res.json({ data: { id, culturalContext: updatedCtx, autoAddedHolidays, updatedAt: new Date().toISOString() } });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

export default router;
```

---

## 4. Notification Scheduling Engine

### services/notificationScheduler.ts

```typescript
// functions/src/services/notificationScheduler.ts
import { db, redis } from "../config";
import { sendTemplatedNotification } from "./notificationService";
import { SupportedLocale } from "../types";
import * as functions from "firebase-functions";

// ============================================================
// Types
// ============================================================
interface ScheduleParams {
  userId: string;
  reminderId: string;
  eventTitle: string;
  eventDate: string;
  eventTime: string | null;
  tiers: number[];
  timezone: string;
  linkedProfileId: string | null;
}

interface ScheduledNotification {
  tier: number;
  scheduledFor: string;
  label: string;
}

// Tier-to-template mapping
const TIER_TEMPLATE_MAP: Record<number, string> = {
  30: "reminder_30d", 14: "reminder_14d", 7: "reminder_7d",
  3: "reminder_3d", 1: "reminder_1d", 0: "reminder_day_of",
};

const TIER_LABELS: Record<number, string> = {
  30: "30 days before", 14: "14 days before", 7: "7 days before",
  3: "3 days before", 1: "1 day before", 0: "Day of event",
};

// ============================================================
// Schedule reminder notifications at creation time
// ============================================================
export async function scheduleReminderNotifications(
  params: ScheduleParams
): Promise<ScheduledNotification[]> {
  const { userId, reminderId, eventTitle, eventDate, eventTime, tiers, timezone, linkedProfileId } = params;
  const eventDateObj = new Date(eventDate);
  const now = new Date();
  const scheduled: ScheduledNotification[] = [];

  const sortedTiers = [...tiers].sort((a, b) => b - a);

  for (const tier of sortedTiers) {
    const notifDate = new Date(eventDateObj);
    notifDate.setDate(notifDate.getDate() - tier);

    // Default 9:00 AM or event time
    if (eventTime) {
      const [h, m] = eventTime.split(":").map(Number);
      notifDate.setHours(h, m, 0, 0);
    } else {
      notifDate.setHours(9, 0, 0, 0);
    }

    const scheduledFor = adjustForTimezone(notifDate, timezone);
    if (scheduledFor <= now) continue;

    // Quiet hours adjustment
    const adjusted = await adjustForQuietHours(userId, scheduledFor, timezone);
    const templateKey = TIER_TEMPLATE_MAP[tier] || "reminder_7d";
    const notifId = `${reminderId}_${tier}d`;

    await db.collection("scheduled_notifications").doc(notifId).set({
      userId, reminderId, tier, templateKey, eventTitle, eventDate,
      scheduledFor: adjusted.toISOString(), timezone, linkedProfileId,
      status: "pending", deduplicationKey: `${reminderId}:${tier}:${eventDate}`,
      createdAt: new Date().toISOString(),
    });

    scheduled.push({
      tier, scheduledFor: adjusted.toISOString(),
      label: TIER_LABELS[tier] || `${tier} days before`,
    });
  }
  return scheduled;
}

// ============================================================
// Cancel all scheduled notifications for a reminder
// ============================================================
export async function cancelReminderNotifications(userId: string, reminderId: string): Promise<number> {
  const snapshot = await db.collection("scheduled_notifications")
    .where("userId", "==", userId)
    .where("reminderId", "==", reminderId)
    .where("status", "==", "pending").get();

  const batch = db.batch();
  for (const doc of snapshot.docs) {
    batch.update(doc.ref, { status: "cancelled", cancelledAt: new Date().toISOString() });
  }
  await batch.commit();
  return snapshot.size;
}

// ============================================================
// Reschedule after date/tier change
// ============================================================
export async function rescheduleReminderNotifications(params: ScheduleParams): Promise<ScheduledNotification[]> {
  await cancelReminderNotifications(params.userId, params.reminderId);
  return scheduleReminderNotifications(params);
}

// ============================================================
// Process pending notifications (called every 5 min by scheduled fn)
// ============================================================
export async function processPendingNotifications(): Promise<number> {
  const now = new Date();
  const pendingSnap = await db.collection("scheduled_notifications")
    .where("status", "==", "pending")
    .where("scheduledFor", "<=", now.toISOString())
    .limit(100).get();

  let sent = 0;
  for (const doc of pendingSnap.docs) {
    const notif = doc.data();

    // Deduplication
    const dedupKey = `notif:sent:${notif.deduplicationKey}`;
    if (await redis.get(dedupKey)) {
      await doc.ref.update({ status: "deduplicated" });
      continue;
    }

    try {
      const userDoc = await db.collection("users").doc(notif.userId).get();
      const locale: SupportedLocale = userDoc.data()?.language || "en";
      let partnerName = "her";
      if (notif.linkedProfileId) {
        const pDoc = await db.collection("users").doc(notif.userId)
          .collection("partnerProfiles").doc(notif.linkedProfileId).get();
        if (pDoc.exists) partnerName = pDoc.data()!.name;
      }

      await sendTemplatedNotification(notif.userId, notif.templateKey,
        { eventName: notif.eventTitle, partnerName }, locale,
        { reminderId: notif.reminderId, type: "reminder" });

      await doc.ref.update({ status: "sent", sentAt: now.toISOString() });
      await redis.setex(dedupKey, 86400, "1");
      sent++;
    } catch (err) {
      functions.logger.error("Notification send failed", { notifId: doc.id, error: err });
      await doc.ref.update({ status: "failed", failedAt: now.toISOString(), failureReason: (err as Error).message });
    }
  }
  return sent;
}

// ============================================================
// Quiet hours enforcement
// ============================================================
async function adjustForQuietHours(userId: string, scheduledTime: Date, timezone: string): Promise<Date> {
  const userDoc = await db.collection("users").doc(userId).get();
  const settings = userDoc.data()?.settings;
  if (!settings?.quietHoursEnabled) return scheduledTime;

  const localTimeStr = scheduledTime.toLocaleTimeString("en-US", { timeZone: timezone, hour12: false });
  const localMin = parseInt(localTimeStr.split(":")[0]) * 60 + parseInt(localTimeStr.split(":")[1]);
  const [startH, startM] = (settings.quietHoursStart || "22:00").split(":").map(Number);
  const [endH, endM] = (settings.quietHoursEnd || "07:00").split(":").map(Number);
  const startMin = startH * 60 + startM;
  const endMin = endH * 60 + endM;

  let isQuiet: boolean;
  if (startMin < endMin) {
    isQuiet = localMin >= startMin && localMin < endMin;
  } else {
    isQuiet = localMin >= startMin || localMin < endMin;
  }

  if (isQuiet) {
    const adjusted = new Date(scheduledTime);
    adjusted.setHours(endH, endM, 0, 0);
    if (startMin > endMin && localMin >= startMin) adjusted.setDate(adjusted.getDate() + 1);
    return adjusted;
  }
  return scheduledTime;
}

// ============================================================
// Timezone adjustment
// ============================================================
function adjustForTimezone(date: Date, timezone: string): Date {
  try {
    const targetTime = new Date(date.toLocaleString("en-US", { timeZone: timezone }));
    const localTime = new Date(date.toLocaleString("en-US"));
    const offset = localTime.getTime() - targetTime.getTime();
    return new Date(date.getTime() + offset);
  } catch { return date; }
}

// ============================================================
// FCM payload construction per locale (EN/AR/MS)
// ============================================================
export function buildFcmPayload(
  templateKey: string, locale: SupportedLocale, vars: Record<string, string>
): { title: string; body: string } {
  const TEMPLATES: Record<string, Record<SupportedLocale, { title: string; body: string }>> = {
    reminder_30d: {
      en: { title: "30 days until {eventName}", body: "Plenty of time to plan something amazing for {partnerName}!" },
      ar: { title: "30 يوما حتى {eventName}", body: "لديك وقت كاف لتخطيط شيء مذهل لـ {partnerName}!" },
      ms: { title: "30 hari lagi sehingga {eventName}", body: "Masa yang cukup untuk merancang sesuatu yang hebat untuk {partnerName}!" },
    },
    reminder_14d: {
      en: { title: "2 weeks until {eventName}", body: "Time to start thinking about {partnerName}'s special day!" },
      ar: { title: "اسبوعان حتى {eventName}", body: "حان الوقت للتفكير في يوم {partnerName} المميز!" },
      ms: { title: "2 minggu lagi sehingga {eventName}", body: "Masa untuk mula memikirkan hari istimewa {partnerName}!" },
    },
    reminder_7d: {
      en: { title: "7 days until {eventName}", body: "Start planning something special for {partnerName}!" },
      ar: { title: "7 ايام حتى {eventName}", body: "ابدأ بالتخطيط لشيء مميز لـ {partnerName}!" },
      ms: { title: "7 hari lagi sehingga {eventName}", body: "Mula merancang sesuatu yang istimewa untuk {partnerName}!" },
    },
    reminder_3d: {
      en: { title: "3 days until {eventName}", body: "Time is running short! Have you planned for {partnerName}?" },
      ar: { title: "3 ايام حتى {eventName}", body: "الوقت ينفد! هل خططت لشيء لـ {partnerName}؟" },
      ms: { title: "3 hari lagi sehingga {eventName}", body: "Masa semakin singkat! Sudah merancang untuk {partnerName}?" },
    },
    reminder_1d: {
      en: { title: "Tomorrow: {eventName}", body: "Final check -- is everything ready for {partnerName}?" },
      ar: { title: "غدا: {eventName}", body: "تحقق أخير -- هل كل شيء جاهز لـ {partnerName}؟" },
      ms: { title: "Esok: {eventName}", body: "Semakan terakhir -- adakah semuanya sedia untuk {partnerName}?" },
    },
    reminder_day_of: {
      en: { title: "Today: {eventName}!", body: "Today is the day! Make it special for {partnerName}." },
      ar: { title: "اليوم: {eventName}!", body: "اليوم هو اليوم! اجعله مميزا لـ {partnerName}." },
      ms: { title: "Hari ini: {eventName}!", body: "Hari ini hari istimewa! Jadikan ia bermakna untuk {partnerName}." },
    },
  };

  const tmpl = TEMPLATES[templateKey]?.[locale] || TEMPLATES[templateKey]?.en || { title: templateKey, body: "" };
  let { title, body } = tmpl;
  for (const [key, val] of Object.entries(vars)) {
    title = title.replace(new RegExp(`\\{${key}\\}`, "g"), val);
    body = body.replace(new RegExp(`\\{${key}\\}`, "g"), val);
  }
  return { title, body };
}
```

---

## 5. Calendar Sync Service

### services/calendarSync.ts

```typescript
// functions/src/services/calendarSync.ts
import { db, redis } from "../config";
import * as functions from "firebase-functions";

// ============================================================
// Types
// ============================================================
interface CalendarEvent {
  id: string;
  summary: string;
  description?: string;
  start: { date?: string; dateTime?: string; timeZone?: string };
  end: { date?: string; dateTime?: string; timeZone?: string };
  recurrence?: string[];
  reminders?: { useDefault: boolean; overrides?: { method: string; minutes: number }[] };
}

interface SyncResult {
  exported: number;
  imported: number;
  conflicts: number;
  errors: string[];
}

interface OAuthTokens {
  accessToken: string;
  refreshToken: string;
  expiresAt: number;
}

// ============================================================
// OAuth token management for Calendar API
// ============================================================
async function getOAuthTokens(userId: string): Promise<OAuthTokens | null> {
  const tokenDoc = await db.collection("oauth_tokens").doc(`${userId}_google`).get();
  if (!tokenDoc.exists) return null;

  const tokens = tokenDoc.data()! as OAuthTokens;

  // Refresh if expired (with 5-minute buffer)
  if (Date.now() > tokens.expiresAt - 5 * 60 * 1000) {
    try {
      const refreshed = await refreshGoogleToken(tokens.refreshToken);
      const updated: OAuthTokens = {
        accessToken: refreshed.access_token,
        refreshToken: tokens.refreshToken,
        expiresAt: Date.now() + refreshed.expires_in * 1000,
      };
      await db.collection("oauth_tokens").doc(`${userId}_google`).update({
        accessToken: updated.accessToken,
        expiresAt: updated.expiresAt,
        updatedAt: new Date().toISOString(),
      });
      return updated;
    } catch (err) {
      functions.logger.error("Failed to refresh Google OAuth token", { userId, error: err });
      return null;
    }
  }

  return tokens;
}

async function refreshGoogleToken(refreshToken: string): Promise<{ access_token: string; expires_in: number }> {
  const response = await fetch("https://oauth2.googleapis.com/token", {
    method: "POST",
    headers: { "Content-Type": "application/x-www-form-urlencoded" },
    body: new URLSearchParams({
      client_id: process.env.GOOGLE_CLIENT_ID || "",
      client_secret: process.env.GOOGLE_CLIENT_SECRET || "",
      refresh_token: refreshToken,
      grant_type: "refresh_token",
    }),
  });

  if (!response.ok) {
    throw new Error(`Token refresh failed: ${response.status}`);
  }
  return response.json();
}

export async function storeOAuthTokens(
  userId: string, accessToken: string, refreshToken: string, expiresIn: number
): Promise<void> {
  await db.collection("oauth_tokens").doc(`${userId}_google`).set({
    accessToken, refreshToken,
    expiresAt: Date.now() + expiresIn * 1000,
    createdAt: new Date().toISOString(),
    updatedAt: new Date().toISOString(),
  });
}

// ============================================================
// Export reminders to Google Calendar
// ============================================================
export async function exportRemindersToCalendar(userId: string): Promise<SyncResult> {
  const result: SyncResult = { exported: 0, imported: 0, conflicts: 0, errors: [] };
  const tokens = await getOAuthTokens(userId);
  if (!tokens) {
    result.errors.push("Google Calendar not connected");
    return result;
  }

  const remindersSnap = await db.collection("users").doc(userId)
    .collection("reminders")
    .where("deletedAt", "==", null)
    .where("completed", "==", false).get();

  const userDoc = await db.collection("users").doc(userId).get();
  const timezone = userDoc.data()?.settings?.timezone || "UTC";

  for (const doc of remindersSnap.docs) {
    const reminder = doc.data();

    // Check if already synced
    const syncDoc = await db.collection("calendar_sync").doc(`${userId}_${doc.id}`).get();
    if (syncDoc.exists && syncDoc.data()?.googleEventId) {
      // Update existing event
      try {
        await updateCalendarEvent(tokens.accessToken, syncDoc.data()!.googleEventId, {
          summary: reminder.title,
          description: reminder.notes || "",
          start: { date: reminder.date },
          end: { date: reminder.date },
        });
        result.exported++;
      } catch (err) {
        result.errors.push(`Failed to update event for reminder ${doc.id}`);
      }
      continue;
    }

    // Create new event
    try {
      const event = buildCalendarEvent(reminder, timezone);
      const created = await createCalendarEvent(tokens.accessToken, event);

      await db.collection("calendar_sync").doc(`${userId}_${doc.id}`).set({
        userId, reminderId: doc.id,
        googleEventId: created.id,
        direction: "export", lastSyncedAt: new Date().toISOString(),
      });
      result.exported++;
    } catch (err) {
      result.errors.push(`Failed to create event for reminder ${doc.id}`);
    }
  }

  return result;
}

// ============================================================
// Import events from Google Calendar
// ============================================================
export async function importEventsFromCalendar(userId: string): Promise<SyncResult> {
  const result: SyncResult = { exported: 0, imported: 0, conflicts: 0, errors: [] };
  const tokens = await getOAuthTokens(userId);
  if (!tokens) {
    result.errors.push("Google Calendar not connected");
    return result;
  }

  try {
    const now = new Date();
    const timeMin = now.toISOString();
    const futureDate = new Date(now.getTime() + 365 * 24 * 60 * 60 * 1000);
    const timeMax = futureDate.toISOString();

    const events = await listCalendarEvents(tokens.accessToken, timeMin, timeMax);

    for (const event of events) {
      if (!event.summary) continue;

      // Check for existing sync record
      const existingSync = await db.collection("calendar_sync")
        .where("userId", "==", userId)
        .where("googleEventId", "==", event.id).limit(1).get();

      if (!existingSync.empty) {
        const syncData = existingSync.docs[0].data();
        // Conflict resolution: Google Calendar event updated after last sync
        if (syncData.direction === "export") {
          result.conflicts++;
          continue; // Skip events we exported -- they are managed in LOLO
        }
      }

      // Import as a reminder
      const eventDate = event.start.date || event.start.dateTime?.split("T")[0];
      if (!eventDate) continue;

      const existingReminder = await db.collection("users").doc(userId)
        .collection("reminders")
        .where("title", "==", event.summary)
        .where("date", "==", eventDate).limit(1).get();

      if (!existingReminder.empty) {
        result.conflicts++;
        continue;
      }

      await db.collection("users").doc(userId).collection("reminders").add({
        title: event.summary,
        notes: event.description || null,
        category: "custom", date: eventDate,
        recurrence: parseGoogleRecurrence(event.recurrence),
        reminderTiers: [7, 3, 1, 0],
        completed: false, snoozedUntil: null,
        escalationSent: { "7d": false, "3d": false, "1d": false, same: false },
        giftSuggest: false, isAutoGenerated: false,
        source: "google_calendar", googleEventId: event.id,
        deletedAt: null,
        createdAt: new Date().toISOString(), updatedAt: new Date().toISOString(),
      });

      await db.collection("calendar_sync").doc(`${userId}_gcal_${event.id}`).set({
        userId, googleEventId: event.id,
        direction: "import", lastSyncedAt: new Date().toISOString(),
      });

      result.imported++;
    }
  } catch (err) {
    result.errors.push(`Calendar import failed: ${(err as Error).message}`);
  }

  return result;
}

// ============================================================
// Two-way sync with conflict resolution
// ============================================================
export async function fullCalendarSync(userId: string): Promise<SyncResult> {
  const exportResult = await exportRemindersToCalendar(userId);
  const importResult = await importEventsFromCalendar(userId);

  return {
    exported: exportResult.exported,
    imported: importResult.imported,
    conflicts: exportResult.conflicts + importResult.conflicts,
    errors: [...exportResult.errors, ...importResult.errors],
  };
}

// ============================================================
// Google Calendar API helpers
// ============================================================
const CALENDAR_API_BASE = "https://www.googleapis.com/calendar/v3";

async function createCalendarEvent(accessToken: string, event: CalendarEvent): Promise<{ id: string }> {
  const response = await fetch(`${CALENDAR_API_BASE}/calendars/primary/events`, {
    method: "POST",
    headers: { Authorization: `Bearer ${accessToken}`, "Content-Type": "application/json" },
    body: JSON.stringify(event),
  });
  if (!response.ok) throw new Error(`Calendar API error: ${response.status}`);
  return response.json();
}

async function updateCalendarEvent(accessToken: string, eventId: string, updates: Partial<CalendarEvent>): Promise<void> {
  const response = await fetch(`${CALENDAR_API_BASE}/calendars/primary/events/${eventId}`, {
    method: "PATCH",
    headers: { Authorization: `Bearer ${accessToken}`, "Content-Type": "application/json" },
    body: JSON.stringify(updates),
  });
  if (!response.ok) throw new Error(`Calendar API update error: ${response.status}`);
}

async function listCalendarEvents(accessToken: string, timeMin: string, timeMax: string): Promise<CalendarEvent[]> {
  const url = new URL(`${CALENDAR_API_BASE}/calendars/primary/events`);
  url.searchParams.set("timeMin", timeMin);
  url.searchParams.set("timeMax", timeMax);
  url.searchParams.set("singleEvents", "true");
  url.searchParams.set("orderBy", "startTime");
  url.searchParams.set("maxResults", "250");

  const response = await fetch(url.toString(), {
    headers: { Authorization: `Bearer ${accessToken}` },
  });
  if (!response.ok) throw new Error(`Calendar API list error: ${response.status}`);
  const data = await response.json();
  return data.items || [];
}

function buildCalendarEvent(reminder: Record<string, any>, timezone: string): CalendarEvent {
  const event: CalendarEvent = {
    id: "", summary: reminder.title,
    description: reminder.notes || `LOLO Reminder: ${reminder.category}`,
    start: { date: reminder.date, timeZone: timezone },
    end: { date: reminder.date, timeZone: timezone },
    reminders: {
      useDefault: false,
      overrides: (reminder.reminderTiers || [7, 3, 1, 0]).map((days: number) => ({
        method: "popup", minutes: days * 24 * 60,
      })),
    },
  };

  if (reminder.recurrence && reminder.recurrence !== "none") {
    const rruleMap: Record<string, string> = {
      daily: "RRULE:FREQ=DAILY", weekly: "RRULE:FREQ=WEEKLY",
      monthly: "RRULE:FREQ=MONTHLY", yearly: "RRULE:FREQ=YEARLY",
    };
    if (rruleMap[reminder.recurrence]) event.recurrence = [rruleMap[reminder.recurrence]];
  }
  return event;
}

function parseGoogleRecurrence(recurrence?: string[]): string {
  if (!recurrence || recurrence.length === 0) return "none";
  const rule = recurrence[0].toUpperCase();
  if (rule.includes("DAILY")) return "daily";
  if (rule.includes("WEEKLY")) return "weekly";
  if (rule.includes("MONTHLY")) return "monthly";
  if (rule.includes("YEARLY")) return "yearly";
  return "none";
}

// ============================================================
// Hijri date conversion utility (for Arabic users)
// ============================================================
export function gregorianToHijri(year: number, month: number, day: number): { year: number; month: number; day: number; monthName: string } {
  // Simplified Hijri conversion algorithm
  // In production, use a library like hijri-converter or moment-hijri
  const jd = Math.floor((1461 * (year + 4800 + Math.floor((month - 14) / 12))) / 4)
    + Math.floor((367 * (month - 2 - 12 * Math.floor((month - 14) / 12))) / 12)
    - Math.floor((3 * Math.floor((year + 4900 + Math.floor((month - 14) / 12)) / 100)) / 4)
    + day - 32075;

  const l = jd - 1948440 + 10632;
  const n = Math.floor((l - 1) / 10631);
  const lPrime = l - 10631 * n + 354;
  const j = Math.floor((10985 - lPrime) / 5316) * Math.floor((50 * lPrime) / 17719)
    + Math.floor(lPrime / 5670) * Math.floor((43 * lPrime) / 15238);
  const lDoublePrime = lPrime - Math.floor((30 - j) / 15) * Math.floor((17719 * j) / 50)
    - Math.floor(j / 16) * Math.floor((15238 * j) / 43) + 29;

  const hijriMonth = Math.floor((24 * lDoublePrime) / 709);
  const hijriDay = lDoublePrime - Math.floor((709 * hijriMonth) / 24);
  const hijriYear = 30 * n + j - 30;

  const hijriMonthNames = [
    "Muharram", "Safar", "Rabi al-Awwal", "Rabi al-Thani",
    "Jumada al-Ula", "Jumada al-Thani", "Rajab", "Shaban",
    "Ramadan", "Shawwal", "Dhul Qadah", "Dhul Hijjah",
  ];

  return {
    year: hijriYear, month: hijriMonth, day: hijriDay,
    monthName: hijriMonthNames[hijriMonth - 1] || "",
  };
}

export function hijriToGregorian(year: number, month: number, day: number): { year: number; month: number; day: number } {
  // Reverse conversion
  const jd = Math.floor((11 * year + 3) / 30) + 354 * year + 30 * month
    - Math.floor((month - 1) / 2) + day + 1948440 - 385;

  const l = jd + 68569;
  const n = Math.floor((4 * l) / 146097);
  const lPrime = l - Math.floor((146097 * n + 3) / 4);
  const i = Math.floor((4000 * (lPrime + 1)) / 1461001);
  const lDoublePrime = lPrime - Math.floor((1461 * i) / 4) + 31;
  const j = Math.floor((80 * lDoublePrime) / 2447);

  const gDay = lDoublePrime - Math.floor((2447 * j) / 80);
  const lTriple = Math.floor(j / 11);
  const gMonth = j + 2 - 12 * lTriple;
  const gYear = 100 * (n - 49) + i + lTriple;

  return { year: gYear, month: gMonth, day: gDay };
}
```

---

## 6. Action Cards Daily Generation (Enhanced)

### scheduled/dailyCards.ts

```typescript
// functions/src/scheduled/dailyCards.ts
import * as functions from "firebase-functions/v2";
import { db, redis } from "../config";
import { routeAIRequest } from "../ai/router";
import { sendTemplatedNotification } from "../services/notificationService";
import { AIRequest, SupportedLocale, CardCategory } from "../types";
import { v4 as uuidv4 } from "uuid";

// ============================================================
// Tier card limits
// ============================================================
const CARD_LIMITS: Record<string, number> = { free: 3, pro: 10, legend: 20 };

// ============================================================
// Card type definitions
// ============================================================
interface CardTemplate {
  id: string;
  type: CardCategory;
  titleTemplate: string;
  bodyTemplate: string;
  difficulty: "easy" | "medium" | "challenging";
  xpReward: number;
  tags: string[];
  locales: string[];
}

// ============================================================
// Fallback template library
// ============================================================
const FALLBACK_TEMPLATES: CardTemplate[] = [
  // SAY cards
  { id: "say_001", type: "say", titleTemplate: "Tell her one thing you admire", bodyTemplate: "Think of something specific you admire about {partnerName} -- her laugh, her determination, her kindness -- and tell her directly.", difficulty: "easy", xpReward: 10, tags: ["appreciation", "daily"], locales: ["en", "ar", "ms"] },
  { id: "say_002", type: "say", titleTemplate: "Send a midday check-in", bodyTemplate: "Send {partnerName} a thoughtful message in the middle of the day. Ask about something specific she mentioned recently.", difficulty: "easy", xpReward: 10, tags: ["communication", "daily"], locales: ["en", "ar", "ms"] },
  { id: "say_003", type: "say", titleTemplate: "Express gratitude for something small", bodyTemplate: "Thank {partnerName} for something she did recently that you may have overlooked. Small things matter most.", difficulty: "easy", xpReward: 10, tags: ["gratitude", "daily"], locales: ["en", "ar", "ms"] },
  // DO cards
  { id: "do_001", type: "do", titleTemplate: "Handle one of her chores today", bodyTemplate: "Take over one task that {partnerName} usually handles. Do it without being asked and without expecting praise.", difficulty: "easy", xpReward: 15, tags: ["acts_of_service", "daily"], locales: ["en", "ar", "ms"] },
  { id: "do_002", type: "do", titleTemplate: "Plan a surprise mini-date", bodyTemplate: "Organize something simple but thoughtful: coffee at her favorite spot, a sunset walk, or her favorite takeout with candles.", difficulty: "medium", xpReward: 20, tags: ["quality_time", "weekly"], locales: ["en", "ar", "ms"] },
  { id: "do_003", type: "do", titleTemplate: "Create a playlist for her", bodyTemplate: "Build a playlist of songs that remind you of {partnerName} or songs she loves. Share it with a personal note.", difficulty: "easy", xpReward: 15, tags: ["thoughtful", "creative"], locales: ["en", "ar", "ms"] },
  // BUY cards
  { id: "buy_001", type: "buy", titleTemplate: "Get her favorite snack", bodyTemplate: "Pick up {partnerName}'s favorite treat on your way home. No occasion needed -- just because.", difficulty: "easy", xpReward: 10, tags: ["gifts", "simple"], locales: ["en", "ar", "ms"] },
  { id: "buy_002", type: "buy", titleTemplate: "Order flowers for no reason", bodyTemplate: "Surprise {partnerName} with her favorite flowers. If you don't know her favorite, ask -- she will love that you cared to ask.", difficulty: "medium", xpReward: 20, tags: ["gifts", "romantic"], locales: ["en", "ar", "ms"] },
  // GO cards
  { id: "go_001", type: "go", titleTemplate: "Take a walk together tonight", bodyTemplate: "After dinner, suggest a walk together. Leave your phones behind. Just be present with {partnerName}.", difficulty: "easy", xpReward: 15, tags: ["quality_time", "health"], locales: ["en", "ar", "ms"] },
  { id: "go_002", type: "go", titleTemplate: "Visit somewhere she mentioned", bodyTemplate: "Remember that cafe, park, or shop {partnerName} mentioned wanting to visit? Take her there this weekend.", difficulty: "medium", xpReward: 25, tags: ["quality_time", "listening"], locales: ["en", "ar", "ms"] },
];

// ============================================================
// Context factor analysis
// ============================================================
interface UserContext {
  partnerName: string;
  zodiacSign: string | null;
  loveLanguage: string | null;
  culturalBackground: string | null;
  religiousObservance: string | null;
  currentStreak: number;
  recentCardTypes: CardCategory[];
  upcomingReminders: { title: string; daysUntil: number; type: string }[];
  locale: SupportedLocale;
  tier: string;
}

async function gatherUserContext(userId: string): Promise<UserContext | null> {
  const userDoc = await db.collection("users").doc(userId).get();
  if (!userDoc.exists) return null;
  const userData = userDoc.data()!;

  // Get partner profile
  const profilesSnap = await db.collection("users").doc(userId)
    .collection("partnerProfiles")
    .where("deletedAt", "==", null).limit(1).get();

  let partnerName = "her";
  let zodiacSign = null;
  let loveLanguage = null;
  let culturalBackground = null;
  let religiousObservance = null;

  if (!profilesSnap.empty) {
    const profile = profilesSnap.docs[0].data();
    partnerName = profile.name || "her";
    zodiacSign = profile.zodiacSign || null;
    loveLanguage = profile.loveLanguage || null;
    culturalBackground = profile.culturalContext?.background || null;
    religiousObservance = profile.culturalContext?.religiousObservance || null;
  }

  // Get gamification data
  const gamDoc = await db.collection("gamification").doc(userId).get();
  const currentStreak = gamDoc.exists ? gamDoc.data()!.currentStreak || 0 : 0;

  // Get recent card types (last 7 days) for diversity
  const weekAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString();
  const recentCardsSnap = await db.collection("users").doc(userId)
    .collection("actionCards")
    .where("createdAt", ">=", weekAgo)
    .orderBy("createdAt", "desc").limit(20).get();

  const recentCardTypes = recentCardsSnap.docs.map((d) => d.data().type as CardCategory);

  // Get upcoming reminders (next 7 days)
  const now = new Date();
  const weekLater = new Date(now.getTime() + 7 * 24 * 60 * 60 * 1000);
  const remindersSnap = await db.collection("users").doc(userId)
    .collection("reminders")
    .where("deletedAt", "==", null)
    .where("completed", "==", false)
    .where("date", ">=", now.toISOString().split("T")[0])
    .where("date", "<=", weekLater.toISOString().split("T")[0])
    .orderBy("date", "asc").limit(5).get();

  const upcomingReminders = remindersSnap.docs.map((d) => {
    const r = d.data();
    const daysUntil = Math.ceil((new Date(r.date).getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
    return { title: r.title, daysUntil, type: r.category };
  });

  return {
    partnerName, zodiacSign, loveLanguage,
    culturalBackground, religiousObservance,
    currentStreak, recentCardTypes, upcomingReminders,
    locale: userData.language || "en",
    tier: userData.tier || "free",
  };
}

// ============================================================
// AI-powered card generation
// ============================================================
async function generateCardsWithAI(
  userId: string, context: UserContext, count: number
): Promise<CardTemplate[]> {
  const aiRequest: AIRequest = {
    requestId: uuidv4(), userId, tier: context.tier as any,
    requestType: "action_card",
    parameters: { tone: "warm", length: "short", language: context.locale },
    context: {
      partnerName: context.partnerName,
      relationshipStatus: "married",
      zodiacSign: context.zodiacSign as any,
      loveLanguage: context.loveLanguage as any,
      culturalBackground: context.culturalBackground || undefined,
      religiousObservance: context.religiousObservance as any,
      emotionalState: "neutral",
    },
    timestamp: new Date().toISOString(),
  };

  try {
    const response = await routeAIRequest(aiRequest);

    // Parse AI response into card templates
    const parsed = parseAICardResponse(response.content, context.partnerName);
    return parsed.slice(0, count);
  } catch (err) {
    functions.logger.warn("AI card generation failed, using fallback", { userId, error: err });
    return [];
  }
}

function parseAICardResponse(content: string, partnerName: string): CardTemplate[] {
  try {
    // Try to parse JSON from AI response
    const jsonMatch = content.match(/\[[\s\S]*\]/);
    if (!jsonMatch) return [];

    const parsed = JSON.parse(jsonMatch[0]);
    return parsed.map((card: any, idx: number) => ({
      id: `ai_${Date.now()}_${idx}`,
      type: (card.category || card.type || "do").toLowerCase() as CardCategory,
      titleTemplate: card.title || "Daily action",
      bodyTemplate: (card.description || card.body || "").replace(/\{name\}/g, `{partnerName}`),
      difficulty: card.difficulty || "easy",
      xpReward: card.xpReward || 15,
      tags: card.tags || ["ai_generated"],
      locales: ["en", "ar", "ms"],
    }));
  } catch {
    return [];
  }
}

// ============================================================
// Cultural filtering
// ============================================================
function filterCardsByCulture(
  cards: CardTemplate[], context: UserContext
): CardTemplate[] {
  return cards.filter((card) => {
    // Check locale support
    if (!card.locales.includes(context.locale)) return false;

    // Cultural sensitivity filters
    if (context.religiousObservance === "high") {
      // During Ramadan-related periods, avoid food/drink BUY cards
      if (card.type === "buy" && card.tags.includes("food")) return false;
      // Avoid overly physical suggestions
      if (card.tags.includes("physical")) return false;
    }

    return true;
  });
}

// ============================================================
// Card type mix ensuring diversity
// ============================================================
function selectDiverseCards(
  available: CardTemplate[], count: number, recentTypes: CardCategory[]
): CardTemplate[] {
  const typeTargets: CardCategory[] = ["say", "do", "buy", "go"];
  const selected: CardTemplate[] = [];
  const used = new Set<string>();

  // First pass: ensure at least one of each underrepresented type
  const recentCounts: Record<string, number> = { say: 0, do: 0, buy: 0, go: 0 };
  recentTypes.forEach((t) => { if (recentCounts[t] !== undefined) recentCounts[t]++; });

  // Sort types by least recent usage
  const sortedTypes = typeTargets.sort((a, b) => recentCounts[a] - recentCounts[b]);

  for (const type of sortedTypes) {
    if (selected.length >= count) break;
    const candidates = available.filter((c) => c.type === type && !used.has(c.id));
    if (candidates.length > 0) {
      const pick = candidates[Math.floor(Math.random() * candidates.length)];
      selected.push(pick);
      used.add(pick.id);
    }
  }

  // Fill remaining slots
  const remaining = available.filter((c) => !used.has(c.id));
  while (selected.length < count && remaining.length > 0) {
    const idx = Math.floor(Math.random() * remaining.length);
    selected.push(remaining[idx]);
    remaining.splice(idx, 1);
  }

  return selected;
}

// ============================================================
// Main daily generation function (enhanced)
// ============================================================
export const dailyCardsGeneration = functions.scheduler.onSchedule(
  { schedule: "0 * * * *", timeoutSeconds: 300, memory: "1GiB" },
  async () => {
    const now = new Date();
    const currentHourUTC = now.getUTCHours();
    const todayStr = now.toISOString().split("T")[0];

    // Find users whose local midnight matches this UTC hour
    const targetOffset = -currentHourUTC;

    const usersSnap = await db.collection("users")
      .where("settings.timezoneOffset", "==", targetOffset).get();

    let generated = 0;
    let skipped = 0;
    let failed = 0;

    for (const userDoc of usersSnap.docs) {
      const userId = userDoc.id;

      try {
        // Check if cards already generated today
        const existing = await db.collection("users").doc(userId)
          .collection("actionCards")
          .where("date", "==", todayStr).limit(1).get();
        if (!existing.empty) { skipped++; continue; }

        const context = await gatherUserContext(userId);
        if (!context) { skipped++; continue; }

        const cardCount = Math.min(
          CARD_LIMITS[context.tier] || 3,
          8 // Max 8 cards per day even for Legend
        );

        // Step 1: Try AI generation for personalized cards
        let aiCards = await generateCardsWithAI(userId, context, cardCount);

        // Step 2: Cultural filtering
        aiCards = filterCardsByCulture(aiCards, context);

        // Step 3: Supplement with fallback templates if AI returned fewer cards
        let allCards = [...aiCards];
        if (allCards.length < cardCount) {
          const fallbacks = filterCardsByCulture(FALLBACK_TEMPLATES, context);
          const aiIds = new Set(allCards.map((c) => c.id));
          const availableFallbacks = fallbacks.filter((f) => !aiIds.has(f.id));
          allCards = [...allCards, ...availableFallbacks];
        }

        // Step 4: Select diverse mix
        const selectedCards = selectDiverseCards(allCards, cardCount, context.recentCardTypes);

        // Step 5: Store cards
        const batch = db.batch();
        const cardDocs: any[] = [];

        for (const card of selectedCards) {
          const cardId = uuidv4();
          const title = card.titleTemplate.replace(/\{partnerName\}/g, context.partnerName);
          const body = card.bodyTemplate.replace(/\{partnerName\}/g, context.partnerName);

          const cardData = {
            type: card.type.toUpperCase(),
            title, body,
            context: `Generated based on partner profile and relationship context`,
            difficulty: card.difficulty,
            status: "pending",
            xpReward: card.xpReward,
            date: todayStr,
            partnerProfileId: null,
            templateId: card.id,
            tags: card.tags,
            expiresAt: new Date(now.getTime() + 24 * 60 * 60 * 1000).toISOString(),
            createdAt: now.toISOString(),
            completedAt: null,
          };

          const ref = db.collection("users").doc(userId)
            .collection("actionCards").doc(cardId);
          batch.set(ref, cardData);
          cardDocs.push({ id: cardId, ...cardData });
        }

        await batch.commit();

        // Step 6: Send notification
        await sendTemplatedNotification(
          userId, "daily_action_cards",
          { partnerName: context.partnerName },
          context.locale,
          { type: "action_cards", date: todayStr }
        );

        // Step 7: Cache for quick retrieval
        await redis.setex(
          `action-cards:daily:${userId}:${todayStr}`,
          43200,
          JSON.stringify({ data: { date: todayStr, cards: cardDocs, summary: { totalCards: cardDocs.length, completedToday: 0, totalXpAvailable: cardDocs.reduce((sum, c) => sum + c.xpReward, 0) } } })
        );

        generated++;
      } catch (err) {
        functions.logger.error("Failed to generate cards for user", { userId, error: err });
        failed++;
      }
    }

    functions.logger.info("Daily cards generation complete", { generated, skipped, failed });
  }
);
```

---

## 7. New Zod Validation Schemas (Sprint 2 additions)

### validators/schemas.ts (additions)

```typescript
// Append to functions/src/validators/schemas.ts

// --- Reminder (extended) ---
export const updateReminderSchema = z.object({
  title: z.string().min(1).max(200).optional(),
  description: z.string().max(1000).optional(),
  date: z.string().optional(),
  time: z.string().regex(/^\d{2}:\d{2}$/).optional(),
  isRecurring: z.boolean().optional(),
  recurrenceRule: z.enum(["yearly", "monthly", "weekly", "daily", "none"]).optional(),
  reminderTiers: z.array(z.number().int()).optional(),
});

export const snoozeReminderSchema = z.object({
  duration: z.enum(["1h", "3h", "1d", "3d", "1w"]),
});

export const completeReminderSchema = z.object({
  notes: z.string().max(500).optional(),
});

// --- Memory (extended) ---
export const updateMemorySchema = z.object({
  title: z.string().min(1).max(200).optional(),
  description: z.string().max(5000).optional(),
  category: z.enum(["moment", "milestone", "conflict_resolution", "gift_given", "trip", "quote", "other"]).optional(),
  date: z.string().optional(),
  mood: z.enum(["happy", "romantic", "grateful", "bittersweet", "proud", "funny"]).optional(),
  tags: z.array(z.string().max(50)).max(10).optional(),
  isFavorite: z.boolean().optional(),
});

export const createWishlistSchema = z.object({
  item: z.string().min(1).max(200),
  category: z.enum(["fashion", "electronics", "experience", "home", "beauty", "books", "food", "travel", "other"]).optional(),
  priority: z.enum(["high", "medium", "low"]).default("medium"),
  estimatedPrice: z.number().min(0).optional(),
  currency: z.string().max(3).optional(),
  link: z.string().url().optional(),
  notes: z.string().max(500).optional(),
});

// --- Partner Profile (extended) ---
export const updatePartnerProfileSchema = z.object({
  name: z.string().min(1).max(100).optional(),
  birthday: z.string().optional(),
  zodiacSign: z.enum([
    "aries","taurus","gemini","cancer","leo","virgo",
    "libra","scorpio","sagittarius","capricorn","aquarius","pisces",
  ]).optional(),
  loveLanguage: z.enum(["words","acts","gifts","time","touch"]).optional(),
  communicationStyle: z.enum(["direct","indirect","mixed"]).optional(),
  relationshipStatus: z.enum(["dating","engaged","married"]).optional(),
  anniversaryDate: z.string().optional(),
  photoUrl: z.string().url().optional(),
});

export const updatePreferencesSchema = z.object({
  favorites: z.object({
    flowers: z.array(z.string()).optional(),
    food: z.array(z.string()).optional(),
    music: z.array(z.string()).optional(),
    movies: z.array(z.string()).optional(),
    brands: z.array(z.string()).optional(),
    colors: z.array(z.string()).optional(),
  }).optional(),
  dislikes: z.array(z.string()).max(50).optional(),
  hobbies: z.array(z.string()).max(30).optional(),
  stressCoping: z.string().max(500).optional(),
  notes: z.string().max(2000).optional(),
});

export const updateCulturalContextSchema = z.object({
  background: z.enum([
    "gulf_arab", "levantine", "egyptian", "north_african",
    "malay", "western", "south_asian", "east_asian", "other",
  ]).optional(),
  religiousObservance: z.enum(["high", "moderate", "low", "secular"]).optional(),
  dialect: z.enum(["msa", "gulf", "egyptian", "levantine"]).optional(),
});
```

---

## 8. Updated Function Exports

### index.ts (additions for Sprint 2)

```typescript
// Append to functions/src/index.ts

import { dailyCardsGeneration } from "./scheduled/dailyCards";
import { processPendingNotifications } from "./services/notificationScheduler";
import * as functions from "firebase-functions/v2";

// Re-export the enhanced daily cards scheduled function
export { dailyCardsGeneration };

// New: Notification processor (runs every 5 minutes)
export const notificationProcessor = functions.scheduler.onSchedule(
  { schedule: "every 5 minutes", timeoutSeconds: 120, memory: "512MiB" },
  async () => {
    const sent = await processPendingNotifications();
    functions.logger.info("Notification processor complete", { sent });
  }
);

// New: Calendar sync trigger (runs every 6 hours)
import { fullCalendarSync } from "./services/calendarSync";

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

// New: Streak risk notification (runs daily at 8 PM UTC)
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
```

---

## Summary

### Files Created/Modified in Sprint 2

| File | Type | Description |
|------|------|-------------|
| `api/reminders.ts` | New | Full CRUD + snooze + complete + upcoming with recurrence engine |
| `api/memories.ts` | New | Memory Vault with encryption, media upload, timeline, wishlist |
| `api/profiles.ts` | New | Partner profiles with zodiac defaults, preferences, cultural context |
| `services/notificationScheduler.ts` | New | Escalation scheduling, quiet hours, dedup, timezone-aware delivery |
| `services/calendarSync.ts` | New | Google Calendar two-way sync, OAuth management, Hijri conversion |
| `services/recurrenceEngine.ts` | New | Recurrence rule validation and next-occurrence computation |
| `scheduled/dailyCards.ts` | Enhanced | AI + fallback card generation, cultural filtering, type diversity |
| `validators/schemas.ts` | Extended | New Zod schemas for reminders, memories, profiles, wishlist |
| `index.ts` | Extended | New scheduled function exports |

### Key Technical Decisions

1. **Soft deletes everywhere**: All delete operations set `deletedAt` instead of removing documents, enabling recovery and audit trails.

2. **AES-256-GCM encryption**: Memory content marked as `isPrivate` is encrypted using the Sprint 1 encryption service before storage. Decryption happens only at read time.

3. **Notification deduplication**: Uses Redis keys with 24-hour TTL (`notif:sent:{deduplicationKey}`) to prevent duplicate notifications if the scheduled function runs multiple times.

4. **Recurrence engine**: Handles daily/weekly/monthly/yearly recurrence with proper month-end overflow (Jan 31 monthly becomes Feb 28) and leap year handling.

5. **Cultural filtering**: Action cards are filtered based on the user's `religiousObservance` setting, preventing culturally inappropriate suggestions during religious periods like Ramadan.

6. **Calendar sync conflict resolution**: LOLO-exported events take priority (skip on reimport). Google Calendar imports create new reminders only if no title+date match exists.

7. **Hijri date conversion**: Built-in utility for Arabic users who prefer Islamic calendar dates, using a pure algorithmic conversion (no external library dependency).

8. **Tiered media limits**: Memory photo uploads respect per-tier limits (Free: 3, Pro: 10, Legend: 10 per memory) with 10MB image / 50MB video size caps.

### Firestore Indexes Required (Sprint 2)

```json
{
  "indexes": [
    {
      "collectionGroup": "reminders",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "deletedAt", "order": "ASCENDING" },
        { "fieldPath": "completed", "order": "ASCENDING" },
        { "fieldPath": "date", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "memories",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "deletedAt", "order": "ASCENDING" },
        { "fieldPath": "category", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "memories",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "deletedAt", "order": "ASCENDING" },
        { "fieldPath": "date", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "wishlist",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "deletedAt", "order": "ASCENDING" },
        { "fieldPath": "priority", "order": "ASCENDING" },
        { "fieldPath": "addedAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "scheduled_notifications",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "scheduledFor", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "partnerProfiles",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "deletedAt", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "actionCards",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "date", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    }
  ]
}
```

### Environment Variables Required (Sprint 2)

```env
# Added in Sprint 2 (append to .env)
GOOGLE_CLIENT_ID=your_google_oauth_client_id
GOOGLE_CLIENT_SECRET=your_google_oauth_client_secret
GOOGLE_CALENDAR_REDIRECT_URI=https://us-central1-lolo-app.cloudfunctions.net/api/v1/auth/google/callback
```

### Redis Cache Keys (Sprint 2)

| Key Pattern | TTL | Description |
|-------------|-----|-------------|
| `reminders:list:{uid}:{type}:{status}:{cursor}` | 120s | Paginated reminder lists |
| `reminders:upcoming:{uid}:{days}` | 60s | Upcoming reminders (7/30 day) |
| `memories:list:{uid}:{category}:{cursor}` | 120s | Paginated memory lists |
| `memories:timeline:{uid}:{year}` | 300s | Timeline grouped by month |
| `memories:wishlist:{uid}` | 300s | Wishlist items |
| `profile:{id}` | 600s | Partner profile with zodiac |
| `zodiac:defaults:{sign}:{locale}` | 86400s | Zodiac personality data |
| `user:tz:{uid}` | 3600s | User timezone |
| `quiet_hours:{uid}` | 3600s | Quiet hours config |
| `notif:sent:{dedupKey}` | 86400s | Notification dedup flag |
| `action-cards:daily:{uid}:{date}` | 43200s | Today's action cards |
