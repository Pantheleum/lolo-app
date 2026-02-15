// functions/src/api/profiles.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import { db, redis, CONFIG } from "../config";
import { AuthenticatedRequest, AppError, ZodiacSign } from "../types";
import {
  createPartnerProfileSchema,
  updatePartnerProfileSchema,
  updatePreferencesSchema,
  updateCulturalContextSchema,
} from "../validators/schemas";

const router = Router();

// ============================================================
// Helper: calculate profile completion percentage
// ============================================================
function calculateCompletionPercent(profile: Record<string, any>): number {
  const fields: { key: string; weight: number }[] = [
    { key: "name", weight: 15 },
    { key: "birthday", weight: 10 },
    { key: "zodiacSign", weight: 10 },
    { key: "loveLanguage", weight: 10 },
    { key: "communicationStyle", weight: 10 },
    { key: "relationshipStatus", weight: 10 },
    { key: "anniversaryDate", weight: 5 },
    { key: "photoUrl", weight: 5 },
    { key: "preferences", weight: 15 },
    { key: "culturalContext", weight: 10 },
  ];

  let score = 0;
  for (const { key, weight } of fields) {
    const val = profile[key];
    if (val === null || val === undefined || val === "") continue;
    if (key === "preferences") {
      const prefs = val as Record<string, any>;
      const subKeys = ["favorites", "dislikes", "hobbies"];
      const filledSub = subKeys.filter((sk) => {
        const sv = prefs[sk];
        return sv && (Array.isArray(sv) ? sv.length > 0 : true);
      });
      score += Math.round((filledSub.length / subKeys.length) * weight);
    } else if (key === "culturalContext") {
      const ctx = val as Record<string, any>;
      const filledSub = ["background", "religiousObservance"].filter((sk) => ctx[sk]);
      score += Math.round((filledSub.length / 2) * weight);
    } else {
      score += weight;
    }
  }
  return Math.min(100, score);
}

// ============================================================
// Helper: load zodiac defaults from metadata collection
// ============================================================
async function loadZodiacDefaults(sign: ZodiacSign, locale: string): Promise<any | null> {
  const cacheKey = `zodiac:defaults:${sign}:${locale}`;
  const cached = await redis.get(cacheKey);
  if (cached) return JSON.parse(cached);

  const metaDoc = await db.collection("metadata").doc("zodiacProfiles").get();
  if (!metaDoc.exists) return null;

  const signData = metaDoc.data()!.signs?.[sign];
  if (!signData) return null;

  const defaults = {
    sign,
    element: signData.element,
    modality: signData.modality,
    personality: signData.loveTraits || [],
    communicationTips: signData.communicationTips || [],
    emotionalNeeds: signData.romanticNeeds || [],
    conflictStyle: signData.conflictStyle || "",
    giftPreferences: signData.giftPreferences || [],
    loveLanguageAffinity: signData.loveLanguageAffinity || null,
    bestApproachDuring: signData.bestApproachDuring || {},
  };

  await redis.setex(cacheKey, CONFIG.CACHE_TTL_ZODIAC, JSON.stringify(defaults));
  return defaults;
}

// POST /profiles -- create (limit: 1 per user for MVP)
router.post("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createPartnerProfileSchema.parse(req.body);

    const existingSnap = await db
      .collection("users").doc(req.user.uid)
      .collection("partnerProfiles")
      .where("deletedAt", "==", null).limit(1).get();

    if (!existingSnap.empty) {
      throw new AppError(409, "PROFILE_ALREADY_EXISTS", "User already has a partner profile");
    }

    const profileId = uuidv4();
    const profileData: Record<string, any> = {
      name: body.name, birthday: body.birthday || null,
      zodiacSign: body.zodiacSign || null, loveLanguage: body.loveLanguage || null,
      communicationStyle: body.communicationStyle || null,
      relationshipStatus: body.relationshipStatus,
      anniversaryDate: body.anniversaryDate || null, photoUrl: body.photoUrl || null,
      keyDates: [], preferences: { favorites: {}, dislikes: [], hobbies: [] },
      culturalContext: { background: null, religiousObservance: null, dialect: null },
      deletedAt: null,
      createdAt: new Date().toISOString(), updatedAt: new Date().toISOString(),
    };
    profileData.completionPercent = calculateCompletionPercent(profileData);

    await db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(profileId).set(profileData);

    res.status(201).json({
      data: {
        id: profileId, userId: req.user.uid, name: body.name,
        birthday: body.birthday || null, zodiacSign: body.zodiacSign || null,
        loveLanguage: body.loveLanguage || null,
        communicationStyle: body.communicationStyle || null,
        relationshipStatus: body.relationshipStatus,
        anniversaryDate: body.anniversaryDate || null, photoUrl: body.photoUrl || null,
        profileCompletionPercent: profileData.completionPercent,
        createdAt: profileData.createdAt, updatedAt: profileData.updatedAt,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed", { errors: err.errors }));
    next(err);
  }
});

// GET /profiles/:id -- get with zodiac defaults merged
router.get("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const cacheKey = `profile:${id}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json({ data: JSON.parse(cached) });

    const profileDoc = await db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id).get();

    if (!profileDoc.exists || profileDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Profile not found");
    }
    const profile = profileDoc.data()!;

    let zodiacTraits = null;
    if (profile.zodiacSign) {
      zodiacTraits = await loadZodiacDefaults(profile.zodiacSign, req.locale);
    }

    const data = {
      id, userId: req.user.uid, name: profile.name,
      birthday: profile.birthday || null, zodiacSign: profile.zodiacSign || null,
      zodiacTraits: zodiacTraits ? {
        personality: zodiacTraits.personality,
        communicationTips: zodiacTraits.communicationTips,
        emotionalNeeds: zodiacTraits.emotionalNeeds,
        conflictStyle: zodiacTraits.conflictStyle,
        giftPreferences: zodiacTraits.giftPreferences,
      } : null,
      loveLanguage: profile.loveLanguage || null,
      communicationStyle: profile.communicationStyle || null,
      relationshipStatus: profile.relationshipStatus,
      anniversaryDate: profile.anniversaryDate || null,
      photoUrl: profile.photoUrl || null,
      preferences: profile.preferences || {},
      culturalContext: profile.culturalContext || {},
      profileCompletionPercent: profile.completionPercent || 0,
      createdAt: profile.createdAt, updatedAt: profile.updatedAt,
    };

    await redis.setex(cacheKey, CONFIG.CACHE_TTL_PROFILE, JSON.stringify(data));
    res.json({ data });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// PUT /profiles/:id -- update fields
router.put("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updatePartnerProfileSchema.parse(req.body);

    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Profile not found");
    }

    const current = profileDoc.data()!;
    const updates: Record<string, any> = { updatedAt: new Date().toISOString() };
    for (const key of ["name","birthday","zodiacSign","loveLanguage","communicationStyle","relationshipStatus","anniversaryDate","photoUrl"]) {
      if ((body as any)[key] !== undefined) updates[key] = (body as any)[key];
    }
    updates.completionPercent = calculateCompletionPercent({ ...current, ...updates });

    await profileRef.update(updates);
    await redis.del(`profile:${id}`);

    res.json({ data: { id, name: updates.name || current.name, profileCompletionPercent: updates.completionPercent, updatedAt: updates.updatedAt } });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

// DELETE /profiles/:id -- soft delete
router.delete("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Profile not found");
    }
    await profileRef.update({ deletedAt: new Date().toISOString(), updatedAt: new Date().toISOString() });
    await redis.del(`profile:${id}`);
    res.json({ data: { message: "Profile deleted successfully", deletedAt: new Date().toISOString() } });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// GET /profiles/:id/zodiac-defaults
router.get("/:id/zodiac-defaults", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    let sign = req.query.sign as ZodiacSign | undefined;
    const validSigns: ZodiacSign[] = ["aries","taurus","gemini","cancer","leo","virgo","libra","scorpio","sagittarius","capricorn","aquarius","pisces"];

    if (!sign) {
      const profileDoc = await db.collection("users").doc(req.user.uid)
        .collection("partnerProfiles").doc(id).get();
      if (!profileDoc.exists || !profileDoc.data()?.zodiacSign) {
        throw new AppError(400, "INVALID_ZODIAC_SIGN", "No zodiac sign set on profile");
      }
      sign = profileDoc.data()!.zodiacSign;
    }
    if (!validSigns.includes(sign!)) throw new AppError(400, "INVALID_ZODIAC_SIGN", `Invalid sign: ${sign}`);

    const defaults = await loadZodiacDefaults(sign!, req.locale);
    if (!defaults) throw new AppError(404, "NOT_FOUND", "Zodiac data not found");
    res.json({ data: defaults });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// PUT /profiles/:id/preferences
router.put("/:id/preferences", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updatePreferencesSchema.parse(req.body);

    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) throw new AppError(404, "NOT_FOUND", "Profile not found");

    const current = profileDoc.data()!;
    const updatedPrefs = { ...(current.preferences || {}) };
    if (body.favorites) updatedPrefs.favorites = { ...(updatedPrefs.favorites || {}), ...body.favorites };
    if (body.dislikes !== undefined) updatedPrefs.dislikes = body.dislikes;
    if (body.hobbies !== undefined) updatedPrefs.hobbies = body.hobbies;
    if (body.stressCoping !== undefined) updatedPrefs.stressCoping = body.stressCoping;
    if (body.notes !== undefined) updatedPrefs.notes = body.notes;

    const completionPercent = calculateCompletionPercent({ ...current, preferences: updatedPrefs });
    await profileRef.update({ preferences: updatedPrefs, completionPercent, updatedAt: new Date().toISOString() });
    await redis.del(`profile:${id}`);

    res.json({ data: { id, preferences: updatedPrefs, profileCompletionPercent: completionPercent, updatedAt: new Date().toISOString() } });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

// PUT /profiles/:id/cultural-context
router.put("/:id/cultural-context", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updateCulturalContextSchema.parse(req.body);

    const profileRef = db.collection("users").doc(req.user.uid)
      .collection("partnerProfiles").doc(id);
    const profileDoc = await profileRef.get();
    if (!profileDoc.exists || profileDoc.data()?.deletedAt) throw new AppError(404, "NOT_FOUND", "Profile not found");

    const current = profileDoc.data()!;
    const updatedCtx = { ...(current.culturalContext || {}) };
    if (body.background !== undefined) updatedCtx.background = body.background;
    if (body.religiousObservance !== undefined) updatedCtx.religiousObservance = body.religiousObservance;
    if (body.dialect !== undefined) updatedCtx.dialect = body.dialect;

    // Auto-add Islamic holidays
    const autoAddedHolidays: { name: string; date: string }[] = [];
    if (updatedCtx.religiousObservance === "high" || updatedCtx.religiousObservance === "moderate") {
      const holidays = [
        { name: "Ramadan Start", date: "2026-02-18" },
        { name: "Eid al-Fitr", date: "2026-03-20" },
        { name: "Eid al-Adha", date: "2026-05-27" },
      ];
      for (const h of holidays) {
        autoAddedHolidays.push(h);
        const existing = await db.collection("users").doc(req.user.uid)
          .collection("reminders").where("title", "==", h.name).where("date", "==", h.date).limit(1).get();
        if (existing.empty) {
          await db.collection("users").doc(req.user.uid).collection("reminders").add({
            title: h.name, notes: "Auto-added Islamic holiday", category: "islamic_holiday",
            date: h.date, recurrence: "yearly", reminderTiers: [7, 3, 1, 0],
            completed: false, snoozedUntil: null,
            escalationSent: { "7d": false, "3d": false, "1d": false, same: false },
            giftSuggest: true, partnerProfileId: id, isAutoGenerated: true,
            deletedAt: null, createdAt: new Date().toISOString(), updatedAt: new Date().toISOString(),
          });
        }
      }
    }

    const completionPercent = calculateCompletionPercent({ ...current, culturalContext: updatedCtx });
    await profileRef.update({ culturalContext: updatedCtx, completionPercent, updatedAt: new Date().toISOString() });
    await redis.del(`profile:${id}`);

    res.json({ data: { id, culturalContext: updatedCtx, autoAddedHolidays, updatedAt: new Date().toISOString() } });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    next(err);
  }
});

export default router;
