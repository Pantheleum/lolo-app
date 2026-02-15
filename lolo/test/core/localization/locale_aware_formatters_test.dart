import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lolo/core/localization/locale_aware_formatters.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('en', null);
    await initializeDateFormatting('ar', null);
    await initializeDateFormatting('ms', null);
  });

  group('LocaleAwareDateFormatter.formatDate', () {
    final testDate = DateTime(2026, 3, 15);

    test('formats date in English locale', () {
      final result = LocaleAwareDateFormatter.formatDate(
        testDate,
        const Locale('en'),
      );
      expect(result, contains('March'));
      expect(result, contains('15'));
      expect(result, contains('2026'));
    });

    test('formats date in Arabic locale', () {
      final result = LocaleAwareDateFormatter.formatDate(
        testDate,
        const Locale('ar'),
      );
      // Arabic formatted date should contain some text (not empty)
      expect(result, isNotEmpty);
    });

    test('formats date in Malay locale', () {
      final result = LocaleAwareDateFormatter.formatDate(
        testDate,
        const Locale('ms'),
      );
      expect(result, isNotEmpty);
      expect(result, contains('2026'));
    });

    test('includes Hijri approximation for Arabic with showHijri', () {
      final result = LocaleAwareDateFormatter.formatDate(
        testDate,
        const Locale('ar'),
        showHijri: true,
      );
      // Should contain a newline separating Gregorian and Hijri
      expect(result, contains('\n'));
    });

    test('does not include Hijri for non-Arabic even with showHijri', () {
      final result = LocaleAwareDateFormatter.formatDate(
        testDate,
        const Locale('en'),
        showHijri: true,
      );
      expect(result, isNot(contains('\n')));
    });
  });

  group('LocaleAwareDateFormatter.formatShortDate', () {
    final testDate = DateTime(2026, 3, 15);

    test('formats short date in English', () {
      final result = LocaleAwareDateFormatter.formatShortDate(
        testDate,
        const Locale('en'),
      );
      expect(result, contains('Mar'));
      expect(result, contains('15'));
    });

    test('formats short date in Arabic', () {
      final result = LocaleAwareDateFormatter.formatShortDate(
        testDate,
        const Locale('ar'),
      );
      expect(result, isNotEmpty);
    });

    test('formats short date in Malay', () {
      final result = LocaleAwareDateFormatter.formatShortDate(
        testDate,
        const Locale('ms'),
      );
      expect(result, isNotEmpty);
    });
  });

  group('LocaleAwareDateFormatter.formatDaysUntil', () {
    test('returns Today for 0 days in English', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        0,
        const Locale('en'),
      );
      expect(result, 'Today');
    });

    test('returns Tomorrow for 1 day in English', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        1,
        const Locale('en'),
      );
      expect(result, 'Tomorrow');
    });

    test('returns "In N days" for multiple days in English', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        5,
        const Locale('en'),
      );
      expect(result, 'In 5 days');
    });

    test('returns Arabic label for 0 days', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        0,
        const Locale('ar'),
      );
      // Arabic "Today" = اليوم
      expect(result, '\u0627\u0644\u064A\u0648\u0645');
    });

    test('returns Arabic label for 1 day', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        1,
        const Locale('ar'),
      );
      // Arabic "Tomorrow" = غدًا
      expect(result, '\u063A\u062F\u064B\u0627');
    });

    test('returns Arabic label for multiple days', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        5,
        const Locale('ar'),
      );
      expect(result, contains('5'));
    });

    test('returns Malay label for 0 days', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        0,
        const Locale('ms'),
      );
      expect(result, 'Hari ini');
    });

    test('returns Malay label for 1 day', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        1,
        const Locale('ms'),
      );
      expect(result, 'Esok');
    });

    test('returns Malay label for multiple days', () {
      final result = LocaleAwareDateFormatter.formatDaysUntil(
        5,
        const Locale('ms'),
      );
      expect(result, 'Dalam 5 hari');
    });
  });
}
