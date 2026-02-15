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
