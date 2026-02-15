import 'package:flutter/material.dart';

/// LOLO type scale with locale-aware font switching.
///
/// English/Malay: Inter family
/// Arabic: Cairo (headings) + Noto Naskh Arabic (body)
abstract final class LoloTypography {
  // === English/Malay Type Scale (Inter) ===
  static const String _latinHeadingFamily = 'Inter';
  static const String _latinBodyFamily = 'Inter';

  // === Arabic Type Scale ===
  static const String _arabicHeadingFamily = 'Cairo';
  static const String _arabicBodyFamily = 'NotoNaskhArabic';

  // ----------------------------------------------------------------
  // English / Malay (Latin) TextTheme
  // ----------------------------------------------------------------

  static TextTheme get latinTextTheme => const TextTheme(
        displayLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 32,
          fontWeight: FontWeight.w700,
          height: 1.25,
          letterSpacing: -0.02,
        ),
        headlineLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 24,
          fontWeight: FontWeight.w600,
          height: 1.33,
          letterSpacing: -0.01,
        ),
        headlineMedium: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          height: 1.40,
          letterSpacing: 0,
        ),
        headlineSmall: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          height: 1.44,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.50,
          letterSpacing: 0.01,
        ),
        titleMedium: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.43,
          letterSpacing: 0.01,
        ),
        bodyLarge: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.50,
          letterSpacing: 0,
        ),
        bodyMedium: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.43,
          letterSpacing: 0.01,
        ),
        bodySmall: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.33,
          letterSpacing: 0.03,
        ),
        labelLarge: TextStyle(
          fontFamily: _latinHeadingFamily,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          height: 1.14,
          letterSpacing: 0.02,
        ),
        labelMedium: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.45,
          letterSpacing: 0.08,
        ),
        labelSmall: TextStyle(
          fontFamily: _latinBodyFamily,
          fontSize: 10,
          fontWeight: FontWeight.w400,
          height: 1.40,
          letterSpacing: 0.04,
        ),
      );

  // ----------------------------------------------------------------
  // Arabic TextTheme (+2sp headings, +1sp body per RTL guidelines)
  // ----------------------------------------------------------------

  static TextTheme get arabicTextTheme => const TextTheme(
        displayLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 34, // +2sp
          fontWeight: FontWeight.w700,
          height: 1.40,
          letterSpacing: 0,
        ),
        headlineLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 26, // +2sp
          fontWeight: FontWeight.w600,
          height: 1.46,
          letterSpacing: 0,
        ),
        headlineMedium: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 22, // +2sp
          fontWeight: FontWeight.w600,
          height: 1.50,
          letterSpacing: 0,
        ),
        headlineSmall: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 20, // +2sp
          fontWeight: FontWeight.w500,
          height: 1.50,
          letterSpacing: 0,
        ),
        titleLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 18, // +2sp
          fontWeight: FontWeight.w600,
          height: 1.56,
          letterSpacing: 0,
        ),
        titleMedium: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 15, // +1sp
          fontWeight: FontWeight.w600,
          height: 1.47,
          letterSpacing: 0,
        ),
        bodyLarge: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 17, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.65,
          letterSpacing: 0,
        ),
        bodyMedium: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 15, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.60,
          letterSpacing: 0,
        ),
        bodySmall: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 13, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.54,
          letterSpacing: 0,
        ),
        labelLarge: TextStyle(
          fontFamily: _arabicHeadingFamily,
          fontSize: 15, // +1sp
          fontWeight: FontWeight.w600,
          height: 1.20,
          letterSpacing: 0,
        ),
        labelMedium: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 12, // +1sp
          fontWeight: FontWeight.w500,
          height: 1.50,
          letterSpacing: 0,
        ),
        labelSmall: TextStyle(
          fontFamily: _arabicBodyFamily,
          fontSize: 11, // +1sp
          fontWeight: FontWeight.w400,
          height: 1.45,
          letterSpacing: 0,
        ),
      );

  /// Returns the correct TextTheme for the given locale.
  static TextTheme forLocale(Locale locale) {
    if (locale.languageCode == 'ar') {
      return arabicTextTheme;
    }
    return latinTextTheme;
  }
}
