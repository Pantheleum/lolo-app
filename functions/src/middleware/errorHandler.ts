// functions/src/middleware/errorHandler.ts
import { Request, Response, NextFunction } from "express";
import { AppError } from "../types";
import * as functions from "firebase-functions";

export function errorHandler(
  err: Error,
  _req: Request,
  res: Response,
  _next: NextFunction
): void {
  console.error(`[ERR] ${_req.method} ${_req.originalUrl} => ${err.message}`);
  if (err instanceof AppError) {
    res.status(err.statusCode).json({
      error: {
        code: err.code,
        message: err.message,
        details: err.details || {},
      },
    });
    return;
  }

  functions.logger.error("Unhandled error", { error: err.message, stack: err.stack });
  res.status(500).json({
    error: {
      code: "INTERNAL_ERROR",
      message: "An unexpected error occurred",
      details: {},
    },
  });
}

export function notFoundHandler(req: Request, res: Response): void {
  console.log(`[404] Route not found: ${req.method} ${req.originalUrl} (path: ${req.path})`);
  res.status(404).json({
    error: {
      code: "NOT_FOUND",
      message: `Route ${req.method} ${req.path} not found`,
      details: {},
    },
  });
}
