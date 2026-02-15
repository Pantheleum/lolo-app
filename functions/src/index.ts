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
