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
