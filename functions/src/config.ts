// functions/src/config.ts
import * as admin from "firebase-admin";
import Redis from "ioredis";

admin.initializeApp();

export const db = admin.firestore();
export const auth = admin.auth();
export const messaging = admin.messaging();

let _redis: Redis | null = null;

export function getRedis(): Redis {
  if (!_redis) {
    const redisUrl = process.env.REDIS_URL || "redis://localhost:6379";
    _redis = new Redis(redisUrl, {
      maxRetriesPerRequest: 3,
      retryStrategy: (times) => Math.min(times * 200, 2000),
      lazyConnect: true,
    });
  }
  return _redis;
}

// Keep backward-compatible export (lazy proxy)
export const redis = new Proxy({} as Redis, {
  get(_target, prop) {
    return (getRedis() as any)[prop];
  },
});

export const CONFIG = {
  AI_COST_BUDGET_DAILY_USD: 50,
  CACHE_TTL_DEFAULT: 300,
  CACHE_TTL_PROFILE: 600,
  CACHE_TTL_ZODIAC: 86400,
  SOS_SESSION_EXPIRY_MIN: 60,
  MAX_SOS_STEPS: 8,
} as const;
