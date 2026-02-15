// functions/src/middleware/tierEnforcement.ts
import { Response, NextFunction } from "express";
import { AuthenticatedRequest, AppError } from "../types";
import { getTierFromFirestore, isFeatureAllowed, checkLimit, TIER_CONFIG } from "../services/subscriptionService";

type LimitKey = "aiMessages" | "sosSessions" | "actionCards" | "memories" | "giftSuggestions";

export function requireFeature(feature: string) {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const tier = await getTierFromFirestore(req.user.uid);
      if (!isFeatureAllowed(tier, feature)) {
        throw new AppError(403, "TIER_LIMIT_EXCEEDED", `Feature "${feature}" requires a higher subscription tier`, {
          currentTier: tier,
          requiredFeature: feature,
          upgradeTiers: (["pro", "legend"] as const).filter((t) => isFeatureAllowed(t, feature)),
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}

export function requireTier(...allowedTiers: string[]) {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const tier = await getTierFromFirestore(req.user.uid);
      if (!allowedTiers.includes(tier)) {
        throw new AppError(403, "TIER_LIMIT_EXCEEDED", `This endpoint requires ${allowedTiers.join(" or ")} tier`, {
          currentTier: tier,
          requiredTiers: allowedTiers,
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}

export function enforceLimit(limitKey: LimitKey) {
  return async (req: AuthenticatedRequest, res: Response, next: NextFunction) => {
    try {
      const { allowed, current, limit } = await checkLimit(req.user.uid, limitKey);
      if (!allowed) {
        throw new AppError(403, "TIER_LIMIT_EXCEEDED", `Monthly ${limitKey} limit reached`, {
          currentUsage: current,
          monthlyLimit: limit,
          limitKey,
        });
      }
      next();
    } catch (err) {
      next(err);
    }
  };
}
