// functions/src/config.ts
import * as admin from "firebase-admin";

admin.initializeApp();

export const db = admin.firestore();
export const auth = admin.auth();
export const messaging = admin.messaging();

// --- Redis: completely disabled (no Redis server on Cloud Run) ---
// All redis calls silently no-op so callers don't need try/catch.
interface RedisStub {
  get(...args: any[]): Promise<string | null>;
  set(...args: any[]): Promise<string>;
  setex(...args: any[]): Promise<string>;
  del(...args: any[]): Promise<number>;
  incr(...args: any[]): Promise<number>;
  expire(...args: any[]): Promise<number>;
  ttl(...args: any[]): Promise<number>;
  keys(...args: any[]): Promise<string[]>;
  [key: string]: any;
}

export const redis: RedisStub = {
  get: async () => null,
  set: async () => "OK",
  setex: async () => "OK",
  del: async () => 0,
  incr: async () => 1,
  expire: async () => 1,
  ttl: async () => -1,
  keys: async () => [],
};

export const CONFIG = {
  AI_COST_BUDGET_DAILY_USD: 50,
  CACHE_TTL_DEFAULT: 300,
  CACHE_TTL_PROFILE: 600,
  CACHE_TTL_ZODIAC: 86400,
  SOS_SESSION_EXPIRY_MIN: 60,
  MAX_SOS_STEPS: 8,
} as const;
