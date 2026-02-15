// functions/src/middleware/rateLimit.ts
import { Response, NextFunction } from "express";
import { redis } from "../config";
import { AuthenticatedRequest, AppError } from "../types";

interface RateLimitConfig {
  windowSeconds: number;
  maxRequests: number;
}

const ROUTE_LIMITS: Record<string, RateLimitConfig> = {
  "POST:/api/v1/auth/register": { windowSeconds: 60, maxRequests: 5 },
  "POST:/api/v1/auth/login": { windowSeconds: 60, maxRequests: 10 },
  "POST:/api/v1/sos/activate": { windowSeconds: 60, maxRequests: 5 },
  "POST:/api/v1/sos/coach": { windowSeconds: 60, maxRequests: 20 },
  "POST:/api/v1/messages/generate": { windowSeconds: 60, maxRequests: 15 },
  DEFAULT: { windowSeconds: 60, maxRequests: 30 },
};

export async function rateLimitMiddleware(
  req: AuthenticatedRequest,
  res: Response,
  next: NextFunction
): Promise<void> {
  try {
    const routeKey = `${req.method}:${req.baseUrl}${req.path}`;
    const config = ROUTE_LIMITS[routeKey] || ROUTE_LIMITS.DEFAULT;
    const identifier = req.user?.uid || req.ip;
    const redisKey = `rl:${routeKey}:${identifier}`;

    const current = await redis.incr(redisKey);
    if (current === 1) {
      await redis.expire(redisKey, config.windowSeconds);
    }

    const ttl = await redis.ttl(redisKey);
    res.set("X-RateLimit-Limit", String(config.maxRequests));
    res.set("X-RateLimit-Remaining", String(Math.max(0, config.maxRequests - current)));
    res.set("X-RateLimit-Reset", String(ttl));

    if (current > config.maxRequests) {
      res.set("Retry-After", String(ttl));
      throw new AppError(429, "RATE_LIMITED", "Too many requests");
    }
    next();
  } catch (err) {
    if (err instanceof AppError) return next(err);
    next(); // fail open if Redis is down
  }
}
