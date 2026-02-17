// functions/src/config.ts
import * as admin from "firebase-admin";
import Redis from "ioredis";

admin.initializeApp();

export const db = admin.firestore();
export const auth = admin.auth();
export const messaging = admin.messaging();

// --- Redis: disabled when no real REDIS_URL is configured ---
const redisUrl = process.env.REDIS_URL || "";
const redisEnabled = redisUrl.length > 0 && !redisUrl.includes("localhost");

let _redis: Redis | null = null;

function getRedis(): Redis | null {
  if (!redisEnabled) return null;
  if (!_redis) {
    _redis = new Redis(redisUrl, {
      maxRetriesPerRequest: 3,
      retryStrategy: (times) => {
        if (times > 3) return null; // stop retrying
        return Math.min(times * 200, 2000);
      },
      lazyConnect: true,
    });
    // Prevent unhandled error events from crashing the process
    _redis.on("error", () => {});
  }
  return _redis;
}

// No-op Redis stub — all calls silently return null/0
const noopRedis = {
  get: async () => null,
  set: async () => "OK",
  setex: async () => "OK",
  del: async () => 0,
  incr: async () => 1,
  expire: async () => 1,
  ttl: async () => -1,
} as unknown as Redis;

// Proxy that uses real Redis when available, no-op otherwise
export const redis = new Proxy({} as Redis, {
  get(_target, prop) {
    const client = getRedis();
    if (!client) return (noopRedis as any)[prop];
    return (client as any)[prop];
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
