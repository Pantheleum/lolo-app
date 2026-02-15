// functions/src/middleware/locale.ts
import { Request, Response, NextFunction } from "express";
import { SupportedLocale, AuthenticatedRequest } from "../types";

const SUPPORTED_LOCALES: SupportedLocale[] = ["en", "ar", "ms"];

export function localeMiddleware(
  req: Request,
  _res: Response,
  next: NextFunction
): void {
  const acceptLang = req.headers["accept-language"] as string | undefined;
  let locale: SupportedLocale = "en";

  if (acceptLang) {
    const preferred = acceptLang.split(",")[0].trim().substring(0, 2).toLowerCase();
    if (SUPPORTED_LOCALES.includes(preferred as SupportedLocale)) {
      locale = preferred as SupportedLocale;
    }
  }

  (req as AuthenticatedRequest).locale = locale;
  next();
}
