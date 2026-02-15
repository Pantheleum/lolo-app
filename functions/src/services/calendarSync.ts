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
