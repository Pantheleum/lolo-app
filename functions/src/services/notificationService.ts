// functions/src/services/notificationService.ts
import { messaging, db, redis } from "../config";
import { SupportedLocale, NotificationPayload } from "../types";
import * as functions from "firebase-functions";

// --- Locale templates ---
const TEMPLATES: Record<string, Record<SupportedLocale, { title: string; body: string }>> = {
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
  daily_action_cards: {
    en: { title: "Your daily actions are ready", body: "3 new ways to show {partnerName} you care. Tap to see." },
    ar: { title: "بطاقات الأفعال اليومية جاهزة", body: "3 طرق جديدة لإظهار اهتمامك بـ {partnerName}." },
    ms: { title: "Kad tindakan harian anda sedia", body: "3 cara baharu untuk tunjukkan {partnerName} anda ambil berat." },
  },
  streak_at_risk: {
    en: { title: "Your streak is at risk!", body: "Complete one action today to keep your {streakDays}-day streak alive." },
    ar: { title: "سلسلتك في خطر!", body: "أكمل إجراء واحدا اليوم للحفاظ على سلسلتك البالغة {streakDays} يوم." },
    ms: { title: "Streak anda dalam bahaya!", body: "Selesaikan satu tindakan hari ini untuk kekalkan streak {streakDays} hari." },
  },
  level_up: {
    en: { title: "Level Up! You reached Level {level}", body: "You are now a \"{levelName}\". Keep going!" },
    ar: { title: "ارتقيت! وصلت المستوى {level}", body: "أنت الآن \"{levelName}\". استمر!" },
    ms: { title: "Naik Level! Anda mencapai Level {level}", body: "Anda kini \"{levelName}\". Teruskan!" },
  },
  badge_earned: {
    en: { title: "Badge Earned: {badgeName}", body: "You unlocked a new achievement. View it in your profile." },
    ar: { title: "شارة جديدة: {badgeName}", body: "فتحت إنجازا جديدا. شاهده في ملفك الشخصي." },
    ms: { title: "Lencana Diperoleh: {badgeName}", body: "Anda membuka pencapaian baharu. Lihat di profil anda." },
  },
};

function fillTemplate(
  templateKey: string,
  locale: SupportedLocale,
  vars: Record<string, string>
): { title: string; body: string } {
  const tmpl = TEMPLATES[templateKey]?.[locale] || TEMPLATES[templateKey]?.en;
  if (!tmpl) return { title: templateKey, body: "" };

  let { title, body } = tmpl;
  for (const [key, val] of Object.entries(vars)) {
    title = title.replace(`{${key}}`, val);
    body = body.replace(`{${key}}`, val);
  }
  return { title, body };
}

async function isQuietHours(userId: string): Promise<boolean> {
  const settingsDoc = await db.collection("settings").doc(userId).get();
  if (!settingsDoc.exists) return false;
  const settings = settingsDoc.data()!;
  if (!settings.quietHoursEnabled) return false;

  const tz = settings.timezone || "UTC";
  const now = new Date().toLocaleTimeString("en-US", { timeZone: tz, hour12: false });
  const currentMinutes = parseInt(now.split(":")[0]) * 60 + parseInt(now.split(":")[1]);
  const startParts = (settings.quietHoursStart || "22:00").split(":");
  const endParts = (settings.quietHoursEnd || "07:00").split(":");
  const startMin = parseInt(startParts[0]) * 60 + parseInt(startParts[1]);
  const endMin = parseInt(endParts[0]) * 60 + parseInt(endParts[1]);

  if (startMin < endMin) return currentMinutes >= startMin && currentMinutes < endMin;
  return currentMinutes >= startMin || currentMinutes < endMin;
}

async function getUserTokens(userId: string): Promise<string[]> {
  const tokensSnap = await db.collection("fcm_tokens").where("userId", "==", userId).get();
  return tokensSnap.docs.map((d) => d.data().token);
}

export async function sendNotification(payload: NotificationPayload): Promise<void> {
  const quiet = await isQuietHours(payload.userId);
  if (quiet) {
    functions.logger.info("Skipping notification during quiet hours", { userId: payload.userId });
    return;
  }

  // Check user preferences
  const prefsDoc = await db.collection("notification_preferences").doc(payload.userId).get();
  if (prefsDoc.exists) {
    const prefs = prefsDoc.data()!;
    if (prefs.channels?.push === false) return;
    if (prefs.types?.[payload.type] === false) return;
  }

  const tokens = await getUserTokens(payload.userId);
  if (tokens.length === 0) return;

  const message = {
    notification: { title: payload.title, body: payload.body },
    data: payload.data || {},
    tokens,
  };

  try {
    const response = await messaging.sendEachForMulticast(message);
    // Clean up invalid tokens
    response.responses.forEach((resp, idx) => {
      if (!resp.success && resp.error?.code === "messaging/registration-token-not-registered") {
        db.collection("fcm_tokens").where("token", "==", tokens[idx]).get()
          .then((snap) => snap.docs.forEach((d) => d.ref.delete()));
      }
    });
  } catch (err) {
    functions.logger.error("FCM send failed", { error: err, userId: payload.userId });
  }

  // Store in-app notification
  await db.collection("notifications").add({
    userId: payload.userId,
    type: payload.type,
    title: payload.title,
    body: payload.body,
    data: payload.data || {},
    isRead: false,
    createdAt: new Date().toISOString(),
  });
}

export async function sendTemplatedNotification(
  userId: string,
  templateKey: string,
  vars: Record<string, string>,
  locale: SupportedLocale,
  data?: Record<string, string>
): Promise<void> {
  const { title, body } = fillTemplate(templateKey, locale, vars);
  await sendNotification({ userId, title, body, data, locale, type: templateKey });
}
