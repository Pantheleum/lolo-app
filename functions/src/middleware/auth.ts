// functions/src/middleware/auth.ts
import { Response, NextFunction } from "express";
import { auth, db } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

export async function authMiddleware(
  req: AuthenticatedRequest,
  _res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const header = req.headers.authorization;
    if (!header?.startsWith("Bearer ")) {
      throw new AppError(401, "UNAUTHENTICATED", "Missing or invalid authorization header");
    }

    const token = header.split("Bearer ")[1];
    const decoded = await auth.verifyIdToken(token);

    const userDoc = await db.collection("users").doc(decoded.uid).get();
    if (!userDoc.exists) {
      throw new AppError(401, "UNAUTHENTICATED", "User record not found");
    }

    const userData = userDoc.data()!;
    req.user = {
      uid: decoded.uid,
      email: decoded.email || "",
      displayName: userData.displayName || "",
      language: userData.language || "en",
      tier: userData.tier || "free",
    };

    req.requestId = (req.headers["x-request-id"] as string) || crypto.randomUUID();
    next();
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(new AppError(401, "UNAUTHENTICATED", "Invalid or expired token"));
  }
}
