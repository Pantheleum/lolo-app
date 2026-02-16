// functions/src/api/memories.ts
import { Router, Response, NextFunction } from "express";
import { v4 as uuidv4 } from "uuid";
import * as admin from "firebase-admin";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";
import {
  createMemorySchema,
  updateMemorySchema,
  createWishlistSchema,
} from "../validators/schemas";
import { encrypt, decrypt } from "../services/encryptionService";
import { awardXp } from "../services/gamificationService";

const router = Router();

// Tier limits for memories
const MEMORY_LIMITS: Record<string, number> = {
  free: 20,
  pro: 200,
  legend: Infinity,
};

const MEDIA_PER_MEMORY_LIMITS: Record<string, number> = {
  free: 3,
  pro: 10,
  legend: 10,
};

// ============================================================
// Helper: invalidate memory caches
// ============================================================
async function invalidateMemoryCaches(uid: string): Promise<void> {
  const keys = await redis.keys(`memories:*:${uid}:*`);
  if (keys.length > 0) await redis.del(...keys);
  const timeline = await redis.keys(`memories:timeline:${uid}:*`);
  if (timeline.length > 0) await redis.del(...timeline);
  await redis.del(`memories:wishlist:${uid}`);
  await redis.del(`gifts:wishlist:${uid}`);
}

// ============================================================
// Helper: check memory count against tier limit
// ============================================================
async function checkMemoryLimit(uid: string, tier: string): Promise<void> {
  const limit = MEMORY_LIMITS[tier] || 20;
  if (limit === Infinity) return;

  const countSnap = await db
    .collection("users")
    .doc(uid)
    .collection("memories")
    .where("deletedAt", "==", null)
    .count()
    .get();

  if (countSnap.data().count >= limit) {
    throw new AppError(
      403,
      "TIER_LIMIT_EXCEEDED",
      `Memory storage limit reached (${limit}). Upgrade to store more.`
    );
  }
}

// ============================================================
// Helper: build tag index for search
// ============================================================
function buildSearchableText(title: string, description?: string, tags?: string[]): string {
  const parts = [title.toLowerCase()];
  if (description) parts.push(description.toLowerCase());
  if (tags) parts.push(...tags.map((t) => t.toLowerCase()));
  return parts.join(" ");
}

// ============================================================
// GET /memories -- list with pagination, category filter, search
// ============================================================
router.get("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const {
      category,
      hasMedia,
      search,
      startDate,
      endDate,
      limit: limitStr,
      lastDocId,
    } = req.query;

    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    // Cache key (skip cache if search is used)
    const searchTerm = search as string | undefined;
    const cacheKey = searchTerm
      ? null
      : `memories:list:${req.user.uid}:${category || "all"}:${lastDocId || "start"}`;

    if (cacheKey) {
      const cached = await redis.get(cacheKey);
      if (cached) return res.json(JSON.parse(cached));
    }

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null);

    if (category && category !== "all") {
      query = query.where("category", "==", category);
    }

    if (startDate) {
      query = query.where("date", ">=", startDate as string);
    }
    if (endDate) {
      query = query.where("date", "<=", endDate as string);
    }

    query = query.orderBy("createdAt", "desc");

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(req.user.uid)
        .collection("memories")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) {
        query = query.startAfter(lastDoc);
      }
    }

    // Fetch more if search filtering is needed
    const fetchLimit = searchTerm ? 200 : limit + 1;
    const snapshot = await query.limit(fetchLimit).get();

    let docs = snapshot.docs;

    // Client-side search filter (Firestore does not support full-text search natively)
    if (searchTerm) {
      const term = searchTerm.toLowerCase();
      docs = docs.filter((doc) => {
        const d = doc.data();
        const searchable = d.searchableText || "";
        return searchable.includes(term);
      });
    }

    // Filter by hasMedia
    if (hasMedia !== undefined) {
      const wantMedia = hasMedia === "true";
      docs = docs.filter((doc) => {
        const d = doc.data();
        const mediaCount = d.mediaUrls?.length || 0;
        return wantMedia ? mediaCount > 0 : mediaCount === 0;
      });
    }

    const paginatedDocs = docs.slice(0, limit);
    const hasMore = docs.length > limit;

    const data = paginatedDocs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        title: d.title,
        description: d.encryptedContent ? decrypt(d.encryptedContent) : d.description || "",
        category: d.category,
        date: d.date,
        mood: d.mood || null,
        mediaUrls: d.mediaUrls || [],
        mediaCount: d.mediaUrls?.length || 0,
        tags: d.tags || [],
        isFavorite: d.isFavorite || false,
        linkedProfileId: d.partnerProfileId || null,
        createdAt: d.createdAt,
        updatedAt: d.updatedAt,
      };
    });

    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .count()
      .get();

    const response = {
      data,
      pagination: {
        hasMore,
        lastDocId: paginatedDocs.length > 0 ? paginatedDocs[paginatedDocs.length - 1].id : null,
        totalCount: countSnap.data().count,
      },
    };

    if (cacheKey) {
      await redis.setex(cacheKey, 120, JSON.stringify(response));
    }
    return res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /memories -- create with encryption for sensitive fields
// ============================================================
router.post("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createMemorySchema.parse(req.body);

    // Check tier limits
    await checkMemoryLimit(req.user.uid, req.user.tier);

    const memoryId = uuidv4();
    const searchableText = buildSearchableText(body.title, body.description, body.tags);

    // Encrypt description if marked as private
    const encryptedContent = body.isPrivate && body.description
      ? encrypt(body.description)
      : null;

    const memoryData = {
      title: body.title,
      description: body.isPrivate ? "[ENCRYPTED]" : (body.description || ""),
      encryptedContent,
      category: body.type,
      date: body.date,
      mood: (body as any).mood || null,
      tags: body.tags || [],
      mediaUrls: [],
      isFavorite: (body as any).isFavorite || false,
      isPrivate: body.isPrivate,
      sheSaid: body.type === "wishlist",
      partnerProfileId: (body as any).linkedProfileId || null,
      searchableText,
      deletedAt: null,
      createdAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    };

    await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(memoryId)
      .set(memoryData);

    // Award XP
    const xpResult = await awardXp(req.user.uid, "memory_added");

    // Get updated count
    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .count()
      .get();

    await invalidateMemoryCaches(req.user.uid);

    res.status(201).json({
      data: {
        id: memoryId,
        title: body.title,
        category: body.type,
        date: body.date,
        xpAwarded: xpResult.xpAwarded,
        totalMemories: countSnap.data().count,
        memoryLimit: MEMORY_LIMITS[req.user.tier] || 20,
        createdAt: memoryData.createdAt,
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

// ============================================================
// PUT /memories/:id -- update
// ============================================================
router.put("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;
    const body = updateMemorySchema.parse(req.body);

    const memoryRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(id);

    const memoryDoc = await memoryRef.get();
    if (!memoryDoc.exists || memoryDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Memory not found");
    }

    const current = memoryDoc.data()!;
    const updates: Record<string, any> = { updatedAt: new Date().toISOString() };

    if (body.title !== undefined) updates.title = body.title;
    if (body.description !== undefined) {
      if (current.isPrivate) {
        updates.encryptedContent = encrypt(body.description);
        updates.description = "[ENCRYPTED]";
      } else {
        updates.description = body.description;
      }
    }
    if (body.category !== undefined) updates.category = body.category;
    if (body.date !== undefined) updates.date = body.date;
    if ((body as any).mood !== undefined) updates.mood = (body as any).mood;
    if (body.tags !== undefined) updates.tags = body.tags;
    if ((body as any).isFavorite !== undefined) updates.isFavorite = (body as any).isFavorite;

    // Rebuild searchable text
    updates.searchableText = buildSearchableText(
      body.title || current.title,
      body.description || (current.isPrivate ? "" : current.description),
      body.tags || current.tags
    );

    await memoryRef.update(updates);
    await invalidateMemoryCaches(req.user.uid);

    res.json({
      data: {
        id,
        title: body.title || current.title,
        updatedAt: updates.updatedAt,
      },
    });
  } catch (err: any) {
    if (err instanceof AppError) return next(err);
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Validation failed"));
    }
    next(err);
  }
});

// ============================================================
// DELETE /memories/:id -- soft delete
// ============================================================
router.delete("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;

    const memoryRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(id);

    const memoryDoc = await memoryRef.get();
    if (!memoryDoc.exists || memoryDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Memory not found");
    }

    const memoryData = memoryDoc.data()!;
    const mediaUrls: string[] = memoryData.mediaUrls || [];

    // Soft delete the memory
    await memoryRef.update({
      deletedAt: new Date().toISOString(),
      updatedAt: new Date().toISOString(),
    });

    // Delete associated media from Firebase Storage (background)
    let mediaFilesDeleted = 0;
    if (mediaUrls.length > 0) {
      const bucket = admin.storage().bucket();
      for (const url of mediaUrls) {
        try {
          const filePath = extractStoragePath(url);
          if (filePath) {
            await bucket.file(filePath).delete();
            mediaFilesDeleted++;
          }
        } catch {
          // Log but do not fail if individual file deletion fails
        }
      }
    }

    await invalidateMemoryCaches(req.user.uid);

    res.json({
      data: {
        message: "Memory deleted",
        mediaFilesDeleted,
        deletedAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// POST /memories/:id/media -- upload photo (multipart)
// ============================================================
router.post("/:id/media", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { id } = req.params;

    const memoryRef = db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .doc(id);

    const memoryDoc = await memoryRef.get();
    if (!memoryDoc.exists || memoryDoc.data()?.deletedAt) {
      throw new AppError(404, "NOT_FOUND", "Memory not found");
    }

    const memoryData = memoryDoc.data()!;
    const currentMedia: string[] = memoryData.mediaUrls || [];
    const maxMedia = MEDIA_PER_MEMORY_LIMITS[req.user.tier] || 3;

    if (currentMedia.length >= maxMedia) {
      throw new AppError(403, "MEDIA_LIMIT_EXCEEDED", `Memory already has ${maxMedia} media files`);
    }

    // Parse multipart upload via busboy
    const busboy = require("busboy");
    const bb = busboy({
      headers: req.headers,
      limits: { fileSize: 10 * 1024 * 1024 }, // 10MB for images
    });

    const ALLOWED_MIME_TYPES = [
      "image/jpeg",
      "image/png",
      "image/heic",
      "image/webp",
      "video/mp4",
      "video/quicktime",
    ];

    let fileProcessed = false;
    let caption = "";

    bb.on("field", (name: string, val: string) => {
      if (name === "caption") caption = val.substring(0, 200);
    });

    bb.on("file", async (_fieldname: string, stream: any, info: any) => {
      if (fileProcessed) {
        stream.resume();
        return;
      }
      fileProcessed = true;

      const { filename, mimeType } = info;

      if (!ALLOWED_MIME_TYPES.includes(mimeType)) {
        stream.resume();
        throw new AppError(400, "INVALID_FILE_TYPE", "Unsupported file format");
      }

      const isVideo = mimeType.startsWith("video/");
      const ext = filename.split(".").pop() || (isVideo ? "mp4" : "jpg");
      const mediaId = uuidv4();
      const storagePath = `users/${req.user.uid}/memories/${id}/${mediaId}.${ext}`;

      const bucket = admin.storage().bucket();
      const file = bucket.file(storagePath);

      const writeStream = file.createWriteStream({
        metadata: {
          contentType: mimeType,
          metadata: {
            userId: req.user.uid,
            memoryId: id,
            mediaId,
            uploadedAt: new Date().toISOString(),
          },
        },
      });

      let totalSize = 0;
      const chunks: Buffer[] = [];

      stream.on("data", (chunk: Buffer) => {
        totalSize += chunk.length;
        const sizeLimit = isVideo ? 50 * 1024 * 1024 : 10 * 1024 * 1024;
        if (totalSize > sizeLimit) {
          stream.destroy();
          writeStream.destroy();
          return;
        }
        chunks.push(chunk);
        writeStream.write(chunk);
      });

      stream.on("end", async () => {
        writeStream.end();

        // Make file publicly accessible via signed URL
        await file.makePublic();
        const downloadUrl = `https://storage.googleapis.com/${bucket.name}/${storagePath}`;

        // Generate thumbnail path (would be handled by a Storage trigger in production)
        const thumbnailPath = `users/${req.user.uid}/memories/${id}/thumb_${mediaId}.${ext}`;
        const thumbnailUrl = `https://storage.googleapis.com/${bucket.name}/${thumbnailPath}`;

        // Update memory with new media URL
        const updatedMediaUrls = [...currentMedia, downloadUrl];
        await memoryRef.update({
          mediaUrls: updatedMediaUrls,
          updatedAt: new Date().toISOString(),
        });

        // Store media metadata
        await db
          .collection("users")
          .doc(req.user.uid)
          .collection("memories")
          .doc(id)
          .collection("media")
          .doc(mediaId)
          .set({
            mediaId,
            url: downloadUrl,
            thumbnailUrl,
            mimeType,
            sizeBytes: totalSize,
            caption: caption || null,
            storagePath,
            uploadedAt: new Date().toISOString(),
          });

        await invalidateMemoryCaches(req.user.uid);

        res.status(201).json({
          data: {
            mediaId,
            memoryId: id,
            url: downloadUrl,
            thumbnailUrl,
            mimeType,
            sizeBytes: totalSize,
            caption: caption || null,
            uploadedAt: new Date().toISOString(),
          },
        });
      });
    });

    bb.on("error", (err: Error) => {
      next(new AppError(400, "UPLOAD_FAILED", err.message));
    });

    req.pipe(bb);
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// GET /memories/timeline -- chronological with date grouping
// ============================================================
router.get("/timeline", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const year = parseInt(req.query.year as string) || new Date().getFullYear();

    const cacheKey = `memories:timeline:${req.user.uid}:${year}`;
    const cached = await redis.get(cacheKey);
    if (cached) {
      return res.json(JSON.parse(cached));
    }

    const yearStart = `${year}-01-01`;
    const yearEnd = `${year}-12-31`;

    const snapshot = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .where("date", ">=", yearStart)
      .where("date", "<=", yearEnd)
      .orderBy("date", "desc")
      .get();

    // Group by month
    const monthNames = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December",
    ];
    const monthNamesAr = [
      "\u064a\u0646\u0627\u064a\u0631", "\u0641\u0628\u0631\u0627\u064a\u0631", "\u0645\u0627\u0631\u0633", "\u0623\u0628\u0631\u064a\u0644", "\u0645\u0627\u064a\u0648", "\u064a\u0648\u0646\u064a\u0648",
      "\u064a\u0648\u0644\u064a\u0648", "\u0623\u063a\u0633\u0637\u0633", "\u0633\u0628\u062a\u0645\u0628\u0631", "\u0623\u0643\u062a\u0648\u0628\u0631", "\u0646\u0648\u0641\u0645\u0628\u0631", "\u062f\u064a\u0633\u0645\u0628\u0631",
    ];
    const monthNamesMs = [
      "Januari", "Februari", "Mac", "April", "Mei", "Jun",
      "Julai", "Ogos", "September", "Oktober", "November", "Disember",
    ];

    const localeMonths: Record<string, string[]> = {
      en: monthNames,
      ar: monthNamesAr,
      ms: monthNamesMs,
    };

    const monthGroups: Record<number, any[]> = {};
    for (const doc of snapshot.docs) {
      const d = doc.data();
      const monthNum = new Date(d.date).getMonth() + 1;
      if (!monthGroups[monthNum]) monthGroups[monthNum] = [];
      monthGroups[monthNum].push({
        id: doc.id,
        title: d.title,
        date: d.date,
        category: d.category,
        mood: d.mood || null,
        thumbnailUrl: d.mediaUrls?.[0] || null,
        isFavorite: d.isFavorite || false,
      });
    }

    const months = Object.entries(monthGroups)
      .map(([monthStr, memories]) => {
        const month = parseInt(monthStr);
        const names = localeMonths[req.locale] || monthNames;
        return {
          month,
          monthName: monthNames[month - 1],
          monthNameLocalized: names[month - 1],
          memoryCount: memories.length,
          memories,
        };
      })
      .sort((a, b) => b.month - a.month);

    // Get all years with memories
    const allMemories = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("memories")
      .where("deletedAt", "==", null)
      .select("date")
      .get();

    const yearsSet = new Set<number>();
    allMemories.docs.forEach((doc) => {
      const y = new Date(doc.data().date).getFullYear();
      yearsSet.add(y);
    });

    const response = {
      data: {
        year,
        months,
        totalMemories: snapshot.size,
        yearsAvailable: Array.from(yearsSet).sort((a, b) => b - a),
      },
    };

    await redis.setex(cacheKey, 300, JSON.stringify(response));
    return res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// GET /memories/wishlist -- filter by sheSaid=true
// ============================================================
router.get("/wishlist", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const { priority, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    const cacheKey = `memories:wishlist:${req.user.uid}`;
    const cached = await redis.get(cacheKey);
    if (cached && !lastDocId) {
      return res.json(JSON.parse(cached));
    }

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(req.user.uid)
      .collection("wishlist")
      .where("deletedAt", "==", null);

    if (priority && priority !== "all") {
      query = query.where("priority", "==", priority);
    }

    query = query.orderBy("addedAt", "desc");

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(req.user.uid)
        .collection("wishlist")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    query = query.limit(limit + 1);
    const snapshot = await query.get();
    const docs = snapshot.docs.slice(0, limit);
    const hasMore = snapshot.docs.length > limit;

    const countSnap = await db
      .collection("users")
      .doc(req.user.uid)
      .collection("wishlist")
      .where("deletedAt", "==", null)
      .count()
      .get();

    const data = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        item: d.item,
        category: d.category || null,
        priority: d.priority || "medium",
        estimatedPrice: d.estimatedPrice || null,
        currency: d.currency || null,
        link: d.link || null,
        notes: d.notes || null,
        source: d.source || "user_added",
        isGifted: d.isGifted || false,
        giftedDate: d.giftedDate || null,
        addedAt: d.addedAt,
      };
    });

    const response = {
      data,
      pagination: {
        hasMore,
        lastDocId: docs.length > 0 ? docs[docs.length - 1].id : null,
        totalCount: countSnap.data().count,
      },
    };

    if (!lastDocId) {
      await redis.setex(cacheKey, 300, JSON.stringify(response));
    }
    return res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// POST /memories/wishlist -- create wish entry
// ============================================================
router.post("/wishlist", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const body = createWishlistSchema.parse(req.body);
    const wishId = uuidv4();

    const wishData = {
      item: body.item,
      category: body.category || null,
      priority: body.priority || "medium",
      estimatedPrice: body.estimatedPrice || null,
      currency: body.currency || null,
      link: body.link || null,
      notes: body.notes || null,
      source: "user_added",
      isGifted: false,
      giftedDate: null,
      deletedAt: null,
      addedAt: new Date().toISOString(),
    };

    await db
      .collection("users")
      .doc(req.user.uid)
      .collection("wishlist")
      .doc(wishId)
      .set(wishData);

    await invalidateMemoryCaches(req.user.uid);

    res.status(201).json({
      data: {
        id: wishId,
        item: body.item,
        priority: wishData.priority,
        addedAt: wishData.addedAt,
      },
    });
  } catch (err: any) {
    if (err.name === "ZodError") {
      return next(new AppError(400, "INVALID_REQUEST", "Missing item name"));
    }
    next(err);
  }
});

// ============================================================
// Helper: extract storage path from URL
// ============================================================
function extractStoragePath(url: string): string | null {
  try {
    const match = url.match(/storage\.googleapis\.com\/[^/]+\/(.+)/);
    return match ? decodeURIComponent(match[1]) : null;
  } catch {
    return null;
  }
}

export default router;
