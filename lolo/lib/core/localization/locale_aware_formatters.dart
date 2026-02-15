import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Locale-aware date formatting with optional Hijri calendar for Arabic.
///
/// Uses the `intl` package for Gregorian formatting and a custom
/// Hijri approximation for Arabic users with high religious observance.
class LocaleAwareDateFormatter {
  /// Format a date according to the current locale.
  ///
  /// English: "March 15, 2026"
  /// Arabic:  "\u0661\u0665 \u0645\u0627\u0631\u0633 \u0662\u0660\u0662\u0666" (with optional Hijri: "\u0662\u0660 \u0631\u0645\u0636\u0627\u0646 \u0661\u0664\u0664\u0667")
  /// Malay:   "15 Mac 2026"
  static String formatDate(
    DateTime date,
    Locale locale, {
    bool showHijri = false,
  }) {
    final formatter = DateFormat.yMMMMd(locale.languageCode);
    final gregorian = formatter.format(date);

    if (showHijri && locale.languageCode == 'ar') {
      final hijri = _toHijriApprox(date);
      return '$gregorian\n$hijri';
    }

    return gregorian;
  }

  /// Format a short date for list items.
  ///
  /// English: "Mar 15"
  /// Arabic:  "\u0661\u0665 \u0645\u0627\u0631\u0633"
  /// Malay:   "15 Mac"
  static String formatShortDate(DateTime date, Locale locale) =>
      DateFormat.MMMd(locale.languageCode).format(date);

  /// Format time according to locale preferences.
  ///
  /// English: "2:30 PM"
  /// Arabic:  "2:30 \u0645"
  /// Malay:   "2:30 PM"
  static String formatTime(TimeOfDay time, Locale locale) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm(locale.languageCode).format(dt);
  }

  /// Format "days until" with locale-aware text.
  static String formatDaysUntil(int days, Locale locale) {
    if (days == 0) return _todayLabel(locale);
    if (days == 1) return _tomorrowLabel(locale);

    return switch (locale.languageCode) {
      'ar' => '\u0628\u0639\u062F $days \u064A\u0648\u0645',
      'ms' => 'Dalam $days hari',
      _ => 'In $days days',
    };
  }

  static String _todayLabel(Locale locale) => switch (locale.languageCode) {
        'ar' => '\u0627\u0644\u064A\u0648\u0645',
        'ms' => 'Hari ini',
        _ => 'Today',
      };

  static String _tomorrowLabel(Locale locale) => switch (locale.languageCode) {
        'ar' => '\u063A\u062F\u064B\u0627',
        'ms' => 'Esok',
        _ => 'Tomorrow',
      };

  /// Approximate Hijri date from Gregorian.
  ///
  /// For production, use the `hijri` package for accurate conversion.
  /// This is a placeholder approximation.
  static String _toHijriApprox(DateTime gregorian) {
    // Placeholder -- use hijri_calendar package in production
    return '\u0627\u0644\u062A\u0627\u0631\u064A\u062E \u0627\u0644\u0647\u062C\u0631\u064A';
  }
}
