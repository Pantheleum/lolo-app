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
      ar: { title: "30 \u064a\u0648\u0645\u0627 \u062d\u062a\u0649 {eventName}", body: "\u0644\u062f\u064a\u0643 \u0648\u0642\u062a \u0643\u0627\u0641 \u0644\u062a\u062e\u0637\u064a\u0637 \u0634\u064a\u0621 \u0645\u0630\u0647\u0644 \u0644\u0640 {partnerName}!" },
      ms: { title: "30 hari lagi sehingga {eventName}", body: "Masa yang cukup untuk merancang sesuatu yang hebat untuk {partnerName}!" },
    },
    reminder_14d: {
      en: { title: "2 weeks until {eventName}", body: "Time to start thinking about {partnerName}'s special day!" },
      ar: { title: "\u0627\u0633\u0628\u0648\u0639\u0627\u0646 \u062d\u062a\u0649 {eventName}", body: "\u062d\u0627\u0646 \u0627\u0644\u0648\u0642\u062a \u0644\u0644\u062a\u0641\u0643\u064a\u0631 \u0641\u064a \u064a\u0648\u0645 {partnerName} \u0627\u0644\u0645\u0645\u064a\u0632!" },
      ms: { title: "2 minggu lagi sehingga {eventName}", body: "Masa untuk mula memikirkan hari istimewa {partnerName}!" },
    },
    reminder_7d: {
      en: { title: "7 days until {eventName}", body: "Start planning something special for {partnerName}!" },
      ar: { title: "7 \u0627\u064a\u0627\u0645 \u062d\u062a\u0649 {eventName}", body: "\u0627\u0628\u062f\u0623 \u0628\u0627\u0644\u062a\u062e\u0637\u064a\u0637 \u0644\u0634\u064a\u0621 \u0645\u0645\u064a\u0632 \u0644\u0640 {partnerName}!" },
      ms: { title: "7 hari lagi sehingga {eventName}", body: "Mula merancang sesuatu yang istimewa untuk {partnerName}!" },
    },
    reminder_3d: {
      en: { title: "3 days until {eventName}", body: "Time is running short! Have you planned for {partnerName}?" },
      ar: { title: "3 \u0627\u064a\u0627\u0645 \u062d\u062a\u0649 {eventName}", body: "\u0627\u0644\u0648\u0642\u062a \u064a\u0646\u0641\u062f! \u0647\u0644 \u062e\u0637\u0637\u062a \u0644\u0634\u064a\u0621 \u0644\u0640 {partnerName}\u061f" },
      ms: { title: "3 hari lagi sehingga {eventName}", body: "Masa semakin singkat! Sudah merancang untuk {partnerName}?" },
    },
    reminder_1d: {
      en: { title: "Tomorrow: {eventName}", body: "Final check -- is everything ready for {partnerName}?" },
      ar: { title: "\u063a\u062f\u0627: {eventName}", body: "\u062a\u062d\u0642\u0642 \u0623\u062e\u064a\u0631 -- \u0647\u0644 \u0643\u0644 \u0634\u064a\u0621 \u062c\u0627\u0647\u0632 \u0644\u0640 {partnerName}\u061f" },
      ms: { title: "Esok: {eventName}", body: "Semakan terakhir -- adakah semuanya sedia untuk {partnerName}?" },
    },
    reminder_day_of: {
      en: { title: "Today: {eventName}!", body: "Today is the day! Make it special for {partnerName}." },
      ar: { title: "\u0627\u0644\u064a\u0648\u0645: {eventName}!", body: "\u0627\u0644\u064a\u0648\u0645 \u0647\u0648 \u0627\u0644\u064a\u0648\u0645! \u0627\u062c\u0639\u0644\u0647 \u0645\u0645\u064a\u0632\u0627 \u0644\u0640 {partnerName}." },
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
