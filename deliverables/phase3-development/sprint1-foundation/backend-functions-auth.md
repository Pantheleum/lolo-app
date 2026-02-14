# LOLO Backend Implementation (Part B) -- Cloud Functions, Auth, AI Router, Notifications, Scheduled Jobs

**Task ID:** S1-02B
**Prepared by:** Raj Patel, Backend Developer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 1 -- Foundation (Weeks 9-10)
**Dependencies:** Architecture Document v1.0, API Contracts v1.0, AI Strategy Document v1.0

---

## Table of Contents

1. [Cloud Functions Project Structure](#1-cloud-functions-project-structure)
2. [Express App Setup](#2-express-app-setup)
3. [Shared Types](#3-shared-types)
4. [Zod Validation Schemas](#4-zod-validation-schemas)
5. [Middleware Layer](#5-middleware-layer)
6. [Authentication & Account API](#6-authentication--account-api)
7. [AI Router Service](#7-ai-router-service)
8. [AI Provider Integrations](#8-ai-provider-integrations)
9. [Prompt Builder](#9-prompt-builder)
10. [SOS Coaching with SSE](#10-sos-coaching-with-sse)
11. [Gamification Service](#11-gamification-service)
12. [Notification Service](#12-notification-service)
13. [Encryption Service](#13-encryption-service)
14. [Scheduled Functions](#14-scheduled-functions)
15. [Function Exports (index.ts)](#15-function-exports)

---

## 1. Cloud Functions Project Structure

```
functions/
  .env.example
  .eslintrc.js
  tsconfig.json
  package.json
  src/
    index.ts
    app.ts
    config.ts
    middleware/
      auth.ts
      rateLimit.ts
      locale.ts
      errorHandler.ts
    api/
      account.ts
      profiles.ts
      reminders.ts
      messages.ts
      gifts.ts
      sos.ts
      gamification.ts
      actionCards.ts
      memories.ts
      settings.ts
      notifications.ts
    ai/
      router.ts
      providers/
        claude.ts
        grok.ts
        gemini.ts
        gpt.ts
      promptBuilder.ts
    scheduled/
      dailyCards.ts
      reminderCheck.ts
      streakUpdate.ts
    services/
      gamificationService.ts
      notificationService.ts
      encryptionService.ts
    types/
      index.ts
    validators/
      schemas.ts
```

### package.json

```json
{
  "name": "lolo-functions",
  "version": "1.0.0",
  "main": "lib/index.js",
  "scripts": {
    "build": "tsc",
    "build:watch": "tsc --watch",
    "serve": "npm run build && firebase emulators:start --only functions",
    "shell": "npm run build && firebase functions:shell",
    "deploy": "firebase deploy --only functions",
    "lint": "eslint src/**/*.ts"
  },
  "engines": { "node": "20" },
  "dependencies": {
    "firebase-admin": "^12.0.0",
    "firebase-functions": "^5.0.0",
    "express": "^4.18.0",
    "cors": "^2.8.5",
    "helmet": "^7.1.0",
    "zod": "^3.22.0",
    "ioredis": "^5.3.0",
    "uuid": "^9.0.0",
    "@anthropic-ai/sdk": "^0.30.0",
    "openai": "^4.50.0",
    "@google/generative-ai": "^0.15.0"
  },
  "devDependencies": {
    "typescript": "^5.4.0",
    "@types/express": "^4.17.0",
    "@types/cors": "^2.8.0",
    "@types/uuid": "^9.0.0",
    "eslint": "^8.56.0",
    "@typescript-eslint/eslint-plugin": "^7.0.0",
    "@typescript-eslint/parser": "^7.0.0"
  }
}
```

### tsconfig.json

```json
{
  "compilerOptions": {
    "module": "commonjs",
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "outDir": "lib",
    "sourceMap": true,
    "strict": true,
    "target": "ES2022",
    "esModuleInterop": true,
    "resolveJsonModule": true,
    "skipLibCheck": true
  },
  "compileOnSave": true,
  "include": ["src"]
}
```

### config.ts

```typescript
// functions/src/config.ts
import * as admin from "firebase-admin";
import Redis from "ioredis";

admin.initializeApp();

export const db = admin.firestore();
export const auth = admin.auth();
export const messaging = admin.messaging();

const redisUrl = process.env.REDIS_URL || "redis://localhost:6379";
export const redis = new Redis(redisUrl, {
  maxRetriesPerRequest: 3,
  retryStrategy: (times) => Math.min(times * 200, 2000),
});

export const CONFIG = {
  AI_COST_BUDGET_DAILY_USD: 50,
  CACHE_TTL_DEFAULT: 300,
  CACHE_TTL_PROFILE: 600,
  CACHE_TTL_ZODIAC: 86400,
  SOS_SESSION_EXPIRY_MIN: 60,
  MAX_SOS_STEPS: 8,
} as const;
```

---

## 2. Express App Setup

### app.ts

```typescript
// functions/src/app.ts
import express from "express";
import cors from "cors";
import helmet from "helmet";

import { authMiddleware } from "./middleware/auth";
import { rateLimitMiddleware } from "./middleware/rateLimit";
import { localeMiddleware } from "./middleware/locale";
import { errorHandler, notFoundHandler } from "./middleware/errorHandler";

import accountRouter from "./api/account";
import profilesRouter from "./api/profiles";
import remindersRouter from "./api/reminders";
import messagesRouter from "./api/messages";
import giftsRouter from "./api/gifts";
import sosRouter from "./api/sos";
import gamificationRouter from "./api/gamification";
import actionCardsRouter from "./api/actionCards";
import memoriesRouter from "./api/memories";
import settingsRouter from "./api/settings";
import notificationsRouter from "./api/notifications";

const app = express();

// --- Global Middleware ---
app.use(helmet());
app.use(cors({
  origin: true,
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"],
  allowedHeaders: [
    "Content-Type",
    "Authorization",
    "Accept-Language",
    "X-Client-Version",
    "X-Platform",
    "X-Request-Id",
  ],
  maxAge: 86400,
}));
app.use(express.json({ limit: "1mb" }));
app.use(localeMiddleware);

// --- Public routes (no auth) ---
app.use("/api/v1/auth", accountRouter);

// --- Protected routes ---
app.use("/api/v1/profiles", authMiddleware, rateLimitMiddleware, profilesRouter);
app.use("/api/v1/reminders", authMiddleware, rateLimitMiddleware, remindersRouter);
app.use("/api/v1/messages", authMiddleware, rateLimitMiddleware, messagesRouter);
app.use("/api/v1/gifts", authMiddleware, rateLimitMiddleware, giftsRouter);
app.use("/api/v1/sos", authMiddleware, rateLimitMiddleware, sosRouter);
app.use("/api/v1/gamification", authMiddleware, rateLimitMiddleware, gamificationRouter);
app.use("/api/v1/action-cards", authMiddleware, rateLimitMiddleware, actionCardsRouter);
app.use("/api/v1/memories", authMiddleware, rateLimitMiddleware, memoriesRouter);
app.use("/api/v1/settings", authMiddleware, rateLimitMiddleware, settingsRouter);
app.use("/api/v1/notifications", authMiddleware, rateLimitMiddleware, notificationsRouter);

// --- Error handling ---
app.use(notFoundHandler);
app.use(errorHandler);

export default app;
```

---

## 3. Shared Types

### types/index.ts

```typescript
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

export interface AuthenticatedRequest extends Request {
  user: AuthUser;
  locale: SupportedLocale;
  requestId: string;
}

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
```

---

## 4. Zod Validation Schemas

### validators/schemas.ts

```typescript
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
```

---

## 5. Middleware Layer

### middleware/auth.ts

```typescript
// functions/src/middleware/auth.ts
import { Response, NextFunction } from "express";
import { auth, db } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

export async function authMiddleware(
  req: AuthenticatedRequest,
  _res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const header = req.headers.authorization;
    if (!header?.startsWith("Bearer ")) {
      throw new AppError(401, "UNAUTHENTICATED", "Missing or invalid authorization header");
    }

    const token = header.split("Bearer ")[1];
    const decoded = await auth.verifyIdToken(token);

    const userDoc = await db.collection("users").doc(decoded.uid).get();
    if (!userDoc.exists) {
      throw new AppError(401, "UNAUTHENTICATED", "User record not found");
    }

    const userData = userDoc.data()!;
    req.user = {
      uid: decoded.uid,
      email: decoded.email || "",
      displayName: userData.displayName || "",
      language: userData.language || "en",
      tier: userData.tier || "free",
    };

    req.requestId = (req.headers["x-request-id"] as string) || crypto.randomUUID();
    next();
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(new AppError(401, "UNAUTHENTICATED", "Invalid or expired token"));
  }
}
```

### middleware/rateLimit.ts

```typescript
// functions/src/middleware/rateLimit.ts
import { Response, NextFunction } from "express";
import { redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

interface RateLimitConfig {
  windowSeconds: number;
  maxRequests: number;
}

const ROUTE_LIMITS: Record<string, RateLimitConfig> = {
  "POST:/api/v1/auth/register": { windowSeconds: 60, maxRequests: 5 },
  "POST:/api/v1/auth/login": { windowSeconds: 60, maxRequests: 10 },
  "POST:/api/v1/sos/activate": { windowSeconds: 60, maxRequests: 5 },
  "POST:/api/v1/sos/coach": { windowSeconds: 60, maxRequests: 20 },
  "POST:/api/v1/messages/generate": { windowSeconds: 60, maxRequests: 15 },
  DEFAULT: { windowSeconds: 60, maxRequests: 30 },
};

export async function rateLimitMiddleware(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const routeKey = `${req.method}:${req.baseUrl}${req.path}`;
    const config = ROUTE_LIMITS[routeKey] || ROUTE_LIMITS.DEFAULT;
    const identifier = req.user?.uid || req.ip;
    const redisKey = `rl:${routeKey}:${identifier}`;

    const current = await redis.incr(redisKey);
    if (current === 1) {
      await redis.expire(redisKey, config.windowSeconds);
    }

    const ttl = await redis.ttl(redisKey);
    res.set("X-RateLimit-Limit", String(config.maxRequests));
    res.set("X-RateLimit-Remaining", String(Math.max(0, config.maxRequests - current)));
    res.set("X-RateLimit-Reset", String(ttl));

    if (current > config.maxRequests) {
      res.set("Retry-After", String(ttl));
      throw new AppError(429, "RATE_LIMITED", "Too many requests");
    }
    next();
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(); // fail open if Redis is down
  }
}
```

### middleware/locale.ts

```typescript
// functions/src/middleware/locale.ts
import { Request, Response, NextFunction } from "express";
import { SupportedLocale, AuthenticatedRequest } from "../types";

const SUPPORTED_LOCALES: SupportedLocale[] = ["en", "ar", "ms"];

export function localeMiddleware(
  req: Request,
  _res: Response,
  next: NextFunction
): void {
  const acceptLang = req.headers["accept-language"] as string | undefined;
  let locale: SupportedLocale = "en";

  if (acceptLang) {
    const preferred = acceptLang.split(",")[0].trim().substring(0, 2).toLowerCase();
    if (SUPPORTED_LOCALES.includes(preferred as SupportedLocale)) {
      locale = preferred as SupportedLocale;
    }
  }

  (req as AuthenticatedRequest).locale = locale;
  next();
}
```

### middleware/errorHandler.ts

```typescript
// functions/src/middleware/errorHandler.ts
import { Request, Response, NextFunction } from "express";
import { AppError } from "../types";
import * as functions from "firebase-functions";

export function errorHandler(
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
): void {
  if (err instanceof AppError) {
    res.status(err.statusCode).json({
      error: {
        code: err.code,
        message: err.message,
        details: err.details || {},
      },
    });
    return;
  }

  functions.logger.error("Unhandled error", { error: err.message, stack: err.stack });
  res.status(500).json({
    error: {
      code: "INTERNAL_ERROR",
      message: "An unexpected error occurred",
      details: {},
    },
  });
}

export function notFoundHandler(req: Request, res: Response): void {
  res.status(404).json({
    error: {
      code: "NOT_FOUND",
      message: `Route ${req.method} ${req.path} not found`,
      details: {},
    },
  });
}
```

---

## 6. Authentication & Account API

### api/account.ts

```typescript
// functions/src/api/account.ts
import { Router, Response, NextFunction, Request } from "express";
import { auth, db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import { authMiddleware } from "../middleware/auth";
import { rateLimitMiddleware } from "../middleware/rateLimit";
import {
  registerSchema, loginSchema, socialAuthSchema,
  updateProfileSchema, changeLanguageSchema, deleteAccountSchema,
} from "../validators/schemas";

const router = Router();

// POST /auth/register (public)
router.post("/register", rateLimitMiddleware as any, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const body = registerSchema.parse(req.body);

    const userRecord = await auth.createUser({
      email: body.email,
      password: body.password,
      displayName: body.displayName,
    });

    await db.collection("users").doc(userRecord.uid).set({
      email: body.email,
      displayName: body.displayName,
      language: body.language,
      tier: "free",
      onboardingComplete: false,
      createdAt: new Date().toISOString(),
      lastLoginAt: new Date().toISOString(),
    });

    // Initialize gamification profile
    await db.collection("gamification").doc(userRecord.uid).set({
      userId: userRecord.uid,
      totalXp: 0,
      level: 1,
      levelName: "Newbie",
      currentStreak: 0,
      longestStreak: 0,
      lastActiveDate: null,
      freezesAvailable: 1,
      freezesUsedThisMonth: 0,
      badges: [],
      createdAt: new Date().toISOString(),
    });

    const customToken = await auth.createCustomToken(userRecord.uid);

    res.status(201).json({
      data: {
        uid: userRecord.uid,
        email: body.email,
        displayName: body.displayName,
        language: body.language,
        tier: "free",
        idToken: customToken,
        refreshToken: "",
        expiresIn: 3600,
        onboardingComplete: false,
        createdAt: new Date().toISOString(),
      },
    });
  } catch (err: any) {
    if (err.code === "auth/email-already-exists") {
      return next(new AppError(409, "EMAIL_ALREADY_EXISTS", "Account with this email already exists"));
    }
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Validation failed", { errors: err.errors }));
    }
    next(err);
  }
});

// POST /auth/login (public)
router.post("/login", rateLimitMiddleware as any, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const body = loginSchema.parse(req.body);

    // Firebase Admin SDK doesn't do email/password sign-in directly.
    // In production, the client signs in via Firebase Auth SDK and gets the idToken.
    // This endpoint validates and returns user data given client-obtained tokens.
    // For server-side flow, we use Firebase Auth REST API.
    const firebaseAuthUrl = `https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${process.env.FIREBASE_API_KEY}`;

    const response = await fetch(firebaseAuthUrl, {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        email: body.email,
        password: body.password,
        returnSecureToken: true,
      }),
    });

    if (!response.ok) {
      const errData = await response.json();
      const errMsg = errData.error?.message;
      if (errMsg === "EMAIL_NOT_FOUND" || errMsg === "INVALID_PASSWORD") {
        throw new AppError(401, "INVALID_CREDENTIALS", "Wrong email or password");
      }
      if (errMsg === "USER_DISABLED") {
        throw new AppError(403, "ACCOUNT_DISABLED", "Account has been disabled");
      }
      throw new AppError(401, "INVALID_CREDENTIALS", "Authentication failed");
    }

    const authResult = await response.json();
    const uid = authResult.localId;

    await db.collection("users").doc(uid).update({ lastLoginAt: new Date().toISOString() });
    const userDoc = await db.collection("users").doc(uid).get();
    const userData = userDoc.data()!;

    res.json({
      data: {
        uid,
        email: userData.email,
        displayName: userData.displayName,
        language: userData.language,
        tier: userData.tier,
        idToken: authResult.idToken,
        refreshToken: authResult.refreshToken,
        expiresIn: Number(authResult.expiresIn),
        onboardingComplete: userData.onboardingComplete,
        lastLoginAt: userData.lastLoginAt,
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

// POST /auth/social (public)
router.post("/social", rateLimitMiddleware as any, async (req: Request, res: Response, next: NextFunction) => {
  try {
    const body = socialAuthSchema.parse(req.body);

    let decoded;
    try {
      decoded = await auth.verifyIdToken(body.idToken);
    } catch {
      throw new AppError(401, "INVALID_SOCIAL_TOKEN", "OAuth token invalid or expired");
    }

    let isNewUser = false;
    let userDoc = await db.collection("users").doc(decoded.uid).get();

    if (!userDoc.exists) {
      isNewUser = true;
      await db.collection("users").doc(decoded.uid).set({
        email: decoded.email || "",
        displayName: decoded.name || "",
        language: body.language,
        tier: "free",
        onboardingComplete: false,
        provider: body.provider,
        createdAt: new Date().toISOString(),
        lastLoginAt: new Date().toISOString(),
      });

      await db.collection("gamification").doc(decoded.uid).set({
        userId: decoded.uid,
        totalXp: 0, level: 1, levelName: "Newbie",
        currentStreak: 0, longestStreak: 0, lastActiveDate: null,
        freezesAvailable: 1, freezesUsedThisMonth: 0, badges: [],
        createdAt: new Date().toISOString(),
      });

      userDoc = await db.collection("users").doc(decoded.uid).get();
    } else {
      await db.collection("users").doc(decoded.uid).update({ lastLoginAt: new Date().toISOString() });
    }

    const userData = userDoc.data()!;
    const customToken = await auth.createCustomToken(decoded.uid);

    res.json({
      data: {
        uid: decoded.uid,
        email: userData.email,
        displayName: userData.displayName,
        language: userData.language,
        tier: userData.tier,
        idToken: customToken,
        refreshToken: "",
        expiresIn: 3600,
        isNewUser,
        onboardingComplete: userData.onboardingComplete,
        createdAt: userData.createdAt,
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

// GET /auth/profile (protected)
router.get("/profile", authMiddleware, async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const cacheKey = `user:profile:${req.user.uid}`;
    const cached = await redis.get(cacheKey);
    if (cached) {
      return res.json({ data: JSON.parse(cached) });
    }

    const userDoc = await db.collection("users").doc(req.user.uid).get();
    if (!userDoc.exists) throw new AppError(404, "NOT_FOUND", "User profile not found");

    const gamDoc = await db.collection("gamification").doc(req.user.uid).get();
    const gamData = gamDoc.exists ? gamDoc.data()! : {};

    const profile = {
      uid: req.user.uid,
      ...userDoc.data(),
      stats: {
        messagesGenerated: gamData.messagesGenerated || 0,
        actionCardsCompleted: gamData.actionCardsCompleted || 0,
        currentStreak: gamData.currentStreak || 0,
        memoriesCount: gamData.memoriesCount || 0,
      },
    };

    await redis.setex(cacheKey, 300, JSON.stringify(profile));
    res.json({ data: profile });
  } catch (err) {
    next(err);
  }
});

// PUT /auth/profile (protected)
router.put("/profile", authMiddleware, async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = updateProfileSchema.parse(req.body);
    const updates: Record<string, any> = { updatedAt: new Date().toISOString() };
    if (body.displayName) updates.displayName = body.displayName;
    if (body.profilePhotoUrl) updates.profilePhotoUrl = body.profilePhotoUrl;

    await db.collection("users").doc(req.user.uid).update(updates);
    await redis.del(`user:profile:${req.user.uid}`);

    res.json({
      data: {
        uid: req.user.uid,
        displayName: body.displayName || req.user.displayName,
        profilePhotoUrl: body.profilePhotoUrl || null,
        updatedAt: updates.updatedAt,
      },
    });
  } catch (err: any) {
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

// PUT /auth/language (protected)
router.put("/language", authMiddleware, async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = changeLanguageSchema.parse(req.body);
    await db.collection("users").doc(req.user.uid).update({
      language: body.language,
      updatedAt: new Date().toISOString(),
    });
    await redis.del(`user:profile:${req.user.uid}`);

    res.json({ data: { uid: req.user.uid, language: body.language, updatedAt: new Date().toISOString() } });
  } catch (err: any) {
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_LANGUAGE", "Unsupported language"));
    next(err);
  }
});

// DELETE /auth/account (protected)
router.delete("/account", authMiddleware, async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = deleteAccountSchema.parse(req.body);
    const now = new Date();
    const gracePeriodEnds = new Date(now.getTime() + 30 * 24 * 60 * 60 * 1000);

    await db.collection("users").doc(req.user.uid).update({
      deletionScheduledAt: now.toISOString(),
      gracePeriodEnds: gracePeriodEnds.toISOString(),
      deletionReason: body.reason || null,
      status: "pending_deletion",
    });

    await redis.del(`user:profile:${req.user.uid}`);

    res.json({
      data: {
        message: "Account scheduled for deletion",
        deletionScheduledAt: now.toISOString(),
        gracePeriodEnds: gracePeriodEnds.toISOString(),
        canRecover: true,
      },
    });
  } catch (err: any) {
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_CONFIRMATION", "Confirmation phrase does not match"));
    next(err);
  }
});

export default router;
```

---

## 7. AI Router Service

### ai/router.ts

```typescript
// functions/src/ai/router.ts
import { v4 as uuidv4 } from "uuid";
import { redis, db, CONFIG } from "../config";
import * as functions from "firebase-functions";
import {
  AIRequest, AIResponse, AIClassification, ModelSelection,
  AIRequestType, LatencyRequirement, CostSensitivity,
  SubscriptionTier, MessageMode,
} from "../types";
import { callClaude } from "./providers/claude";
import { callGrok } from "./providers/grok";
import { callGemini } from "./providers/gemini";
import { callGpt } from "./providers/gpt";
import { buildPrompt } from "./promptBuilder";

// --- Mode depth map ---
const MODE_DEPTH_MAP: Record<string, number> = {
  good_morning: 1, checking_in: 1, appreciation: 2, motivation: 2,
  celebration: 2, flirting: 2, reassurance: 3, long_distance: 3,
  apology: 4, after_argument: 4, sos_assessment: 5, sos_coaching: 5,
};

// --- Cost per 1K tokens by model ---
const COST_PER_1K: Record<string, { input: number; output: number }> = {
  "claude-sonnet-4.5": { input: 0.003, output: 0.015 },
  "claude-haiku-4.5":  { input: 0.00025, output: 0.00125 },
  "grok-4.1-fast":     { input: 0.0005, output: 0.002 },
  "gemini-flash":      { input: 0.000075, output: 0.0003 },
  "gpt-5-mini":        { input: 0.00015, output: 0.0006 },
};

// --- Tier to cost sensitivity ---
function costSensitivityFromTier(tier: SubscriptionTier): CostSensitivity {
  switch (tier) {
    case "legend": return "premium";
    case "pro": return "standard";
    default: return "minimal";
  }
}

// --- Classify request ---
export function classifyRequest(request: AIRequest): AIClassification {
  const taskType = request.requestType;

  // Emotional depth
  let emotionalDepth = MODE_DEPTH_MAP[request.mode || ""] || 2;
  const ctx = request.context;

  if (["angry", "crying", "anxious"].includes(ctx.emotionalState || "")) {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  if (ctx.cyclePhase === "luteal_late") {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  if (ctx.isPregnant && ctx.trimester === 1) {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  if ((ctx.situationSeverity || 0) >= 4) {
    emotionalDepth = Math.min(emotionalDepth + 1, 5);
  }
  emotionalDepth = Math.max(1, Math.min(5, emotionalDepth));

  // Latency
  let latencyRequirement: LatencyRequirement = "normal";
  if (taskType === "sos_coaching" || taskType === "sos_assessment") latencyRequirement = "urgent";
  else if (taskType === "action_card") latencyRequirement = "relaxed";

  return {
    taskType,
    emotionalDepth,
    latencyRequirement,
    costSensitivity: costSensitivityFromTier(request.tier),
  };
}

// --- Select model ---
export function selectModel(classification: AIClassification): ModelSelection {
  const { taskType, emotionalDepth, costSensitivity } = classification;

  if (taskType === "sos_coaching" || taskType === "sos_assessment") {
    return {
      primary: "grok-4.1-fast",
      fallback: "claude-haiku-4.5",
      tertiary: null,
      timeout: 3000,
      maxOutputTokens: 300,
    };
  }

  if (taskType === "gift" || taskType === "memory_query") {
    return {
      primary: "gemini-flash",
      fallback: "gpt-5-mini",
      tertiary: "claude-haiku-4.5",
      timeout: 10000,
      maxOutputTokens: 500,
    };
  }

  if (taskType === "analysis") {
    return {
      primary: "gemini-flash",
      fallback: "gpt-5-mini",
      tertiary: null,
      timeout: 8000,
      maxOutputTokens: 400,
    };
  }

  if (taskType === "message") {
    if (emotionalDepth >= 4) {
      return {
        primary: "claude-sonnet-4.5",
        fallback: "claude-haiku-4.5",
        tertiary: "gpt-5-mini",
        timeout: 8000,
        maxOutputTokens: 400,
      };
    }
    if (emotionalDepth >= 2 && costSensitivity === "premium") {
      return {
        primary: "claude-sonnet-4.5",
        fallback: "claude-haiku-4.5",
        tertiary: "gpt-5-mini",
        timeout: 8000,
        maxOutputTokens: 350,
      };
    }
    if (emotionalDepth >= 2) {
      return {
        primary: "claude-haiku-4.5",
        fallback: "gpt-5-mini",
        tertiary: null,
        timeout: 5000,
        maxOutputTokens: 300,
      };
    }
    return {
      primary: "claude-haiku-4.5",
      fallback: "gpt-5-mini",
      tertiary: null,
      timeout: 5000,
      maxOutputTokens: 250,
    };
  }

  if (taskType === "action_card") {
    return {
      primary: "claude-haiku-4.5",
      fallback: "gpt-5-mini",
      tertiary: null,
      timeout: 5000,
      maxOutputTokens: 300,
    };
  }

  return {
    primary: "gpt-5-mini",
    fallback: null,
    tertiary: null,
    timeout: 8000,
    maxOutputTokens: 300,
  };
}

// --- Call provider by model ID ---
async function callProvider(
  modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number,
  timeout: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const controller = new AbortController();
  const timer = setTimeout(() => controller.abort(), timeout);

  try {
    if (modelId.startsWith("claude")) return await callClaude(modelId, systemPrompt, userPrompt, maxTokens);
    if (modelId.startsWith("grok")) return await callGrok(modelId, systemPrompt, userPrompt, maxTokens);
    if (modelId.startsWith("gemini")) return await callGemini(modelId, systemPrompt, userPrompt, maxTokens);
    return await callGpt(modelId, systemPrompt, userPrompt, maxTokens);
  } finally {
    clearTimeout(timer);
  }
}

// --- Calculate cost ---
function calculateCost(modelId: string, tokens: { input: number; output: number }): number {
  const rates = COST_PER_1K[modelId] || COST_PER_1K["gpt-5-mini"];
  return (tokens.input / 1000) * rates.input + (tokens.output / 1000) * rates.output;
}

// --- Cache key ---
function buildCacheKey(request: AIRequest): string {
  const parts = [
    request.requestType,
    request.mode || "none",
    request.parameters.language,
    request.parameters.tone,
    request.parameters.length,
    request.context.zodiacSign || "none",
    request.context.emotionalState || "neutral",
  ];
  return `ai:cache:${parts.join(":")}`;
}

// --- Main router entry point ---
export async function routeAIRequest(request: AIRequest): Promise<AIResponse> {
  const startTime = Date.now();
  const responseId = uuidv4();

  // 1. Check cache
  const cacheKey = buildCacheKey(request);
  const cached = await redis.get(cacheKey);
  if (cached) {
    const parsed = JSON.parse(cached);
    return {
      ...parsed,
      requestId: request.requestId,
      responseId,
      metadata: { ...parsed.metadata, cached: true, latencyMs: Date.now() - startTime },
    };
  }

  // 2. Classify & select model
  const classification = classifyRequest(request);
  const modelConfig = selectModel(classification);

  // 3. Build prompt
  const { systemPrompt, userPrompt } = buildPrompt(request, classification);

  // 4. Execute with failover
  let modelUsed = modelConfig.primary;
  let wasFallback = false;
  let fallbackReason: string | undefined;
  let result: { content: string; tokensUsed: { input: number; output: number } };

  try {
    result = await callProvider(modelConfig.primary, systemPrompt, userPrompt, modelConfig.maxOutputTokens, modelConfig.timeout);
  } catch (primaryErr: any) {
    functions.logger.warn("Primary model failed", { model: modelConfig.primary, error: primaryErr.message });
    wasFallback = true;
    fallbackReason = primaryErr.message?.includes("timeout") ? "timeout" : "server_error";

    if (modelConfig.fallback) {
      try {
        modelUsed = modelConfig.fallback;
        result = await callProvider(modelConfig.fallback, systemPrompt, userPrompt, modelConfig.maxOutputTokens, Math.round(modelConfig.timeout * 1.5));
      } catch (fallbackErr: any) {
        functions.logger.warn("Fallback model failed", { model: modelConfig.fallback, error: fallbackErr.message });

        if (modelConfig.tertiary) {
          modelUsed = modelConfig.tertiary;
          result = await callProvider(modelConfig.tertiary, systemPrompt, userPrompt, modelConfig.maxOutputTokens, modelConfig.timeout * 2);
        } else {
          throw fallbackErr;
        }
      }
    } else {
      throw primaryErr;
    }
  }

  const costUsd = calculateCost(modelUsed, result.tokensUsed);
  const latencyMs = Date.now() - startTime;

  // 5. Build response
  const aiResponse: AIResponse = {
    requestId: request.requestId,
    responseId,
    content: result.content,
    metadata: {
      modelUsed,
      language: request.parameters.language,
      tokensUsed: result.tokensUsed,
      costUsd,
      latencyMs,
      cached: false,
      wasFallback,
      fallbackReason,
      emotionalDepthScore: classification.emotionalDepth,
    },
  };

  // 6. Cache response (skip SOS -- never cached)
  if (request.requestType !== "sos_coaching" && request.requestType !== "sos_assessment") {
    await redis.setex(cacheKey, CONFIG.CACHE_TTL_DEFAULT, JSON.stringify(aiResponse));
  }

  // 7. Log cost asynchronously
  logCost(request.userId, modelUsed, costUsd, result.tokensUsed).catch(() => {});

  return aiResponse;
}

async function logCost(
  userId: string,
  model: string,
  costUsd: number,
  tokens: { input: number; output: number }
): Promise<void> {
  await db.collection("ai_cost_logs").add({
    userId,
    model,
    costUsd,
    tokensInput: tokens.input,
    tokensOutput: tokens.output,
    timestamp: new Date().toISOString(),
  });
}

// --- Streaming variant for SOS ---
export async function* streamAIResponse(
  request: AIRequest
): AsyncGenerator<{ event: string; data: string }> {
  const classification = classifyRequest(request);
  const modelConfig = selectModel(classification);
  const { systemPrompt, userPrompt } = buildPrompt(request, classification);

  yield { event: "coaching_start", data: JSON.stringify({ sessionId: request.requestId, stepNumber: 1 }) };

  try {
    const result = await callProvider(modelConfig.primary, systemPrompt, userPrompt, modelConfig.maxOutputTokens, modelConfig.timeout);

    const sections = parseCoachingResponse(result.content);
    for (const section of sections) {
      yield { event: section.event, data: JSON.stringify(section.data) };
    }

    yield { event: "coaching_complete", data: JSON.stringify({ isLastStep: false, nextStepPrompt: "What did she say?" }) };
  } catch {
    yield { event: "error", data: JSON.stringify({ message: "AI service temporarily unavailable" }) };
  }
}

function parseCoachingResponse(content: string): { event: string; data: any }[] {
  const sections: { event: string; data: any }[] = [];
  sections.push({ event: "say_this", data: { text: content } });
  sections.push({ event: "body_language", data: { text: "Face her directly, maintain gentle eye contact" } });
  return sections;
}
```

---

## 8. AI Provider Integrations

### ai/providers/claude.ts

```typescript
// functions/src/ai/providers/claude.ts
import Anthropic from "@anthropic-ai/sdk";

const client = new Anthropic({ apiKey: process.env.ANTHROPIC_API_KEY });

const MODEL_MAP: Record<string, string> = {
  "claude-sonnet-4.5": "claude-sonnet-4-5-20250514",
  "claude-haiku-4.5": "claude-haiku-4-5-20250514",
};

export async function callClaude(
  modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const response = await client.messages.create({
    model: MODEL_MAP[modelId] || MODEL_MAP["claude-haiku-4.5"],
    max_tokens: maxTokens,
    system: systemPrompt,
    messages: [{ role: "user", content: userPrompt }],
  });

  const textBlock = response.content.find((b) => b.type === "text");
  return {
    content: textBlock?.text || "",
    tokensUsed: {
      input: response.usage.input_tokens,
      output: response.usage.output_tokens,
    },
  };
}
```

### ai/providers/grok.ts

```typescript
// functions/src/ai/providers/grok.ts
// Grok uses OpenAI-compatible API via xAI

const GROK_BASE_URL = "https://api.x.ai/v1";

export async function callGrok(
  _modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const response = await fetch(`${GROK_BASE_URL}/chat/completions`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${process.env.XAI_API_KEY}`,
    },
    body: JSON.stringify({
      model: "grok-4.1-fast",
      messages: [
        { role: "system", content: systemPrompt },
        { role: "user", content: userPrompt },
      ],
      max_tokens: maxTokens,
      temperature: 0.7,
    }),
  });

  if (!response.ok) throw new Error(`Grok API error: ${response.status}`);
  const data = await response.json();

  return {
    content: data.choices[0]?.message?.content || "",
    tokensUsed: {
      input: data.usage?.prompt_tokens || 0,
      output: data.usage?.completion_tokens || 0,
    },
  };
}
```

### ai/providers/gemini.ts

```typescript
// functions/src/ai/providers/gemini.ts
import { GoogleGenerativeAI } from "@google/generative-ai";

const genAI = new GoogleGenerativeAI(process.env.GOOGLE_AI_API_KEY || "");

export async function callGemini(
  _modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const model = genAI.getGenerativeModel({
    model: "gemini-2.0-flash",
    systemInstruction: systemPrompt,
    generationConfig: { maxOutputTokens: maxTokens, temperature: 0.7 },
  });

  const result = await model.generateContent(userPrompt);
  const response = result.response;
  const usage = response.usageMetadata;

  return {
    content: response.text() || "",
    tokensUsed: {
      input: usage?.promptTokenCount || 0,
      output: usage?.candidatesTokenCount || 0,
    },
  };
}
```

### ai/providers/gpt.ts

```typescript
// functions/src/ai/providers/gpt.ts
import OpenAI from "openai";

const openai = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });

export async function callGpt(
  _modelId: string,
  systemPrompt: string,
  userPrompt: string,
  maxTokens: number
): Promise<{ content: string; tokensUsed: { input: number; output: number } }> {
  const response = await openai.chat.completions.create({
    model: "gpt-4o-mini",
    messages: [
      { role: "system", content: systemPrompt },
      { role: "user", content: userPrompt },
    ],
    max_tokens: maxTokens,
    temperature: 0.7,
  });

  return {
    content: response.choices[0]?.message?.content || "",
    tokensUsed: {
      input: response.usage?.prompt_tokens || 0,
      output: response.usage?.completion_tokens || 0,
    },
  };
}
```

---

## 9. Prompt Builder

### ai/promptBuilder.ts

```typescript
// functions/src/ai/promptBuilder.ts
import { AIRequest, AIClassification, SupportedLocale } from "../types";

const LANGUAGE_INSTRUCTIONS: Record<SupportedLocale, string> = {
  en: "Write in English. Use natural, conversational American English.",
  ar: "Write in Arabic. Use Modern Standard Arabic unless a dialect is specified. Right-to-left text.",
  ms: "Write in Bahasa Malaysia. Use standard Malaysian Malay with natural tone.",
};

const TONE_INSTRUCTIONS: Record<string, string> = {
  warm: "Use a warm, caring tone that feels genuine.",
  playful: "Keep it light and playful with subtle humor.",
  serious: "Be sincere and straightforward. No jokes.",
  romantic: "Be deeply romantic without being cheesy or over-the-top.",
  gentle: "Use a soft, gentle tone. She may be fragile right now.",
  confident: "Be confident and assured. Show strength with sensitivity.",
};

const LENGTH_INSTRUCTIONS: Record<string, string> = {
  short: "Keep it to 1-3 sentences. Punchy and impactful.",
  medium: "4-6 sentences. Well-developed but not rambling.",
  long: "A full paragraph or two. Take your time to express depth.",
};

export function buildPrompt(
  request: AIRequest,
  classification: AIClassification
): { systemPrompt: string; userPrompt: string } {
  const ctx = request.context;
  const params = request.parameters;

  const systemPrompt = `You are a relationship communication assistant helping a man communicate with his female partner. Your identity is never revealed.

CORE RULES:
1. ${LANGUAGE_INSTRUCTIONS[params.language]}
2. The message must sound like it came from HIM, not an AI.
3. Be specific. Reference her actual traits from the context.
4. Never use cliches: "you complete me," "you're my everything."
5. ${LENGTH_INSTRUCTIONS[params.length]}
6. ${TONE_INSTRUCTIONS[params.tone]}
7. Never mention AI, apps, or that this was generated.
8. Her love language is ${ctx.loveLanguage || "unknown"}. Weight accordingly.
9. Cultural context: ${ctx.culturalBackground || "general"}. Religious observance: ${ctx.religiousObservance || "moderate"}.
10. Emotional depth required: ${classification.emotionalDepth}/5.

PARTNER CONTEXT:
- Name: ${ctx.partnerName}
- Zodiac: ${ctx.zodiacSign || "unknown"}
- Relationship: ${ctx.relationshipStatus}, ${ctx.relationshipDurationMonths || "unknown"} months
- Communication style: ${ctx.communicationStyle || "mixed"}
- Current emotional state: ${ctx.emotionalState || "neutral"}
- Cycle phase: ${ctx.cyclePhase || "unknown"}
${ctx.isPregnant ? `- Pregnant, trimester ${ctx.trimester}` : ""}
${ctx.recentMemories?.length ? `- Recent memories: ${ctx.recentMemories.join("; ")}` : ""}`;

  let userPrompt: string;

  switch (request.requestType) {
    case "message":
      userPrompt = buildMessagePrompt(request);
      break;
    case "sos_coaching":
    case "sos_assessment":
      userPrompt = buildSOSPrompt(request);
      break;
    case "gift":
      userPrompt = buildGiftPrompt(request);
      break;
    case "action_card":
      userPrompt = buildActionCardPrompt(request);
      break;
    default:
      userPrompt = `Generate helpful relationship content for: ${request.requestType}`;
  }

  return { systemPrompt, userPrompt };
}

function buildMessagePrompt(request: AIRequest): string {
  const mode = request.mode || "checking_in";
  const ctx = request.context;

  const modePrompts: Record<string, string> = {
    good_morning: `Write a good morning message to ${ctx.partnerName}. Make it feel personal.`,
    checking_in: `Write a checking-in message to ${ctx.partnerName} showing you are thinking of her.`,
    appreciation: `Write an appreciation message to ${ctx.partnerName}. Be specific about what you value.`,
    motivation: `Write a motivational message to ${ctx.partnerName}. Acknowledge her struggles then uplift.`,
    celebration: `Write a celebration message to ${ctx.partnerName}. Be enthusiastic and genuine.`,
    flirting: `Write a flirty message to ${ctx.partnerName}. Playful but respectful.`,
    reassurance: `Write a reassurance message to ${ctx.partnerName}. She needs to feel safe and valued.`,
    long_distance: `Write a long-distance message to ${ctx.partnerName}. Bridge the gap emotionally.`,
    apology: `Write a sincere apology to ${ctx.partnerName}. Own responsibility. No "but" statements.`,
    after_argument: `Write a post-argument message to ${ctx.partnerName}. Validate her feelings first.`,
  };

  let prompt = modePrompts[mode] || modePrompts.checking_in;
  if (ctx.emotionalState && ctx.emotionalState !== "neutral") {
    prompt += ` She is currently feeling ${ctx.emotionalState}.`;
  }
  return prompt;
}

function buildSOSPrompt(request: AIRequest): string {
  const ctx = request.context;
  return `URGENT SOS: Scenario is "${ctx.sosScenario}". Provide immediate tactical advice.
Give: (1) exactly what to say now, (2) what NOT to say, (3) body language tip, (4) tone advice.
Keep it actionable and concise. He needs help RIGHT NOW.
${ctx.conversationHistory?.length ? `Recent exchange: ${JSON.stringify(ctx.conversationHistory.slice(-3))}` : ""}`;
}

function buildGiftPrompt(request: AIRequest): string {
  const ctx = request.context;
  return `Recommend 3-5 thoughtful gift ideas for ${ctx.partnerName}.
Zodiac: ${ctx.zodiacSign}. Love language: ${ctx.loveLanguage}.
Consider her personality and cultural background (${ctx.culturalBackground}).
Format as JSON array with: name, description, priceRange, whyShellLoveIt.`;
}

function buildActionCardPrompt(request: AIRequest): string {
  const ctx = request.context;
  return `Generate 3 personalized daily action cards for a man to strengthen his relationship with ${ctx.partnerName}.
Each card: { category: "say"|"do"|"buy"|"go", title, description, estimatedMinutes, xpReward }.
Consider: zodiac ${ctx.zodiacSign}, love language ${ctx.loveLanguage}, emotional state ${ctx.emotionalState}.`;
}
```

---

## 10. SOS Coaching with SSE

### api/sos.ts

```typescript
// functions/src/api/sos.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis, CONFIG } from "../config";
import { AuthenticatedRequest, AppError, AIRequest } from "../types";
import { sosActivateSchema, sosAssessSchema, sosCoachSchema, sosResolveSchema } from "../validators/schemas";
import { routeAIRequest, streamAIResponse } from "../ai/router";
import { awardXp } from "../services/gamificationService";

const router = Router();

// --- Tier limits ---
const SOS_LIMITS: Record<string, number> = { free: 2, pro: 10, legend: Infinity };

// POST /sos/activate
router.post("/activate", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = sosActivateSchema.parse(req.body);

    // Check tier limits
    const month = new Date().toISOString().slice(0, 7);
    const countSnap = await db.collection("sos_sessions")
      .where("userId", "==", req.user.uid)
      .where("monthKey", "==", month)
      .count().get();

    const used = countSnap.data().count;
    const limit = SOS_LIMITS[req.user.tier];
    if (used >= limit) {
      throw new AppError(403, "TIER_LIMIT_EXCEEDED", `Monthly SOS limit reached (${limit})`);
    }

    const sessionId = uuidv4();

    // Get immediate advice from AI
    const aiRequest: AIRequest = {
      requestId: sessionId,
      userId: req.user.uid,
      tier: req.user.tier,
      requestType: "sos_assessment",
      parameters: { tone: "gentle", length: "short", language: req.user.language },
      context: {
        partnerName: "her",
        relationshipStatus: "married",
        sosScenario: body.scenario,
        emotionalState: "anxious",
      },
      timestamp: new Date().toISOString(),
    };

    // Load partner profile if provided
    if (body.profileId) {
      const profileDoc = await db.collection("profiles").doc(body.profileId).get();
      if (profileDoc.exists) {
        const p = profileDoc.data()!;
        aiRequest.context.partnerName = p.name;
        aiRequest.context.relationshipStatus = p.relationshipStatus;
        aiRequest.context.zodiacSign = p.zodiacSign;
        aiRequest.context.loveLanguage = p.loveLanguage;
      }
    }

    const aiResponse = await routeAIRequest(aiRequest);

    // Store session
    await db.collection("sos_sessions").doc(sessionId).set({
      userId: req.user.uid,
      sessionId,
      scenario: body.scenario,
      urgency: body.urgency,
      briefContext: body.briefContext || null,
      profileId: body.profileId || null,
      status: "active",
      stepsCompleted: 0,
      monthKey: month,
      createdAt: new Date().toISOString(),
    });

    // Cache session for fast lookup (60 min expiry)
    await redis.setex(`sos:session:${sessionId}`, CONFIG.SOS_SESSION_EXPIRY_MIN * 60, JSON.stringify({
      userId: req.user.uid,
      scenario: body.scenario,
      urgency: body.urgency,
      status: "active",
    }));

    res.json({
      data: {
        sessionId,
        scenario: body.scenario,
        urgency: body.urgency,
        immediateAdvice: {
          doNow: aiResponse.content,
          doNotDo: "Do not raise your voice or get defensive",
          bodyLanguage: "Face her, open posture, gentle eye contact",
        },
        severityAssessmentRequired: true,
        estimatedResolutionSteps: 4,
        createdAt: new Date().toISOString(),
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Missing scenario or urgency"));
    next(err);
  }
});

// POST /sos/assess
router.post("/assess", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = sosAssessSchema.parse(req.body);

    // Verify session
    const sessionDoc = await db.collection("sos_sessions").doc(body.sessionId).get();
    if (!sessionDoc.exists || sessionDoc.data()!.userId !== req.user.uid) {
      throw new AppError(404, "SESSION_NOT_FOUND", "SOS session not found or expired");
    }

    // Calculate severity
    const answers = body.answers;
    let severity = 2;
    if (answers.herCurrentState === "furious" || answers.herCurrentState === "crying") severity += 2;
    else if (answers.herCurrentState === "very_upset") severity += 1;
    if (answers.yourFault === "yes") severity += 1;
    if (!answers.isSheTalking) severity += 1;
    if (answers.howLongAgo === "minutes") severity += 1;
    severity = Math.max(1, Math.min(5, severity));

    const severityLabels = ["", "mild", "moderate", "serious", "severe", "critical"];
    const totalSteps = severity <= 2 ? 3 : severity <= 4 ? 5 : 7;

    await db.collection("sos_sessions").doc(body.sessionId).update({
      severityScore: severity,
      assessmentAnswers: answers,
      totalSteps,
      assessedAt: new Date().toISOString(),
    });

    res.json({
      data: {
        sessionId: body.sessionId,
        severityScore: severity,
        severityLabel: severityLabels[severity],
        coachingPlan: {
          totalSteps,
          estimatedMinutes: totalSteps * 3,
          approach: severity >= 4 ? "empathetic_listening_first" : "gentle_reconnection",
          keyInsight: "She needs to feel heard before any explanation.",
        },
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Missing required answers"));
    next(err);
  }
});

// POST /sos/coach (supports SSE streaming)
router.post("/coach", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = sosCoachSchema.parse(req.body);

    // Verify session
    const sessionDoc = await db.collection("sos_sessions").doc(body.sessionId).get();
    if (!sessionDoc.exists || sessionDoc.data()!.userId !== req.user.uid) {
      throw new AppError(404, "SESSION_NOT_FOUND", "Session not found or expired");
    }
    const session = sessionDoc.data()!;

    // Build AI request
    const aiRequest: AIRequest = {
      requestId: body.sessionId,
      userId: req.user.uid,
      tier: req.user.tier,
      requestType: "sos_coaching",
      parameters: { tone: "gentle", length: "medium", language: req.user.language },
      context: {
        partnerName: "her",
        relationshipStatus: "married",
        sosScenario: session.scenario,
        emotionalState: "anxious",
        conversationHistory: [],
      },
      timestamp: new Date().toISOString(),
    };

    if (body.userUpdate) {
      aiRequest.context.conversationHistory!.push({ role: "user", text: body.userUpdate });
    }
    if (body.herResponse) {
      aiRequest.context.conversationHistory!.push({ role: "partner", text: body.herResponse });
    }

    // SSE streaming mode
    if (body.stream) {
      res.writeHead(200, {
        "Content-Type": "text/event-stream",
        "Cache-Control": "no-cache",
        "Connection": "keep-alive",
        "X-Accel-Buffering": "no",
      });

      const generator = streamAIResponse(aiRequest);
      for await (const chunk of generator) {
        res.write(`event: ${chunk.event}\ndata: ${chunk.data}\n\n`);
      }
      res.end();
      return;
    }

    // Standard JSON mode
    const aiResponse = await routeAIRequest(aiRequest);
    const totalSteps = session.totalSteps || 5;
    const isLastStep = body.stepNumber >= totalSteps;

    await db.collection("sos_sessions").doc(body.sessionId).update({
      stepsCompleted: body.stepNumber,
      lastStepAt: new Date().toISOString(),
    });

    res.json({
      data: {
        sessionId: body.sessionId,
        stepNumber: body.stepNumber,
        totalSteps,
        coaching: {
          sayThis: aiResponse.content,
          whyItWorks: "Validating her emotions first reduces defensiveness.",
          doNotSay: ["But I didn't mean to...", "You're overreacting"],
          bodyLanguageTip: "Face her directly, open posture",
          toneAdvice: "gentle",
          waitFor: "Her to finish speaking before you respond",
        },
        isLastStep,
        nextStepPrompt: isLastStep ? null : "What did she say or do after that?",
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Missing sessionId or stepNumber"));
    next(err);
  }
});

// POST /sos/resolve
router.post("/resolve", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = sosResolveSchema.parse(req.body);

    const sessionDoc = await db.collection("sos_sessions").doc(body.sessionId).get();
    if (!sessionDoc.exists || sessionDoc.data()!.userId !== req.user.uid) {
      throw new AppError(404, "SESSION_NOT_FOUND", "Session not found");
    }
    if (sessionDoc.data()!.status === "resolved") {
      throw new AppError(409, "SESSION_ALREADY_RESOLVED", "Session already closed");
    }

    await db.collection("sos_sessions").doc(body.sessionId).update({
      status: "resolved",
      outcome: body.outcome,
      whatWorked: body.whatWorked || null,
      whatDidntWork: body.whatDidntWork || null,
      wouldUseAgain: body.wouldUseAgain ?? null,
      rating: body.rating ?? null,
      resolvedAt: new Date().toISOString(),
    });

    await redis.del(`sos:session:${body.sessionId}`);

    // Award XP
    const xpResult = await awardXp(req.user.uid, "sos_resolved", 30);

    // Schedule follow-up reminder
    const tomorrow = new Date(Date.now() + 24 * 60 * 60 * 1000);
    await db.collection("reminders").add({
      userId: req.user.uid,
      title: "Check in with her",
      description: "Follow up from yesterday's situation to show you care",
      type: "custom",
      date: tomorrow.toISOString().split("T")[0],
      status: "active",
      isAutoGenerated: true,
      createdAt: new Date().toISOString(),
    });

    res.json({
      data: {
        sessionId: body.sessionId,
        status: "resolved",
        outcome: body.outcome,
        xpAwarded: xpResult.xpAwarded,
        followUpReminder: {
          enabled: true,
          scheduledFor: tomorrow.toISOString(),
          message: "Check in with her tomorrow to show you care",
        },
        resolvedAt: new Date().toISOString(),
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Invalid outcome"));
    next(err);
  }
});

export default router;
```

---

## 11. Gamification Service

### services/gamificationService.ts

```typescript
// functions/src/services/gamificationService.ts
import { db, redis } from "../config";
import { ActionType } from "../types";

const XP_TABLE: Record<string, number> = {
  action_card_complete: 15,
  reminder_complete: 15,
  message_generated: 10,
  message_feedback: 5,
  gift_feedback: 10,
  sos_resolved: 30,
  memory_added: 10,
  profile_updated: 5,
  daily_login: 5,
  streak_milestone: 50,
};

const LEVEL_THRESHOLDS = [
  { level: 1, xp: 0, name: "Newbie" },
  { level: 2, xp: 100, name: "Getting Started" },
  { level: 3, xp: 300, name: "Attentive" },
  { level: 4, xp: 600, name: "Thoughtful" },
  { level: 5, xp: 1000, name: "Caring Partner" },
  { level: 6, xp: 1500, name: "Dedicated" },
  { level: 7, xp: 2000, name: "Devoted Partner" },
  { level: 8, xp: 3000, name: "Relationship Champion" },
  { level: 9, xp: 4500, name: "Love Expert" },
  { level: 10, xp: 6000, name: "Legend" },
];

const BADGE_DEFINITIONS = [
  { id: "streak_7", name: "Week Warrior", category: "streak", condition: (s: any) => s.currentStreak >= 7 },
  { id: "streak_14", name: "Two-Week Warrior", category: "streak", condition: (s: any) => s.currentStreak >= 14 },
  { id: "streak_30", name: "Monthly Master", category: "streak", condition: (s: any) => s.currentStreak >= 30 },
  { id: "streak_60", name: "Unbreakable", category: "streak", condition: (s: any) => s.currentStreak >= 60 },
  { id: "streak_100", name: "Century of Love", category: "streak", condition: (s: any) => s.currentStreak >= 100 },
  { id: "msgs_10", name: "Communicator", category: "messages", condition: (s: any) => s.messagesGenerated >= 10 },
  { id: "msgs_50", name: "Smooth Talker", category: "messages", condition: (s: any) => s.messagesGenerated >= 50 },
  { id: "cards_25", name: "Action Hero", category: "actions", condition: (s: any) => s.actionCardsCompleted >= 25 },
  { id: "sos_5", name: "Crisis Navigator", category: "sos", condition: (s: any) => s.sosResolved >= 5 },
  { id: "level_5", name: "Caring Partner", category: "milestone", condition: (s: any) => s.level >= 5 },
  { id: "level_10", name: "Legend Status", category: "milestone", condition: (s: any) => s.level >= 10 },
];

function getLevelForXp(totalXp: number): { level: number; name: string; xpForNextLevel: number } {
  let current = LEVEL_THRESHOLDS[0];
  for (const t of LEVEL_THRESHOLDS) {
    if (totalXp >= t.xp) current = t;
    else break;
  }
  const nextIdx = LEVEL_THRESHOLDS.findIndex((t) => t.level === current.level + 1);
  const xpForNext = nextIdx >= 0 ? LEVEL_THRESHOLDS[nextIdx].xp : current.xp + 2000;
  return { level: current.level, name: current.name, xpForNextLevel: xpForNext };
}

export async function awardXp(
  userId: string,
  actionType: ActionType | string,
  overrideXp?: number
): Promise<{
  xpAwarded: number;
  newTotalXp: number;
  levelUp: boolean;
  newLevel: { level: number; name: string } | null;
  badgeEarned: { id: string; name: string } | null;
  streakUpdate: { currentDays: number; isNewRecord: boolean };
}> {
  const gamRef = db.collection("gamification").doc(userId);
  const gamDoc = await gamRef.get();

  if (!gamDoc.exists) {
    await gamRef.set({
      userId, totalXp: 0, level: 1, levelName: "Newbie",
      currentStreak: 0, longestStreak: 0, lastActiveDate: null,
      freezesAvailable: 1, freezesUsedThisMonth: 0, badges: [],
      messagesGenerated: 0, actionCardsCompleted: 0, sosResolved: 0,
      createdAt: new Date().toISOString(),
    });
  }

  const data = (await gamRef.get()).data()!;
  const baseXp = overrideXp || XP_TABLE[actionType] || 5;

  // Streak bonus
  const streakBonus = data.currentStreak >= 7 ? Math.min(Math.floor(data.currentStreak / 7) * 5, 25) : 0;
  const totalAwarded = baseXp + streakBonus;
  const newTotalXp = (data.totalXp || 0) + totalAwarded;
  const oldLevel = data.level || 1;
  const levelInfo = getLevelForXp(newTotalXp);
  const levelUp = levelInfo.level > oldLevel;

  // Update streak
  const today = new Date().toISOString().split("T")[0];
  const lastActive = data.lastActiveDate;
  let currentStreak = data.currentStreak || 0;
  let longestStreak = data.longestStreak || 0;

  if (lastActive !== today) {
    const yesterday = new Date(Date.now() - 86400000).toISOString().split("T")[0];
    if (lastActive === yesterday) {
      currentStreak += 1;
    } else if (lastActive) {
      currentStreak = 1;
    } else {
      currentStreak = 1;
    }
  }
  const isNewRecord = currentStreak > longestStreak;
  if (isNewRecord) longestStreak = currentStreak;

  // Increment action counters
  const counterField = actionType === "message_generated" ? "messagesGenerated"
    : actionType === "action_card_complete" ? "actionCardsCompleted"
    : actionType === "sos_resolved" ? "sosResolved"
    : null;

  const updates: Record<string, any> = {
    totalXp: newTotalXp,
    level: levelInfo.level,
    levelName: levelInfo.name,
    currentStreak,
    longestStreak,
    lastActiveDate: today,
    updatedAt: new Date().toISOString(),
  };
  if (counterField) updates[counterField] = (data[counterField] || 0) + 1;

  // Check badges
  let badgeEarned: { id: string; name: string } | null = null;
  const checkState = { ...data, ...updates, level: levelInfo.level };
  for (const badge of BADGE_DEFINITIONS) {
    if (!data.badges?.includes(badge.id) && badge.condition(checkState)) {
      badgeEarned = { id: badge.id, name: badge.name };
      updates.badges = [...(data.badges || []), badge.id];
      break;
    }
  }

  await gamRef.update(updates);
  await redis.del(`gamification:profile:${userId}`);
  await redis.del(`gamification:badges:${userId}`);

  // Log action
  await db.collection("xp_log").add({
    userId, actionType, xpAwarded: totalAwarded, baseXp, streakBonus,
    newTotalXp, levelUp, badgeEarned: badgeEarned?.id || null,
    timestamp: new Date().toISOString(),
  });

  return {
    xpAwarded: totalAwarded,
    newTotalXp,
    levelUp,
    newLevel: levelUp ? { level: levelInfo.level, name: levelInfo.name } : null,
    badgeEarned,
    streakUpdate: { currentDays: currentStreak, isNewRecord },
  };
}
```

---

## 12. Notification Service

### services/notificationService.ts

```typescript
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
```

---

## 13. Encryption Service

### services/encryptionService.ts

```typescript
// functions/src/services/encryptionService.ts
import crypto from "crypto";

const ALGORITHM = "aes-256-gcm";
const KEY = Buffer.from(process.env.VAULT_ENCRYPTION_KEY || crypto.randomBytes(32).toString("hex"), "hex");
const IV_LENGTH = 12;
const TAG_LENGTH = 16;

export function encrypt(plaintext: string): string {
  const iv = crypto.randomBytes(IV_LENGTH);
  const cipher = crypto.createCipheriv(ALGORITHM, KEY, iv);
  let encrypted = cipher.update(plaintext, "utf8", "hex");
  encrypted += cipher.final("hex");
  const tag = cipher.getAuthTag();
  return iv.toString("hex") + ":" + tag.toString("hex") + ":" + encrypted;
}

export function decrypt(ciphertext: string): string {
  const parts = ciphertext.split(":");
  if (parts.length !== 3) throw new Error("Invalid ciphertext format");
  const iv = Buffer.from(parts[0], "hex");
  const tag = Buffer.from(parts[1], "hex");
  const encrypted = parts[2];
  const decipher = crypto.createDecipheriv(ALGORITHM, KEY, iv);
  decipher.setAuthTag(tag);
  let decrypted = decipher.update(encrypted, "hex", "utf8");
  decrypted += decipher.final("utf8");
  return decrypted;
}
```

---

## 14. Scheduled Functions

### scheduled/reminderCheck.ts

```typescript
// functions/src/scheduled/reminderCheck.ts
import * as functions from "firebase-functions/v2";
import { db } from "../config";
import { sendTemplatedNotification } from "../services/notificationService";
import { SupportedLocale } from "../types";

export const reminderCheck = functions.scheduler.onSchedule(
  { schedule: "every 15 minutes", timeoutSeconds: 120, memory: "512MiB" },
  async () => {
    const now = new Date();
    const todayStr = now.toISOString().split("T")[0];

    // Query active reminders
    const remindersSnap = await db.collection("reminders")
      .where("status", "==", "active")
      .get();

    for (const doc of remindersSnap.docs) {
      const reminder = doc.data();
      const eventDate = new Date(reminder.date);
      const daysUntil = Math.ceil((eventDate.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
      const tiers: number[] = reminder.reminderTiers || [7, 3, 1, 0];

      // Check if snoozed
      if (reminder.snoozedUntil && new Date(reminder.snoozedUntil) > now) continue;

      // Determine which tier to fire
      let templateKey: string | null = null;
      if (daysUntil === 0 && tiers.includes(0)) templateKey = "reminder_day_of";
      else if (daysUntil === 1 && tiers.includes(1)) templateKey = "reminder_1d";
      else if (daysUntil === 3 && tiers.includes(3)) templateKey = "reminder_3d";
      else if (daysUntil === 7 && tiers.includes(7)) templateKey = "reminder_7d";

      if (!templateKey) continue;

      // Dedup: check if already sent today
      const sentKey = `reminder_sent:${doc.id}:${templateKey}:${todayStr}`;
      const sentDoc = await db.collection("reminder_sent_log").doc(sentKey).get();
      if (sentDoc.exists) continue;

      // Get user language
      const userDoc = await db.collection("users").doc(reminder.userId).get();
      const locale: SupportedLocale = userDoc.data()?.language || "en";

      // Get partner name
      let partnerName = "her";
      if (reminder.linkedProfileId) {
        const profileDoc = await db.collection("profiles").doc(reminder.linkedProfileId).get();
        if (profileDoc.exists) partnerName = profileDoc.data()!.name;
      }

      await sendTemplatedNotification(
        reminder.userId,
        templateKey,
        { eventName: reminder.title, partnerName },
        locale,
        { reminderId: doc.id, type: "reminder" }
      );

      // Log to prevent re-sending
      await db.collection("reminder_sent_log").doc(sentKey).set({
        reminderId: doc.id,
        templateKey,
        sentAt: now.toISOString(),
      });
    }

    functions.logger.info("Reminder check complete", { processed: remindersSnap.size });
  }
);
```

### scheduled/dailyCards.ts

```typescript
// functions/src/scheduled/dailyCards.ts
import * as functions from "firebase-functions/v2";
import { db } from "../config";
import { routeAIRequest } from "../ai/router";
import { sendTemplatedNotification } from "../services/notificationService";
import { AIRequest, SupportedLocale } from "../types";
import { v4 as uuidv4 } from "uuid";

export const dailyCardsGeneration = functions.scheduler.onSchedule(
  { schedule: "0 * * * *", timeoutSeconds: 300, memory: "1GiB" },
  async () => {
    // Runs every hour, checks which users are at midnight in their timezone
    const now = new Date();
    const currentHourUTC = now.getUTCHours();

    // Map UTC hour to timezones at midnight
    const targetOffset = -currentHourUTC;
    const offsetStr = targetOffset >= 0 ? `+${targetOffset}` : `${targetOffset}`;

    // Find users in this timezone who haven't received cards today
    const todayStr = now.toISOString().split("T")[0];

    const usersSnap = await db.collection("settings")
      .where("timezoneOffset", "==", targetOffset)
      .get();

    for (const settingsDoc of usersSnap.docs) {
      const userId = settingsDoc.id;
      const settings = settingsDoc.data();

      // Check if already generated today
      const existingCards = await db.collection("action_cards")
        .where("userId", "==", userId)
        .where("date", "==", todayStr)
        .limit(1)
        .get();

      if (!existingCards.empty) continue;

      // Get user data
      const userDoc = await db.collection("users").doc(userId).get();
      if (!userDoc.exists) continue;
      const userData = userDoc.data()!;
      const locale: SupportedLocale = userData.language || "en";

      // Get partner profile
      const profileSnap = await db.collection("profiles")
        .where("userId", "==", userId)
        .limit(1)
        .get();

      let partnerName = "her";
      let partnerContext: any = {};
      if (!profileSnap.empty) {
        const profile = profileSnap.docs[0].data();
        partnerName = profile.name;
        partnerContext = {
          zodiacSign: profile.zodiacSign,
          loveLanguage: profile.loveLanguage,
          communicationStyle: profile.communicationStyle,
          relationshipStatus: profile.relationshipStatus,
        };
      }

      // Determine card count by tier
      const tierLimits: Record<string, number> = { free: 3, pro: 10, legend: 10 };
      const cardCount = Math.min(tierLimits[userData.tier] || 3, 5);

      const aiRequest: AIRequest = {
        requestId: uuidv4(),
        userId,
        tier: userData.tier,
        requestType: "action_card",
        parameters: { tone: "warm", length: "short", language: locale },
        context: {
          partnerName,
          relationshipStatus: partnerContext.relationshipStatus || "dating",
          zodiacSign: partnerContext.zodiacSign,
          loveLanguage: partnerContext.loveLanguage,
          communicationStyle: partnerContext.communicationStyle,
        },
        timestamp: now.toISOString(),
      };

      try {
        const aiResponse = await routeAIRequest(aiRequest);
        let cards;
        try {
          cards = JSON.parse(aiResponse.content);
        } catch {
          cards = [
            { category: "say", title: "Send a good morning text", description: `Tell ${partnerName} one thing you admire about her.`, estimatedMinutes: 2, xpReward: 15 },
            { category: "do", title: "Small act of service", description: "Do one chore she usually handles without being asked.", estimatedMinutes: 15, xpReward: 20 },
            { category: "go", title: "Plan a mini-date", description: "Suggest a short walk or coffee together this evening.", estimatedMinutes: 5, xpReward: 15 },
          ];
        }

        const batch = db.batch();
        const cardArray = Array.isArray(cards) ? cards.slice(0, cardCount) : [cards];
        for (const card of cardArray) {
          const cardRef = db.collection("action_cards").doc();
          batch.set(cardRef, {
            userId,
            date: todayStr,
            category: card.category || "do",
            title: card.title,
            description: card.description,
            estimatedMinutes: card.estimatedMinutes || 10,
            xpReward: card.xpReward || 15,
            status: "pending",
            createdAt: now.toISOString(),
          });
        }
        await batch.commit();

        // Send notification
        await sendTemplatedNotification(
          userId,
          "daily_action_cards",
          { partnerName },
          locale,
          { type: "action_card" }
        );
      } catch (err) {
        functions.logger.error("Failed to generate cards for user", { userId, error: err });
      }
    }

    functions.logger.info("Daily cards generation complete for offset", { offsetStr });
  }
);
```

### scheduled/streakUpdate.ts

```typescript
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
```

---

## 15. Function Exports

### index.ts

```typescript
// functions/src/index.ts
import * as functions from "firebase-functions/v2";
import app from "./app";

// --- HTTP API ---
export const api = functions.https.onRequest(
  { cors: true, memory: "512MiB", timeoutSeconds: 60, region: "us-central1" },
  app
);

// --- Scheduled Functions ---
export { reminderCheck } from "./scheduled/reminderCheck";
export { dailyCardsGeneration } from "./scheduled/dailyCards";
export { streakUpdate } from "./scheduled/streakUpdate";
```

---

## Environment Variables (.env.example)

```env
FIREBASE_API_KEY=your_firebase_api_key
REDIS_URL=redis://your-redis-host:6379
ANTHROPIC_API_KEY=sk-ant-xxxxx
XAI_API_KEY=xai-xxxxx
GOOGLE_AI_API_KEY=AIzaxxxxx
OPENAI_API_KEY=sk-xxxxx
VAULT_ENCRYPTION_KEY=64_char_hex_string
```

---

*End of Backend Implementation (Part B) -- Raj Patel, Backend Developer*
