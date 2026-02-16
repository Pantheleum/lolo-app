// functions/src/types/index.ts
import { Request } from "express";

// --- Auth ---
export interface AuthUser {
  uid: string;
  email: string;
  displayName: string;
  language: SupportedLocale;
  tier: SubscriptionTier;
}

// Augment Express Request with auth properties (set by middleware)
declare global {
  namespace Express {
    interface Request {
      user: AuthUser;
      locale: SupportedLocale;
      requestId: string;
    }
  }
}

// Convenience type alias for routes that require auth middleware
export type AuthenticatedRequest = Request;

// --- Enums ---
export type SupportedLocale = "en" | "ar" | "ms";
export type SubscriptionTier = "free" | "pro" | "legend";
export type ZodiacSign =
  | "aries" | "taurus" | "gemini" | "cancer" | "leo" | "virgo"
  | "libra" | "scorpio" | "sagittarius" | "capricorn" | "aquarius" | "pisces";
export type LoveLanguage = "words" | "acts" | "gifts" | "time" | "touch";
export type CommunicationStyle = "direct" | "indirect" | "mixed";
export type RelationshipStatus = "dating" | "engaged" | "married";
export type MessageMode =
  | "good_morning" | "checking_in" | "appreciation" | "motivation"
  | "celebration" | "flirting" | "reassurance" | "long_distance"
  | "apology" | "after_argument";
export type Tone = "warm" | "playful" | "serious" | "romantic" | "gentle" | "confident";
export type MessageLength = "short" | "medium" | "long";
export type SOSScenario =
  | "she_is_angry" | "she_is_crying" | "she_is_silent" | "caught_in_lie"
  | "forgot_important_date" | "said_wrong_thing" | "she_wants_to_talk"
  | "her_family_conflict" | "jealousy_issue" | "other";
export type SOSUrgency = "happening_now" | "just_happened" | "brewing";
export type ActionType =
  | "action_card_complete" | "reminder_complete" | "message_generated"
  | "message_feedback" | "gift_feedback" | "sos_resolved" | "memory_added"
  | "profile_updated" | "daily_login" | "streak_milestone";
export type ReminderType =
  | "birthday" | "anniversary" | "islamic_holiday" | "cultural" | "custom" | "promise";
export type CardCategory = "say" | "do" | "buy" | "go";
export type BadgeCategory = "streak" | "messages" | "actions" | "gifts" | "sos" | "milestone";

// --- AI Router ---
export type AIRequestType =
  | "message" | "action_card" | "gift" | "sos_coaching"
  | "sos_assessment" | "analysis" | "memory_query";

export type LatencyRequirement = "relaxed" | "normal" | "urgent";
export type CostSensitivity = "minimal" | "standard" | "premium";

export interface AIClassification {
  taskType: AIRequestType;
  emotionalDepth: number;
  latencyRequirement: LatencyRequirement;
  costSensitivity: CostSensitivity;
}

export interface ModelSelection {
  primary: string;
  fallback: string | null;
  tertiary: string | null;
  timeout: number;
  maxOutputTokens: number;
}

export interface AIRequest {
  requestId: string;
  userId: string;
  tier: SubscriptionTier;
  requestType: AIRequestType;
  mode?: MessageMode;
  parameters: {
    tone: Tone;
    length: MessageLength;
    language: SupportedLocale;
    dialect?: string;
    formality?: "casual" | "moderate" | "formal";
  };
  context: AIContext;
  timestamp: string;
  clientVersion?: string;
  platform?: "ios" | "android";
}

export interface AIContext {
  partnerName: string;
  userName?: string;
  relationshipStatus: RelationshipStatus;
  relationshipDurationMonths?: number;
  zodiacSign?: ZodiacSign;
  loveLanguage?: LoveLanguage;
  communicationStyle?: CommunicationStyle;
  culturalBackground?: string;
  religiousObservance?: "high" | "moderate" | "low" | "secular";
  humorLevel?: number;
  cyclePhase?: string;
  isPregnant?: boolean;
  trimester?: number;
  emotionalState?: string;
  situationSeverity?: number;
  sosScenario?: string;
  conversationHistory?: { role: string; text: string }[];
  recentMemories?: string[];
}

export interface AIResponse {
  requestId: string;
  responseId: string;
  content: string;
  alternatives?: string[];
  metadata: {
    modelUsed: string;
    language: string;
    tokensUsed: { input: number; output: number };
    costUsd: number;
    latencyMs: number;
    cached: boolean;
    wasFallback: boolean;
    fallbackReason?: string;
    emotionalDepthScore: number;
  };
}

// --- Gamification ---
export interface GamificationProfile {
  userId: string;
  totalXp: number;
  level: number;
  levelName: string;
  currentStreak: number;
  longestStreak: number;
  lastActiveDate: string;
  freezesAvailable: number;
  freezesUsedThisMonth: number;
  badges: string[];
}

// --- Notification ---
export interface NotificationPayload {
  userId: string;
  title: string;
  body: string;
  data?: Record<string, string>;
  locale: SupportedLocale;
  type: string;
}

// --- Error ---
export class AppError extends Error {
  constructor(
    public statusCode: number,
    public code: string,
    message: string,
    public details?: Record<string, unknown>
  ) {
    super(message);
    this.name = "AppError";
  }
}
