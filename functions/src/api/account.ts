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
