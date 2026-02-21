// functions/src/api/notifications.ts
import { Router, Response, NextFunction } from "express";
import { db, redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

const router = Router();

// ============================================================
// Helper: invalidate notification caches
// ============================================================
async function invalidateNotificationCaches(uid: string): Promise<void> {
  const keys = await redis.keys(`notifications:${uid}:*`);
  if (keys.length > 0) await redis.del(...keys);
  await redis.del(`notifications:${uid}`);
}

// ============================================================
// POST /notifications/device — register or update FCM token
// ============================================================
router.post("/device", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { token, platform } = req.body;

    if (!token || typeof token !== "string") {
      throw new AppError(400, "INVALID_REQUEST", "FCM token is required");
    }

    // Upsert: use token as doc ID to prevent duplicates
    const tokenDocId = Buffer.from(token).toString("base64url").slice(0, 128);
    await db.collection("fcm_tokens").doc(tokenDocId).set({
      userId: uid,
      token,
      platform: platform || "unknown",
      updatedAt: new Date().toISOString(),
      createdAt: new Date().toISOString(),
    }, { merge: true });

    res.json({
      data: {
        registered: true,
        message: "Device token registered successfully",
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// DELETE /notifications/device — unregister FCM token (logout)
// ============================================================
router.delete("/device", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { token } = req.body;

    if (token) {
      // Remove specific token
      const tokenDocId = Buffer.from(token).toString("base64url").slice(0, 128);
      await db.collection("fcm_tokens").doc(tokenDocId).delete();
    } else {
      // Remove all tokens for this user
      const tokensSnap = await db.collection("fcm_tokens").where("userId", "==", uid).get();
      const batch = db.batch();
      for (const doc of tokensSnap.docs) {
        batch.delete(doc.ref);
      }
      await batch.commit();
    }

    res.json({
      data: {
        unregistered: true,
        message: "Device token(s) removed successfully",
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// GET /notifications — returns user notifications with pagination
// ============================================================
router.get("/", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const { unreadOnly, type, limit: limitStr, lastDocId } = req.query;
    const limit = Math.min(parseInt(limitStr as string) || 20, 50);

    const cacheKey = `notifications:${uid}:${unreadOnly || "all"}:${type || "all"}:${lastDocId || "start"}`;
    const cached = await redis.get(cacheKey);
    if (cached) return res.json(JSON.parse(cached));

    let query: FirebaseFirestore.Query = db
      .collection("users")
      .doc(uid)
      .collection("notifications")
      .orderBy("createdAt", "desc");

    if (unreadOnly === "true") {
      query = query.where("read", "==", false);
    }

    if (type) {
      query = query.where("type", "==", type);
    }

    if (lastDocId) {
      const lastDoc = await db
        .collection("users")
        .doc(uid)
        .collection("notifications")
        .doc(lastDocId as string)
        .get();
      if (lastDoc.exists) query = query.startAfter(lastDoc);
    }

    const snapshot = await query.limit(limit + 1).get();
    const hasMore = snapshot.docs.length > limit;
    const docs = hasMore ? snapshot.docs.slice(0, limit) : snapshot.docs;

    const notifications = docs.map((doc) => {
      const d = doc.data();
      return {
        id: doc.id,
        type: d.type,
        title: d.title,
        body: d.body,
        data: d.data || null,
        read: d.read || false,
        readAt: d.readAt || null,
        createdAt: d.createdAt,
      };
    });

    // Get unread count
    const unreadSnap = await db
      .collection("users")
      .doc(uid)
      .collection("notifications")
      .where("read", "==", false)
      .count()
      .get();

    const response = {
      data: notifications,
      unreadCount: unreadSnap.data().count,
      pagination: {
        hasMore,
        lastDocId: docs.length > 0 ? docs[docs.length - 1].id : null,
        count: notifications.length,
      },
    };

    await redis.setex(cacheKey, 60, JSON.stringify(response));
    res.json(response);
  } catch (err) {
    next(err);
  }
});

// ============================================================
// PUT /notifications/:id/read — marks a notification as read
// ============================================================
router.put("/:id/read", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const notificationId = req.params.id;

    const notificationRef = db
      .collection("users")
      .doc(uid)
      .collection("notifications")
      .doc(notificationId);

    const notificationDoc = await notificationRef.get();
    if (!notificationDoc.exists) {
      throw new AppError(404, "NOTIFICATION_NOT_FOUND", "Notification not found");
    }

    const data = notificationDoc.data()!;
    if (data.read) {
      return res.json({
        data: {
          id: notificationId,
          read: true,
          readAt: data.readAt,
          message: "Notification was already marked as read",
        },
      });
    }

    const readAt = new Date().toISOString();
    await notificationRef.update({
      read: true,
      readAt,
      updatedAt: readAt,
    });

    await invalidateNotificationCaches(uid);

    res.json({
      data: {
        id: notificationId,
        read: true,
        readAt,
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

// ============================================================
// DELETE /notifications/:id — deletes a notification
// ============================================================
router.delete("/:id", async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
  try {
    const uid = req.user.uid;
    const notificationId = req.params.id;

    const notificationRef = db
      .collection("users")
      .doc(uid)
      .collection("notifications")
      .doc(notificationId);

    const notificationDoc = await notificationRef.get();
    if (!notificationDoc.exists) {
      throw new AppError(404, "NOTIFICATION_NOT_FOUND", "Notification not found");
    }

    await notificationRef.delete();

    await invalidateNotificationCaches(uid);

    res.json({
      data: {
        id: notificationId,
        deleted: true,
        deletedAt: new Date().toISOString(),
      },
    });
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(err);
  }
});

export default router;
