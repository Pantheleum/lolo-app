// functions/src/validators/schemas.ts
import { z } from "zod";

// --- Auth ---
export const registerSchema = z.object({
  email: z.string().email().max(255),
  password: z.string().min(8).regex(
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)/,
    "Must contain uppercase, lowercase, and number"
  ),
  displayName: z.string().min(2).max(50),
  language: z.enum(["en", "ar", "ms"]),
});

export const loginSchema = z.object({
  email: z.string().email(),
  password: z.string().min(1),
});

export const socialAuthSchema = z.object({
  provider: z.enum(["google", "apple"]),
  idToken: z.string().min(1),
  nonce: z.string().optional(),
  language: z.enum(["en", "ar", "ms"]).default("en"),
});

export const updateProfileSchema = z.object({
  displayName: z.string().min(2).max(50).optional(),
  profilePhotoUrl: z.string().url().optional(),
});

export const changeLanguageSchema = z.object({
  language: z.enum(["en", "ar", "ms"]),
});

export const deleteAccountSchema = z.object({
  confirmationPhrase: z.literal("DELETE MY ACCOUNT"),
  reason: z.string().max(500).optional(),
});

// --- Partner Profile ---
export const createPartnerProfileSchema = z.object({
  name: z.string().min(1).max(100),
  birthday: z.string().optional(),
  zodiacSign: z.enum([
    "aries","taurus","gemini","cancer","leo","virgo",
    "libra","scorpio","sagittarius","capricorn","aquarius","pisces",
  ]).optional(),
  loveLanguage: z.enum(["words","acts","gifts","time","touch"]).optional(),
  communicationStyle: z.enum(["direct","indirect","mixed"]).optional(),
  relationshipStatus: z.enum(["dating","engaged","married"]),
  anniversaryDate: z.string().optional(),
  photoUrl: z.string().url().optional(),
});

// --- Reminders ---
export const createReminderSchema = z.object({
  title: z.string().min(1).max(200),
  description: z.string().max(1000).optional(),
  type: z.enum(["birthday","anniversary","islamic_holiday","cultural","custom","promise"]),
  date: z.string(),
  time: z.string().regex(/^\d{2}:\d{2}$/).optional(),
  isRecurring: z.boolean().default(false),
  recurrenceRule: z.enum(["yearly","monthly","weekly","none"]).default("none"),
  reminderTiers: z.array(z.number().int()).default([7,3,1,0]),
  linkedProfileId: z.string().optional(),
});

// --- Messages ---
export const generateMessageSchema = z.object({
  mode: z.enum([
    "good_morning","checking_in","appreciation","motivation",
    "celebration","flirting","reassurance","long_distance",
    "apology","after_argument",
  ]),
  tone: z.enum(["warm","playful","serious","romantic","gentle","confident"]),
  length: z.enum(["short","medium","long"]),
  profileId: z.string(),
  situationContext: z.string().max(500).optional(),
});

// --- SOS ---
export const sosActivateSchema = z.object({
  scenario: z.enum([
    "she_is_angry","she_is_crying","she_is_silent","caught_in_lie",
    "forgot_important_date","said_wrong_thing","she_wants_to_talk",
    "her_family_conflict","jealousy_issue","other",
  ]),
  urgency: z.enum(["happening_now","just_happened","brewing"]),
  briefContext: z.string().max(200).optional(),
  profileId: z.string().optional(),
});

export const sosAssessSchema = z.object({
  sessionId: z.string(),
  answers: z.object({
    howLongAgo: z.enum(["minutes","hours","today","yesterday"]),
    herCurrentState: z.enum(["calm","upset","very_upset","crying","furious","silent"]),
    haveYouSpoken: z.boolean(),
    isSheTalking: z.boolean(),
    yourFault: z.enum(["yes","no","partially","unsure"]),
    previousSimilar: z.boolean().optional(),
    additionalContext: z.string().max(300).optional(),
  }),
});

export const sosCoachSchema = z.object({
  sessionId: z.string(),
  stepNumber: z.number().int().min(1),
  userUpdate: z.string().max(500).optional(),
  herResponse: z.string().max(500).optional(),
  stream: z.boolean().default(false),
});

export const sosResolveSchema = z.object({
  sessionId: z.string(),
  outcome: z.enum(["resolved_well","partially_resolved","still_ongoing","got_worse","abandoned"]),
  whatWorked: z.string().max(500).optional(),
  whatDidntWork: z.string().max(500).optional(),
  wouldUseAgain: z.boolean().optional(),
  rating: z.number().int().min(1).max(5).optional(),
});

// --- Gamification ---
export const logActionSchema = z.object({
  actionType: z.enum([
    "action_card_complete","reminder_complete","message_generated",
    "message_feedback","gift_feedback","sos_resolved","memory_added",
    "profile_updated","daily_login","streak_milestone",
  ]),
  referenceId: z.string().optional(),
  metadata: z.record(z.unknown()).optional(),
});

// --- Notifications ---
export const registerTokenSchema = z.object({
  token: z.string().min(1),
  platform: z.enum(["ios","android"]),
  deviceId: z.string().min(1),
  appVersion: z.string().optional(),
});

export const notificationPreferencesSchema = z.object({
  channels: z.object({
    push: z.boolean().optional(),
    inApp: z.boolean().optional(),
  }).optional(),
  types: z.record(z.boolean()).optional(),
});

// --- Gift ---
export const giftRecommendSchema = z.object({
  profileId: z.string(),
  occasion: z.string().max(100),
  budgetMin: z.number().min(0).optional(),
  budgetMax: z.number().min(0).optional(),
  preferences: z.array(z.string()).max(10).optional(),
});

// --- Action Cards ---
export const completeCardSchema = z.object({
  cardId: z.string(),
  feedback: z.enum(["loved_it","it_was_ok","not_for_me"]).optional(),
  notes: z.string().max(500).optional(),
});

// --- Memories ---
export const createMemorySchema = z.object({
  title: z.string().min(1).max(200),
  description: z.string().max(2000).optional(),
  date: z.string(),
  type: z.enum(["moment","milestone","lesson","wishlist"]),
  tags: z.array(z.string().max(50)).max(10).optional(),
  isPrivate: z.boolean().default(false),
});

// --- Settings ---
export const updateSettingsSchema = z.object({
  quietHoursEnabled: z.boolean().optional(),
  quietHoursStart: z.string().regex(/^\d{2}:\d{2}$/).optional(),
  quietHoursEnd: z.string().regex(/^\d{2}:\d{2}$/).optional(),
  timezone: z.string().optional(),
  biometricEnabled: z.boolean().optional(),
});
