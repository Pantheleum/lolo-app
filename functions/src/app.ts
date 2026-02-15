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
import subscriptionsRouter from "./api/subscriptions";
import revenuecatWebhook from "./webhooks/revenuecat";

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

// --- Webhook routes (own auth) ---
app.use("/api/v1/webhooks/revenuecat", revenuecatWebhook);

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
app.use("/api/v1/subscriptions", authMiddleware, rateLimitMiddleware, subscriptionsRouter);

// --- Error handling ---
app.use(notFoundHandler);
app.use(errorHandler);

export default app;
