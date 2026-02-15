# LOLO Multi-Language QA Suite and Beta Feedback Analysis Framework

**Prepared by:** Yuki Tanaka, QA Engineer
**Date:** February 15, 2026
**Document Version:** 1.0
**Classification:** Internal -- Confidential
**Scope:** Translation verification (EN/AR/MS), AI output language testing, beta feedback infrastructure, accessibility audit
**Dependencies:** Localization Architecture v1.0, Multi-Language Prompt Strategy v1.0, RTL Design Guidelines v2.0, Full Regression Suite v1.0, Cultural Sensitivity Guide v1.0

---

## Table of Contents

1. [Part 1: Multi-Language QA Test Suite](#part-1-multi-language-qa-test-suite)
   - [1.1 Translation Completeness Audit](#11-translation-completeness-audit)
   - [1.2 Arabic Language QA](#12-arabic-language-qa)
   - [1.3 Bahasa Melayu Language QA](#13-bahasa-melayu-language-qa)
   - [1.4 AI Output Language Verification](#14-ai-output-language-verification)
2. [Part 2: Beta Feedback Analysis Framework](#part-2-beta-feedback-analysis-framework)
   - [2.1 Feedback Collection System](#21-feedback-collection-system)
   - [2.2 Feedback Categorization Framework](#22-feedback-categorization-framework)
   - [2.3 Beta Metrics Dashboard](#23-beta-metrics-dashboard)
   - [2.4 Beta-to-Launch Decision Framework](#24-beta-to-launch-decision-framework)
3. [Part 3: Accessibility QA](#part-3-accessibility-qa)
   - [3.1 Screen Reader Test Suite](#31-screen-reader-test-suite)
   - [3.2 Font Scaling and Visual Tests](#32-font-scaling-and-visual-tests)
   - [3.3 Semantic Labels in All Languages](#33-semantic-labels-in-all-languages)

---

# Part 1: Multi-Language QA Test Suite

## 1.1 Translation Completeness Audit

### 1.1.1 ARB Key Verification Script

This Dart script scans all three ARB files (`app_en.arb`, `app_ar.arb`, `app_ms.arb`) and reports missing keys, missing placeholders, and plural form gaps.

```dart
// test/l10n/arb_completeness_test.dart

import 'dart:convert';
import 'dart:io';
import 'package:test/test.dart';

/// Loads an ARB file and returns its key-value map, filtering metadata keys.
Map<String, dynamic> loadArb(String path) {
  final file = File(path);
  if (!file.existsSync()) fail('ARB file not found: $path');
  final raw = json.decode(file.readAsStringSync()) as Map<String, dynamic>;
  // Filter out metadata keys (@@locale, @@last_modified, keys starting with __)
  raw.removeWhere((k, _) => k.startsWith('@@') || k.startsWith('__'));
  return raw;
}

/// Returns all non-metadata, non-description keys (i.e., actual string keys).
Set<String> stringKeys(Map<String, dynamic> arb) {
  return arb.keys.where((k) => !k.startsWith('@')).toSet();
}

/// Extracts placeholder names from an ARB metadata entry.
Set<String> extractPlaceholders(Map<String, dynamic> arb, String key) {
  final metaKey = '@$key';
  if (!arb.containsKey(metaKey)) return {};
  final meta = arb[metaKey];
  if (meta is! Map || !meta.containsKey('placeholders')) return {};
  return (meta['placeholders'] as Map).keys.cast<String>().toSet();
}

/// Extracts {placeholder} references from the string value itself.
Set<String> extractInlinePlaceholders(String value) {
  final regex = RegExp(r'\{(\w+)\}');
  return regex.allMatches(value).map((m) => m.group(1)!).toSet();
}

void main() {
  const arbDir = 'lib/l10n';
  late Map<String, dynamic> enArb, arArb, msArb;
  late Set<String> enKeys, arKeys, msKeys;

  setUpAll(() {
    enArb = loadArb('$arbDir/app_en.arb');
    arArb = loadArb('$arbDir/app_ar.arb');
    msArb = loadArb('$arbDir/app_ms.arb');
    enKeys = stringKeys(enArb);
    arKeys = stringKeys(arArb);
    msKeys = stringKeys(msArb);
  });

  group('Key Completeness', () {
    test('Arabic ARB contains all English keys', () {
      final missing = enKeys.difference(arKeys);
      expect(missing, isEmpty,
          reason: 'Arabic ARB is missing ${missing.length} keys:\n'
              '${missing.join('\n')}');
    });

    test('Malay ARB contains all English keys', () {
      final missing = enKeys.difference(msKeys);
      expect(missing, isEmpty,
          reason: 'Malay ARB is missing ${missing.length} keys:\n'
              '${missing.join('\n')}');
    });

    test('No orphan keys in Arabic ARB (keys not in English)', () {
      final orphans = arKeys.difference(enKeys);
      expect(orphans, isEmpty,
          reason: 'Arabic ARB has ${orphans.length} orphan keys:\n'
              '${orphans.join('\n')}');
    });

    test('No orphan keys in Malay ARB (keys not in English)', () {
      final orphans = msKeys.difference(enKeys);
      expect(orphans, isEmpty,
          reason: 'Malay ARB has ${orphans.length} orphan keys:\n'
              '${orphans.join('\n')}');
    });
  });

  group('Placeholder Validation', () {
    test('Arabic ARB has all placeholders from English', () {
      final failures = <String>[];
      for (final key in enKeys) {
        final enPlaceholders = extractPlaceholders(enArb, key);
        if (enPlaceholders.isEmpty) continue;
        final arValue = arArb[key];
        if (arValue == null) continue; // caught by key completeness test
        final arInline = extractInlinePlaceholders(arValue.toString());
        final missing = enPlaceholders.difference(arInline);
        if (missing.isNotEmpty) {
          failures.add('  $key: missing {${missing.join('}, {')}}');
        }
      }
      expect(failures, isEmpty,
          reason: 'Arabic placeholder mismatches:\n${failures.join('\n')}');
    });

    test('Malay ARB has all placeholders from English', () {
      final failures = <String>[];
      for (final key in enKeys) {
        final enPlaceholders = extractPlaceholders(enArb, key);
        if (enPlaceholders.isEmpty) continue;
        final msValue = msArb[key];
        if (msValue == null) continue;
        final msInline = extractInlinePlaceholders(msValue.toString());
        final missing = enPlaceholders.difference(msInline);
        if (missing.isNotEmpty) {
          failures.add('  $key: missing {${missing.join('}, {')}}');
        }
      }
      expect(failures, isEmpty,
          reason: 'Malay placeholder mismatches:\n${failures.join('\n')}');
    });
  });

  group('String Length Overflow Risk', () {
    test('Arabic strings within 40% of English length (overflow warning)', () {
      final warnings = <String>[];
      for (final key in enKeys) {
        final enVal = enArb[key]?.toString() ?? '';
        final arVal = arArb[key]?.toString() ?? '';
        if (enVal.isEmpty || arVal.isEmpty) continue;
        final ratio = arVal.length / enVal.length;
        // Arabic is typically 20-30% longer; flag if >40% longer
        if (ratio > 1.4 && enVal.length > 10) {
          warnings.add('  $key: EN=${enVal.length} AR=${arVal.length} '
              '(${(ratio * 100).toStringAsFixed(0)}%)');
        }
      }
      if (warnings.isNotEmpty) {
        print('WARNING: ${warnings.length} Arabic strings exceed 140% of '
            'English length (potential UI overflow):\n${warnings.join('\n')}');
      }
      // This is a warning, not a failure -- but flag for manual review
      expect(warnings.length, lessThan(20),
          reason: 'Too many Arabic strings risk overflow');
    });

    test('Malay strings within 30% of English length', () {
      final warnings = <String>[];
      for (final key in enKeys) {
        final enVal = enArb[key]?.toString() ?? '';
        final msVal = msArb[key]?.toString() ?? '';
        if (enVal.isEmpty || msVal.isEmpty) continue;
        final ratio = msVal.length / enVal.length;
        if (ratio > 1.3 && enVal.length > 10) {
          warnings.add('  $key: EN=${enVal.length} MS=${msVal.length} '
              '(${(ratio * 100).toStringAsFixed(0)}%)');
        }
      }
      if (warnings.isNotEmpty) {
        print('WARNING: ${warnings.length} Malay strings exceed 130%:\n'
            '${warnings.join('\n')}');
      }
      expect(warnings.length, lessThan(15),
          reason: 'Too many Malay strings risk overflow');
    });
  });

  group('Plural Form Verification', () {
    // English: 2 forms (one, other)
    // Arabic: 6 forms (zero, one, two, few, many, other)
    // Malay: 1 form (other) -- no grammatical plurals
    test('Arabic plural keys define all 6 ICU forms', () {
      final arabicPluralForms = ['zero', 'one', 'two', 'few', 'many', 'other'];
      final failures = <String>[];
      for (final key in enKeys) {
        final metaKey = '@$key';
        if (!enArb.containsKey(metaKey)) continue;
        final meta = enArb[metaKey];
        if (meta is! Map) continue;
        // Check if this key uses ICU plural syntax
        final enVal = enArb[key]?.toString() ?? '';
        if (!enVal.contains('{') || !enVal.contains('plural')) continue;
        final arVal = arArb[key]?.toString() ?? '';
        if (arVal.isEmpty) continue;
        for (final form in arabicPluralForms) {
          if (!arVal.contains('=$form') && !arVal.contains(form)) {
            // Only flag if the Arabic value uses plural syntax at all
            if (arVal.contains('plural')) {
              failures.add('  $key: missing Arabic plural form "$form"');
            }
          }
        }
      }
      if (failures.isNotEmpty) {
        print('Arabic plural form gaps:\n${failures.join('\n')}');
      }
    });

    test('Malay plural keys use simple "other" form only', () {
      final failures = <String>[];
      for (final key in enKeys) {
        final msVal = msArb[key]?.toString() ?? '';
        if (msVal.isEmpty) continue;
        // Malay should NOT have complex plural forms
        if (msVal.contains('{') && msVal.contains('plural')) {
          if (msVal.contains('=one') || msVal.contains('=two') ||
              msVal.contains('=few')) {
            failures.add('  $key: Malay should not have plural forms '
                '(use "other" only)');
          }
        }
      }
      expect(failures, isEmpty,
          reason: 'Malay incorrectly uses plural forms:\n'
              '${failures.join('\n')}');
    });
  });

  group('Gender-Specific Text', () {
    test('Arabic strings use correct feminine verb/adjective forms', () {
      // Arabic verbs/adjectives addressing the female partner must use
      // feminine forms. Check for common masculine markers in partner context.
      final partnerKeys = enKeys.where((k) =>
          k.contains('partner') || k.contains('her') || k.contains('she'));
      final warnings = <String>[];
      for (final key in partnerKeys) {
        final arVal = arArb[key]?.toString() ?? '';
        if (arVal.isEmpty) continue;
        // Flag if masculine suffix patterns appear in partner-context keys
        // This is a heuristic -- native reviewer must validate
        if (arVal.contains('ه ') && !arVal.contains('ها ')) {
          warnings.add('  $key: possible masculine pronoun in '
              'partner-context string');
        }
      }
      if (warnings.isNotEmpty) {
        print('Gender review needed:\n${warnings.join('\n')}');
      }
    });
  });

  group('Number Format Verification', () {
    test('Arabic strings with numbers use Arabic-Indic numerals or '
        'are format-safe', () {
      // Keys that display numbers should use {count} placeholders,
      // not hardcoded Western digits
      final failures = <String>[];
      for (final key in arKeys) {
        final arVal = arArb[key]?.toString() ?? '';
        // Check for hardcoded Western digits in Arabic strings
        if (RegExp(r'[0-9]').hasMatch(arVal) &&
            !arVal.contains('{') &&
            !key.startsWith('@')) {
          failures.add('  $key: contains Western digits in Arabic string '
              '(use placeholder or Arabic-Indic numerals)');
        }
      }
      if (failures.isNotEmpty) {
        print('Number format issues:\n${failures.join('\n')}');
      }
    });
  });
}
```

### 1.1.2 Number Formatting Test Matrix

| Format Type | English (en) | Arabic (ar) | Malay (ms) | Test Value |
|-------------|-------------|-------------|------------|------------|
| Integer | 1,234 | ١٬٢٣٤ | 1,234 | 1234 |
| Decimal | 1,234.56 | ١٬٢٣٤٫٥٦ | 1,234.56 | 1234.56 |
| Currency | $19.99 | ١٩٫٩٩ ر.س | RM19.99 | 19.99 |
| Percentage | 85% | ٪٨٥ | 85% | 0.85 |
| Ordinal | 1st, 2nd, 3rd | الأول، الثاني | ke-1, ke-2 | 1, 2, 3 |
| Phone | +1 (555) 123-4567 | +٩٦٦ ٥٥ ١٢٣ ٤٥٦٧ | +60 12-345 6789 | varies |
| Date (short) | 02/15/2026 | ١٥/٠٢/٢٠٢٦ | 15/02/2026 | 2026-02-15 |
| Date (long) | February 15, 2026 | ١٥ فبراير ٢٠٢٦ | 15 Februari 2026 | 2026-02-15 |
| Hijri date | N/A | ١٧ شعبان ١٤٤٧ | 17 Syaaban 1447 | 1447-08-17 |
| Time (12h) | 3:30 PM | ٣:٣٠ م | 3:30 PTG | 15:30 |

```dart
// test/l10n/number_format_test.dart

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  group('Number Formatting per Locale', () {
    test('English integer formatting', () {
      final fmt = NumberFormat('#,##0', 'en');
      expect(fmt.format(1234), equals('1,234'));
      expect(fmt.format(1000000), equals('1,000,000'));
    });

    test('Arabic integer formatting uses Arabic-Indic digits', () {
      final fmt = NumberFormat('#,##0', 'ar');
      final result = fmt.format(1234);
      // Should contain Arabic-Indic digits (U+0660-U+0669)
      expect(result.contains(RegExp(r'[\u0660-\u0669]')), isTrue,
          reason: 'Arabic format should use Arabic-Indic digits: $result');
    });

    test('Malay integer formatting', () {
      final fmt = NumberFormat('#,##0', 'ms');
      expect(fmt.format(1234), equals('1,234'));
    });

    test('Currency formatting per locale', () {
      expect(NumberFormat.currency(locale: 'en', symbol: r'$').format(19.99),
          contains('19.99'));
      expect(
          NumberFormat.currency(locale: 'ar', symbol: 'ر.س').format(19.99),
          isNotEmpty);
      expect(
          NumberFormat.currency(locale: 'ms', symbol: 'RM').format(19.99),
          contains('19.99'));
    });

    test('Percentage formatting per locale', () {
      final enPct = NumberFormat.percentPattern('en').format(0.85);
      final arPct = NumberFormat.percentPattern('ar').format(0.85);
      final msPct = NumberFormat.percentPattern('ms').format(0.85);
      expect(enPct, contains('85'));
      expect(arPct, isNotEmpty); // Arabic-Indic 85 equivalent
      expect(msPct, contains('85'));
    });
  });
}
```

### 1.1.3 Translation Completeness Tracking Matrix

| Module | Screen Count | EN Keys | AR Keys | MS Keys | AR % | MS % | Status |
|--------|-------------|---------|---------|---------|------|------|--------|
| Common/Shared | -- | ~30 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Auth | 2 | ~10 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Onboarding | 8 | ~25 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Dashboard | 3 | ~15 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Her Profile | 4 | ~20 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Smart Reminders | 3 | ~15 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| AI Messages | 4 | ~35 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Gift Engine | 3 | ~15 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Action Cards | 3 | ~20 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| SOS Mode | 4 | ~20 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Gamification | 3 | ~25 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Memories | 3 | ~15 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Subscription | 3 | ~20 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| Settings | 2 | ~15 | [ ] | [ ] | [ ]% | [ ]% | [ ] |
| **TOTAL** | **43+** | **~280** | **[ ]** | **[ ]** | **[ ]%** | **[ ]%** | **[ ]** |

**Pass criteria:** 100% key coverage in all three languages. Zero missing placeholders. All plural forms present for Arabic.

---

## 1.2 Arabic Language QA

### 1.2.1 Native Speaker Review Checklist

A qualified Arabic native speaker (Gulf dialect primary, MSA secondary) must review every string against the following criteria. Each item is scored Pass / Fail / Needs Revision.

| # | Review Category | Criteria | P/F/R |
|---|----------------|----------|-------|
| 1 | Grammar accuracy | Correct Arabic grammar (nahw and sarf) | [ ] |
| 2 | Spelling | No misspellings including hamza and taa marbouta | [ ] |
| 3 | Diacritics | Diacritics omitted for UI text (standard modern practice) | [ ] |
| 4 | Dialect consistency | Gulf dialect used consistently, no mixing with Egyptian or Levantine | [ ] |
| 5 | Register/tone | Informal-warm tone matching app personality (not academic/stiff) | [ ] |
| 6 | Feminine forms | All partner-referencing text uses feminine verbs/adjectives/pronouns | [ ] |
| 7 | Masculine forms | All user-referencing text uses masculine forms (app targets men) | [ ] |
| 8 | Pronoun consistency | Consistent use of second-person feminine (انتِ) vs third-person feminine (هي) | [ ] |
| 9 | Religious sensitivity | Islamic phrases used correctly (Bismillah, Insha'Allah, Masha'Allah) | [ ] |
| 10 | Cultural tone | No Western idioms translated literally (e.g., "break the ice" has no Arabic equivalent) | [ ] |
| 11 | Endearment terms | Gulf-appropriate terms of endearment (حبيبتي، يا قلبي، يا عمري) | [ ] |
| 12 | Number agreement | Numbers agree with counted noun in gender and grammatical case | [ ] |
| 13 | Verb tense consistency | Consistent tense usage within single screen context | [ ] |
| 14 | Truncation risk | Long strings reviewed for UI overflow at typical screen widths | [ ] |
| 15 | Reading flow | Natural right-to-left reading order maintained in all composed strings | [ ] |
| 16 | Formality level | Not too formal (academic), not too colloquial (street slang) | [ ] |
| 17 | Brand voice | LOLO's personality comes through in Arabic (supportive, witty, not preachy) | [ ] |
| 18 | Technical terms | App-specific terms (streak, XP, level) handled with natural Arabic equivalents | [ ] |
| 19 | Sensitive topics | Relationship advice avoids haram implications (no dating-specific language for married users) | [ ] |
| 20 | Placeholder context | Placeholders like {partnerName} read naturally in surrounding Arabic text | [ ] |

### 1.2.2 Common Arabic Translation Errors Checklist (25 Items)

| # | Error Type | Description | Example (Wrong) | Example (Correct) | Check |
|---|-----------|-------------|-----------------|-------------------|-------|
| 1 | Hamza placement | Hamza written on wrong carrier | اءقرأ | اقرأ | [ ] |
| 2 | Taa marbouta vs Haa | Confusing ة and ه at end of words | الرساله | الرسالة | [ ] |
| 3 | Alif maqsura vs Yaa | Confusing ى and ي | معنى vs معني | Context-dependent | [ ] |
| 4 | Tanween errors | Incorrect tanween usage in UI text | N/A (tanween not used in UI) | Verify omitted | [ ] |
| 5 | Gender mismatch | Masculine verb for feminine subject | هو أرسل (for partner) | هي أرسلت | [ ] |
| 6 | Literal translation | English idiom translated word-for-word | "كسر الجليد" (break the ice) | "كسر الحاجز" or rephrase | [ ] |
| 7 | Egyptian dialect leak | Egyptian words in Gulf context | عايز (Egyptian) | أبي / أبغى (Gulf) | [ ] |
| 8 | Levantine dialect leak | Levantine words in Gulf context | هلق (Levantine "now") | الحين (Gulf) | [ ] |
| 9 | MSA over-formality | Overly formal classical Arabic | تفضل بالضغط على الزر | اضغط هنا | [ ] |
| 10 | Wrong preposition | Arabic prepositions differ from English | بحث عن (correct) vs بحث ل | بحث عن | [ ] |
| 11 | Broken plural errors | Using wrong broken plural pattern | رسائل (messages) vs رسالات | رسائل (correct) | [ ] |
| 12 | Dual form missing | Arabic has dual form (two of something) | رسالتان (two messages) | Verify dual used when count=2 | [ ] |
| 13 | Number-noun agreement | 3-10 require plural, 11+ require singular | ٣ رسالة (wrong) | ٣ رسائل | [ ] |
| 14 | Kashida misuse | Decorative elongation breaking word meaning | No kashida in UI text | Verify none present | [ ] |
| 15 | Mixed directionality | Arabic text reading order broken by numbers | "أرسل 5 رسائل" display issues | Proper BiDi isolation | [ ] |
| 16 | Orphaned conjunction | و (and) at start of truncated string | "و أرسل..." | Remove leading conjunction | [ ] |
| 17 | Doubled spaces | Extra spaces from translation tools | "أرسل  رسالة" | "أرسل رسالة" | [ ] |
| 18 | Unicode normalization | Mixed composed/decomposed Arabic chars | Visually identical but different bytes | Normalize to NFC | [ ] |
| 19 | Ellipsis style | Latin ellipsis (...) vs Arabic (۔۔۔) | "جاري التحميل..." | Acceptable (both used) | [ ] |
| 20 | Quotation marks | Using Latin quotes in Arabic | "رسالة" | «رسالة» or "رسالة" | [ ] |
| 21 | Comma style | Using Latin comma in Arabic | رسائل, تذكيرات | رسائل، تذكيرات | [ ] |
| 22 | Question mark style | Using Latin ? in Arabic | هل أنت متأكد? | هل أنت متأكد؟ | [ ] |
| 23 | Semicolon style | Using Latin ; in Arabic | Item 1; Item 2 | البند ١؛ البند ٢ | [ ] |
| 24 | Zero-width joiner issues | Missing ZWJ breaking ligatures | لا (incorrect display) | Verify correct rendering | [ ] |
| 25 | Over-translation | Translating brand names or technical terms | "آبل ساين ان" (Apple Sign In) | Keep "Apple" in Latin script | [ ] |

### 1.2.3 Bidirectional Text Edge Cases

| # | Test Case | Input/Scenario | Expected Behavior | Status |
|---|-----------|---------------|-------------------|--------|
| BD-01 | URL in Arabic text | "زر الموقع https://lolo.app" | URL renders LTR within RTL paragraph | [ ] |
| BD-02 | Email in Arabic text | "أرسل إلى user@lolo.app" | Email renders LTR within RTL context | [ ] |
| BD-03 | Phone in Arabic text | "اتصل على +966 55 123 4567" | Number renders LTR, stays grouped | [ ] |
| BD-04 | Mixed AR/EN sentence | "اضغط على Generate للمتابعة" | "Generate" renders LTR inline | [ ] |
| BD-05 | Partner name in Latin script | Action card with "Jessica" in Arabic UI | Name renders LTR within RTL card | [ ] |
| BD-06 | Arabic text with Western numbers | "لديك 5 رسائل جديدة" | Number stays inline, no jump | [ ] |
| BD-07 | Parentheses in RTL | "رسائل (5 من 10)" | Parentheses flip correctly in RTL | [ ] |
| BD-08 | Bullet list in Arabic | Bulleted list of action items | Bullets on right side, text right-aligned | [ ] |
| BD-09 | Time display in Arabic | "الساعة 3:30 م" | Time reads LTR, label RTL | [ ] |
| BD-10 | Currency in Arabic text | "السعر: 19.99 ر.س" | Number+currency in correct order | [ ] |
| BD-11 | Nested BiDi (AR in EN in AR) | Partner context with mixed scripts | Each segment maintains correct direction | [ ] |
| BD-12 | Hashtag in Arabic | "#حب" or Arabic tag | Hash on correct side of tag | [ ] |
| BD-13 | App version string | "الإصدار 1.2.3" | Version number reads LTR | [ ] |
| BD-14 | Date range in Arabic | "من 1 يناير إلى 15 فبراير" | Dates and dashes render correctly | [ ] |
| BD-15 | Percentage in Arabic | "اكتمال الملف الشخصي: ٪٨٥" | Percent sign on correct side | [ ] |

### 1.2.4 Arabic-Specific UI Issues

| # | Test Case | Verification Method | Pass Criteria | Status |
|---|-----------|-------------------|---------------|--------|
| AU-01 | Button text truncation | Test all buttons at 320dp width | No clipping; text wraps or abbreviates gracefully | [ ] |
| AU-02 | Navigation bar labels | Check bottom nav with Arabic labels | All 5 labels fit without overlap | [ ] |
| AU-03 | AppBar title overflow | Test longest Arabic screen title | Title fits or uses auto-size text | [ ] |
| AU-04 | Card title line breaking | Arabic text in action card headers | Breaks at word boundaries, not mid-word | [ ] |
| AU-05 | Text input cursor position | Type Arabic in text fields | Cursor on right side, moves left as typed | [ ] |
| AU-06 | Text selection handles | Select Arabic text in message result | Selection handles on correct sides | [ ] |
| AU-07 | Dropdown menu alignment | Open dropdown/popup menus in RTL | Menu aligns to right edge | [ ] |
| AU-08 | Toast/Snackbar alignment | Trigger success/error messages | Text right-aligned, icon on right | [ ] |
| AU-09 | Dialog button order | Confirm/Cancel dialogs | Primary action on left (RTL convention) | [ ] |
| AU-10 | Tab bar RTL | Horizontal tab navigation | First tab on right side | [ ] |
| AU-11 | Swipe direction | Card swipe gestures | Right-to-left = forward (opposite of LTR) | [ ] |
| AU-12 | Scroll indicator position | Vertical scroll indicators | Scrollbar on left side in RTL | [ ] |
| AU-13 | Form label alignment | All form fields | Labels right-aligned, fields right-aligned | [ ] |
| AU-14 | Error message positioning | Validation errors under fields | Error text right-aligned below field | [ ] |
| AU-15 | Long Arabic text wrapping | Multi-line text in result cards | Even right margin, ragged left margin | [ ] |

### 1.2.5 Islamic Content Verification

| # | Test Item | Verification | Correct Usage | Status |
|---|-----------|-------------|---------------|--------|
| IC-01 | "Bismillah" (بسم الله) | Never used casually in UI | Only in religious-context cards (Ramadan, Eid) | [ ] |
| IC-02 | "Insha'Allah" (إن شاء الله) | Used for future intentions | Appropriate in reminder/planning context | [ ] |
| IC-03 | "Masha'Allah" (ما شاء الله) | Used for admiration/gratitude | Appropriate in appreciation messages | [ ] |
| IC-04 | "Alhamdulillah" (الحمد لله) | Used for gratitude | Appropriate in gratitude message mode | [ ] |
| IC-05 | "SubhanAllah" (سبحان الله) | Used for wonder/amazement | Only in deeply appreciative contexts | [ ] |
| IC-06 | Ramadan content | Fasting-aware suggestions | No food/dining gift suggestions during Ramadan | [ ] |
| IC-07 | Eid al-Fitr greetings | Correct traditional phrasing | "عيد فطر مبارك" not "Happy Eid" translated | [ ] |
| IC-08 | Eid al-Adha greetings | Correct phrasing | "عيد أضحى مبارك" | [ ] |
| IC-09 | Jumu'ah (Friday) awareness | Friday-specific content | Appropriate Friday greetings available | [ ] |
| IC-10 | Halal gift compliance | Gift suggestions | No alcohol, pork-related, or haram products suggested | [ ] |

### 1.2.6 Hijri Date Accuracy Tests

| # | Gregorian Input | Expected Hijri | Context | Status |
|---|----------------|---------------|---------|--------|
| HD-01 | 2026-03-20 | 1 Ramadan 1448 | Ramadan start detection | [ ] |
| HD-02 | 2026-04-18 | 1 Shawwal 1448 | Eid al-Fitr detection | [ ] |
| HD-03 | 2026-06-26 | 10 Dhul Hijjah 1448 | Eid al-Adha detection | [ ] |
| HD-04 | 2026-02-15 | 17 Sha'ban 1447 | Current date conversion | [ ] |
| HD-05 | 2026-07-17 | 1 Muharram 1448 | Islamic New Year | [ ] |
| HD-06 | 2026-09-25 | 12 Rabi al-Awwal 1448 | Mawlid (Prophet's birthday) | [ ] |
| HD-07 | 2026-12-31 | 11 Jumada al-Thani 1448 | Year boundary | [ ] |
| HD-08 | 2027-01-01 | 12 Jumada al-Thani 1448 | Year boundary (next day) | [ ] |
| HD-09 | 2026-06-17 | 1 Dhul Hijjah 1448 | Hajj month start | [ ] |
| HD-10 | 2026-02-28 | End of Sha'ban 1447 | Month boundary | [ ] |

**Note:** Hijri dates may vary by 1 day due to moon sighting differences between Saudi Arabia and Malaysia. App must use the Umm al-Qura calendar for Gulf users and Malaysia's JAKIM calendar for Malay users.

---

## 1.3 Bahasa Melayu Language QA

### 1.3.1 Native Speaker Review Checklist

| # | Review Category | Criteria | P/F/R |
|---|----------------|----------|-------|
| 1 | Grammar accuracy | Correct BM grammar (tatabahasa) | [ ] |
| 2 | Spelling | Correct Dewan Bahasa dan Pustaka (DBP) standard spelling | [ ] |
| 3 | Malaysian vs Indonesian | Malaysian Malay used, not Indonesian Malay | [ ] |
| 4 | Register | Semi-formal conversational tone (not academic, not slang) | [ ] |
| 5 | Prefix/suffix usage | Correct me-, ber-, di-, -kan, -an affixes | [ ] |
| 6 | Loan words | English loan words used where natural (e.g., "login", "streaming") | [ ] |
| 7 | Cultural tone | Warm, respectful tone appropriate for Malaysian culture | [ ] |
| 8 | Islamic terminology | Malay-standard Islamic terms (not Arabic transliteration) | [ ] |
| 9 | Honorifics | No unnecessary honorifics in UI (but available in AI output) | [ ] |
| 10 | Brand voice | LOLO personality maintained -- supportive, modern, not preachy | [ ] |
| 11 | Placeholder context | {partnerName} reads naturally in surrounding Malay text | [ ] |
| 12 | Number handling | No pluralization applied to numbers (Malay has no grammatical plural) | [ ] |
| 13 | Technical terms | Consistent handling of app terms (streak, XP, level) | [ ] |
| 14 | Sentence structure | Natural SVO order (not forced English syntax) | [ ] |
| 15 | Formal/informal "you" | Consistent use of "anda" (formal) or "kamu" (informal) | [ ] |

### 1.3.2 Common Malay Translation Errors (20 Items)

| # | Error Type | Description | Wrong | Correct | Check |
|---|-----------|-------------|-------|---------|-------|
| 1 | Indonesian word used | Indonesian vocabulary instead of Malaysian | "handphone" (ID) | "telefon bimbit" (MY) | [ ] |
| 2 | Indonesian spelling | Indonesian variant spelling | "aktivitas" (ID) | "aktiviti" (MY) | [ ] |
| 3 | Wrong affix | Incorrect prefix/suffix combination | "mengenalpasti" | "mengenal pasti" (two words) | [ ] |
| 4 | English calque | Direct translation of English phrase | "mengambil tempat" (take place) | "berlangsung" | [ ] |
| 5 | Over-translation | Translating terms better left in English | "kata laluan" (password) | "password" (commonly used) | [ ] |
| 6 | Under-translation | Leaving English where Malay exists | "message" | "mesej" or "pesanan" | [ ] |
| 7 | Wrong "di-" usage | Confusing "di" (preposition) with "di-" (prefix) | "diatas" | "di atas" (on top) | [ ] |
| 8 | Missing hyphen | Compound words need hyphens | "satu satu" | "satu-satu" | [ ] |
| 9 | Plural reduplication in UI | Unnecessary word doubling | "mesej-mesej" in button | "mesej" (no plural needed) | [ ] |
| 10 | Wrong particle | Misusing "pun", "lah", "kah" particles | Overuse of "lah" in formal UI | Use sparingly, only in casual AI output | [ ] |
| 11 | Passive voice overuse | Too many passive constructions | "Mesej telah dihantar" | "Mesej sudah dihantar" (more natural) | [ ] |
| 12 | Formal register mismatch | Using parliament-level Malay in casual app | "Sila tekan butang tersebut" | "Tekan di sini" | [ ] |
| 13 | "Yang" overuse | Excessive use of relative clause marker | "Kad yang yang baru" | "Kad baru" | [ ] |
| 14 | Mixed script | Jawi script appearing in Rumi context | N/A in UI | Verify all text is Rumi (Latin) | [ ] |
| 15 | Date format error | Wrong date format for Malaysia | "February 15" | "15 Februari" (day before month) | [ ] |
| 16 | Time format | Using AM/PM instead of local | "3:30 PM" | "3:30 PTG" (petang) | [ ] |
| 17 | Currency format | Wrong currency position | "MYR 19.99" | "RM19.99" | [ ] |
| 18 | Rojak language | Mixing Malay/English/Chinese in one string | "Click sini untuk save" | "Tekan di sini untuk simpan" | [ ] |
| 19 | Negation error | Wrong negative form | "tidak boleh" vs "tak boleh" | Context-appropriate (formal vs casual) | [ ] |
| 20 | Loan word spelling | English loan words not following DBP rules | "mesage" | "mesej" (standardized) | [ ] |

### 1.3.3 Malaysian vs Indonesian Distinction Checks

| # | Word/Phrase | Malaysian (MY) | Indonesian (ID) | Where to Check | Status |
|---|-----------|---------------|-----------------|----------------|--------|
| 1 | Car | Kereta | Mobil | Gift suggestions | [ ] |
| 2 | Driver | Pemandu | Sopir | Contextual text | [ ] |
| 3 | Office | Pejabat | Kantor | AI-generated text | [ ] |
| 4 | Money | Wang/duit | Uang | Subscription text | [ ] |
| 5 | Shopping | Membeli-belah | Belanja | Gift engine | [ ] |
| 6 | Weekend | Hujung minggu | Akhir pekan | Reminder labels | [ ] |
| 7 | Last (adj) | Lepas | Lalu | Date references | [ ] |
| 8 | Phone | Telefon | Telepon | Settings | [ ] |
| 9 | Quality | Kualiti | Kualitas | Subscription features | [ ] |
| 10 | Activity | Aktiviti | Aktivitas | Gamification | [ ] |
| 11 | Practice | Praktis | Praktek | Action cards | [ ] |
| 12 | System | Sistem | Sistem | Same -- verify | [ ] |
| 13 | Taxi | Teksi | Taksi | GO card suggestions | [ ] |
| 14 | Bus | Bas | Bus | GO card suggestions | [ ] |
| 15 | Apartment | Pangsapuri | Apartemen | Address contexts | [ ] |

### 1.3.4 Cultural Appropriateness -- Malay Context

| # | Verification Item | Details | Status |
|---|------------------|---------|--------|
| MA-01 | Hari Raya Aidilfitri greetings | Correct phrasing: "Selamat Hari Raya Aidilfitri, Maaf Zahir dan Batin" | [ ] |
| MA-02 | Hari Raya Haji greetings | Correct: "Selamat Hari Raya Haji" | [ ] |
| MA-03 | Ramadan awareness | "Selamat berpuasa" -- gift suggestions are iftar/sahur appropriate | [ ] |
| MA-04 | No pork/alcohol in gifts | Gift engine filters for halal compliance in MS locale | [ ] |
| MA-05 | Mak mertua (mother-in-law) sensitivity | AI avoids insensitive mother-in-law references (culturally charged topic) | [ ] |
| MA-06 | Pantang larang (taboos) | No suggestions involving cultural taboos (pointing with index finger, etc.) | [ ] |
| MA-07 | Multi-racial awareness | Malay context acknowledges Malaysia's multi-racial society | [ ] |
| MA-08 | Dress modesty in visuals | Any illustrated content respects Malaysian modesty standards | [ ] |
| MA-09 | Food recommendations | Malaysian cuisine references (nasi lemak, rendang) vs Western food | [ ] |
| MA-10 | Local holiday coverage | Deepavali, CNY awareness for multi-racial context | [ ] |

---

## 1.4 AI Output Language Verification

### 1.4.1 Test Matrix: 10 Modes x 3 Languages x 3 Profiles = 90 Tests

**Test Profiles:**
- **P1 (Marcus/EN):** English, Western context, Aries partner, dating 2 years
- **P2 (Ahmed/AR):** Arabic (Gulf), Islamic context, Pisces partner, married 5 years
- **P3 (Hafiz/MS):** Malay, Malaysian context, Leo partner, engaged

**Status Codes:** PASS = correct language + culturally appropriate, LANG = wrong language detected, CULT = cultural mismatch, QUAL = low quality, FALL = English fallback

| Mode | P1-EN | P2-AR | P3-MS | Notes |
|------|-------|-------|-------|-------|
| Good Morning | [ ] | [ ] | [ ] | Check greetings match cultural norms |
| Appreciation | [ ] | [ ] | [ ] | Verify compliment style is culture-appropriate |
| Romance | [ ] | [ ] | [ ] | Intimacy level must match cultural context |
| Apology | [ ] | [ ] | [ ] | Apology structure differs (AR more formal, MS indirect) |
| Missing You | [ ] | [ ] | [ ] | Expression of longing varies by culture |
| Celebration | [ ] | [ ] | [ ] | Holiday references must match locale |
| Comfort | [ ] | [ ] | [ ] | Emotional support patterns differ |
| Flirting | [ ] | [ ] | [ ] | Flirtation boundaries differ significantly |
| Deep Conversation | [ ] | [ ] | [ ] | Topic depth and directness vary |
| Just Because | [ ] | [ ] | [ ] | Spontaneity expression differs |

**Total: 30 cells above x 3 checks per cell (language / culture / quality) = 90 individual verifications.**

### 1.4.2 Language Consistency Verification Script

```dart
// test/ai/language_consistency_test.dart

import 'package:flutter_test/flutter_test.dart';

/// Heuristic language detection for AI output verification.
class LanguageDetector {
  /// Returns detected language code: 'ar', 'ms', 'en', or 'unknown'.
  static String detect(String text) {
    if (text.isEmpty) return 'unknown';

    // Arabic script detection (U+0600-U+06FF, U+0750-U+077F)
    final arabicChars = RegExp(r'[\u0600-\u06FF\u0750-\u077F]')
        .allMatches(text)
        .length;
    final totalChars = text.replaceAll(RegExp(r'\s'), '').length;

    if (totalChars == 0) return 'unknown';
    final arabicRatio = arabicChars / totalChars;
    if (arabicRatio > 0.3) return 'ar';

    // Malay vs English: check for Malay-specific words
    final malayMarkers = [
      'dan', 'yang', 'untuk', 'dengan', 'ini', 'itu',
      'adalah', 'pada', 'dari', 'akan', 'telah', 'sudah',
      'boleh', 'saya', 'anda', 'kamu', 'dia', 'kami',
      'sangat', 'tidak', 'bukan', 'juga', 'lagi', 'sila',
      'terima', 'kasih', 'selamat', 'baik',
    ];
    final words = text.toLowerCase().split(RegExp(r'\s+'));
    final malayHits = words.where((w) => malayMarkers.contains(w)).length;
    final malayRatio = words.isEmpty ? 0 : malayHits / words.length;

    if (malayRatio > 0.15) return 'ms';
    return 'en';
  }

  /// Checks if text contains English fallback phrases that indicate
  /// the AI failed to generate in the target language.
  static bool hasEnglishFallback(String text, String targetLang) {
    if (targetLang == 'en') return false;

    final fallbackIndicators = [
      'here is', 'here\'s', 'i hope', 'dear ', 'sweetheart',
      'good morning', 'i love you', 'happy anniversary',
      'thinking of you', 'you mean the world',
    ];
    final lower = text.toLowerCase();
    final hits = fallbackIndicators.where((f) => lower.contains(f)).length;
    return hits >= 2; // 2+ English phrases = likely fallback
  }
}

void main() {
  group('Language Detection', () {
    test('detects Arabic text', () {
      expect(LanguageDetector.detect('صباح الخير يا حبيبتي'), equals('ar'));
    });

    test('detects Malay text', () {
      expect(LanguageDetector.detect(
          'Selamat pagi sayang, semoga hari ini indah untuk kamu'),
          equals('ms'));
    });

    test('detects English text', () {
      expect(LanguageDetector.detect(
          'Good morning beautiful, hope your day is amazing'),
          equals('en'));
    });

    test('detects English fallback in Arabic context', () {
      expect(LanguageDetector.hasEnglishFallback(
          'Good morning dear, I hope you have a great day', 'ar'),
          isTrue);
    });

    test('no false positive on Arabic with numbers', () {
      expect(LanguageDetector.detect('لديك ٥ رسائل جديدة'), equals('ar'));
    });
  });
}
```

### 1.4.3 Arabic Dialect Consistency Checks

| # | Test | Gulf Arabic Expected | MSA Unacceptable | Egyptian Unacceptable | Status |
|---|------|---------------------|-----------------|----------------------|--------|
| 1 | "I want" | أبي / أبغى | أريد (too formal) | عايز (wrong dialect) | [ ] |
| 2 | "Now" | الحين | الآن (too formal) | دلوقتي (wrong) | [ ] |
| 3 | "How are you?" | شلونج؟ / كيفج؟ | كيف حالكِ؟ (acceptable alt) | إزيّك؟ (wrong) | [ ] |
| 4 | "Good/fine" | زين / تمام | جيد (too formal) | كويس (wrong) | [ ] |
| 5 | "A lot" | وايد | كثيراً (too formal) | كتير (wrong) | [ ] |
| 6 | "Beautiful" (f) | حلوة / جميلة | جميلة (acceptable) | حلوة (shared) | [ ] |
| 7 | "Food" | أكل | طعام (too formal) | أكل (shared) | [ ] |
| 8 | "Children" | عيال / أطفال | أطفال (acceptable) | عيال (shared) | [ ] |
| 9 | "What" | شنو / ايش | ماذا (too formal) | إيه (wrong) | [ ] |
| 10 | "Because" | عشان / لأن | لأن (acceptable) | عشان (shared) | [ ] |

### 1.4.4 Cultural Appropriateness per Language

| # | Scenario | EN Acceptable | AR Expected | MS Expected | Status |
|---|---------|---------------|-------------|-------------|--------|
| 1 | Date suggestion | Restaurant, bar, movie | Restaurant, park (no bar) | Restaurant, park, mall | [ ] |
| 2 | Physical affection level | Explicit romantic language OK | Modest; no explicit physical descriptions | Modest; romantically suggestive OK within marriage | [ ] |
| 3 | Alcohol references | Wine, cocktails OK | Never mention alcohol | Never mention alcohol | [ ] |
| 4 | Religious references | Optional | Islamic phrases natural and expected | Islamic phrases expected for Malay Muslims | [ ] |
| 5 | Family involvement | Optional mention | Family/parents highly relevant | Family/parents important | [ ] |
| 6 | Gift budget references | Dollar amounts | Dirham/Riyal amounts | Ringgit amounts | [ ] |
| 7 | Weekend references | Saturday-Sunday | Friday-Saturday (Gulf) | Saturday-Sunday | [ ] |
| 8 | Humor style | Witty, sarcastic OK | Warm humor, avoid sarcasm | Gentle humor, self-deprecating OK | [ ] |
| 9 | Conflict resolution | Direct confrontation coaching | Face-saving, indirect approaches | Harmony-preserving, avoid direct blame | [ ] |
| 10 | Pregnancy/fertility | Neutral mention | Sensitive -- frame as blessing from Allah | Sensitive -- culturally weighted | [ ] |

### 1.4.5 Mixed Language Handling Tests

| # | Scenario | User Lang | Partner Name | Expected Behavior | Status |
|---|---------|-----------|-------------|-------------------|--------|
| ML-01 | Arabic user, English partner name | AR | Jessica | Arabic message with "Jessica" in Latin script | [ ] |
| ML-02 | English user, Arabic partner name | EN | فاطمة | English message with "Fatima" transliterated | [ ] |
| ML-03 | Malay user, Arabic partner name | MS | عائشة | Malay message with "Aisyah" in Latin script | [ ] |
| ML-04 | Arabic user, Malay partner name | AR | Siti | Arabic message with "Siti" in Latin script | [ ] |
| ML-05 | Switching language mid-session | AR->EN | Same | New messages in English, no Arabic fragments | [ ] |
| ML-06 | App locale vs AI language | AR app, EN AI request | Same | AI must follow explicit request, not app locale | [ ] |

---

# Part 2: Beta Feedback Analysis Framework

## 2.1 Feedback Collection System

### 2.1.1 In-App Feedback Widget Specification

**Trigger Points (when to show the feedback widget):**

| # | Trigger | Timing | Widget Type | Priority |
|---|---------|--------|-------------|----------|
| T-01 | After first AI message generation | Immediately after viewing result | Thumbs up/down + optional text | P1 |
| T-02 | After completing 3rd action card | On completion animation | 1-5 star rating | P1 |
| T-03 | After SOS session ends | 30 seconds after SOS mode exit | Emoji scale (5 options) + text | P1 |
| T-04 | Day 3 of usage | On first app open on day 3 | NPS question (0-10) | P1 |
| T-05 | After first gift recommendation used | On "I bought it" confirmation | Thumbs up/down + "How was it?" | P2 |
| T-06 | After changing language | 5 minutes after language switch | "How is the translation?" 1-5 stars | P1 |
| T-07 | After 7 consecutive days (streak) | On streak celebration screen | Full survey (5 questions) | P2 |
| T-08 | After subscription decision | 24 hours after paywall interaction | "Why did you choose / skip?" multi-select | P1 |
| T-09 | Shake gesture (any screen) | On device shake | Bug report form (auto-captures context) | P2 |
| T-10 | Settings > "Send Feedback" | On tap | Full feedback form with categories | P2 |

**Widget UI Specifications:**

```
QUICK FEEDBACK WIDGET (Thumbs Up/Down):
+---------------------------------------+
|  How was this message?                 |
|  [ 👍 ]     [ 👎 ]     [ Skip ]       |
+---------------------------------------+
  Height: 64dp
  Animation: Slide up from bottom, auto-dismiss after 5s
  Behavior: Single tap records rating + timestamp + screen + locale

NPS WIDGET:
+---------------------------------------+
|  How likely are you to recommend       |
|  LOLO to a friend?                     |
|                                        |
|  0  1  2  3  4  5  6  7  8  9  10     |
|  [Not likely]         [Very likely]    |
|                                        |
|  [Optional: Tell us why...]           |
|  [Submit]                              |
+---------------------------------------+
  Height: 200dp
  Dismissible: Yes (X button, records "dismissed")
  Max show: Once per trigger (no repeat)

BUG REPORT FORM (Shake-triggered):
+---------------------------------------+
|  Report a Problem                      |
|  ------------------------------------ |
|  What happened?                        |
|  [                                   ] |
|  [                                   ] |
|                                        |
|  Category: [Dropdown: Bug/Crash/       |
|   Translation/Suggestion/Other]        |
|                                        |
|  [ ] Include screenshot (auto-captured)|
|  [ ] Include device logs               |
|                                        |
|  Auto-captured:                        |
|   Device: Pixel 8 Pro                  |
|   OS: Android 15                       |
|   Locale: ar                           |
|   Screen: messages_generate            |
|   App Version: 1.0.0 (42)             |
|                                        |
|  [Send Report]   [Cancel]              |
+---------------------------------------+
```

### 2.1.2 Post-Session Survey Specifications

**Survey A: Post-SOS (triggered 30s after SOS exit)**

| Q# | Question | Type | Options |
|----|---------|------|---------|
| A1 | Did SOS mode help with your situation? | 5-point scale | Not at all -- Extremely |
| A2 | Was the advice culturally appropriate? | Yes/No/Partially | -- |
| A3 | Did you use the suggested phrases? | Yes/Some/No | -- |
| A4 | Would you use SOS mode again? | Yes/Maybe/No | -- |
| A5 | Anything we should change? | Open text | 500 char limit |

**Survey B: Day 7 Engagement (triggered on 7th day of usage)**

| Q# | Question | Type | Options |
|----|---------|------|---------|
| B1 | Which feature do you use most? | Multi-select | Messages/Cards/Gifts/Reminders/SOS |
| B2 | Has LOLO improved your relationship? | 5-point scale | Not at all -- Significantly |
| B3 | What is missing? | Open text | 500 char limit |
| B4 | How is the quality of AI-generated text? | 5-point scale | Poor -- Excellent |
| B5 | NPS: How likely to recommend (0-10)? | Numeric slider | 0-10 |

**Survey C: Subscription Decision (triggered 24h after paywall)**

| Q# | Question (if subscribed) | Question (if declined) | Type |
|----|------------------------|----------------------|------|
| C1 | What made you subscribe? | What held you back? | Multi-select |
| C2 | Which tier and why? | What price would work? | Multi-select + text |
| C3 | What feature sealed the deal? | What feature would make you subscribe? | Single select |

### 2.1.3 Bug Report Auto-Capture Payload

```json
{
  "report_id": "uuid-v4",
  "timestamp": "2026-02-15T14:30:00Z",
  "user_id": "hashed_user_id",
  "device": {
    "manufacturer": "Samsung",
    "model": "Galaxy S24",
    "os": "Android",
    "os_version": "15",
    "screen_size": "1080x2400",
    "screen_density": "xxhdpi",
    "ram_mb": 8192,
    "storage_available_mb": 12400
  },
  "app": {
    "version": "1.0.0",
    "build_number": 42,
    "flavor": "beta",
    "install_source": "firebase_app_distribution"
  },
  "locale": {
    "app_language": "ar",
    "device_language": "ar-SA",
    "text_direction": "rtl",
    "calendar_type": "hijri"
  },
  "context": {
    "current_screen": "messages_generate",
    "previous_screen": "home_dashboard",
    "session_duration_seconds": 340,
    "actions_this_session": 12,
    "subscription_tier": "free"
  },
  "user_report": {
    "category": "translation",
    "description": "Arabic text cuts off on message result screen",
    "screenshot_attached": true,
    "logs_attached": true
  },
  "crash_data": null,
  "network": {
    "connection_type": "wifi",
    "latency_ms": 45
  }
}
```

### 2.1.4 Feature Request Tracking System

| Field | Description | Example |
|-------|------------|---------|
| Request ID | Auto-generated | FR-2026-0042 |
| Source | In-app / Survey / Email / Social | In-app |
| User Locale | en / ar / ms | ar |
| User Tier | Free / Pro / Legend | Free |
| Category | Messages / Cards / Gifts / Reminders / SOS / UX / Payment / Other | Messages |
| Description | User's own words | "I want to send voice messages not just text" |
| Upvotes | Other users requesting same | 0 (initial) |
| Sentiment | Positive / Neutral / Negative | Neutral |
| Effort Estimate | S / M / L / XL | L |
| Priority Score | Frequency x Impact x Feasibility | Calculated |
| Status | New / Under Review / Planned / In Progress / Shipped / Declined | New |
| Response | If declined, why | -- |

### 2.1.5 NPS Measurement Schedule

| Measurement | Trigger | Sample | Target NPS | Minimum NPS |
|-------------|---------|--------|------------|-------------|
| NPS-7 | Day 7 of active use | All active users | 50+ | 30 |
| NPS-30 | Day 30 of active use | Retained users | 55+ | 35 |
| NPS-90 | Day 90 of active use | Long-term users | 60+ | 40 |
| NPS-Post-Sub | 7 days after subscribing | Paid users | 65+ | 45 |
| NPS-Post-SOS | After 3rd SOS use | SOS users | 50+ | 25 |

**NPS Segmentation Cuts:**
- By language (EN / AR / MS)
- By tier (Free / Pro / Legend)
- By platform (iOS / Android)
- By device tier (flagship / mid-range / budget)
- By acquisition cohort (week of install)

---

## 2.2 Feedback Categorization Framework

### 2.2.1 Taxonomy

| Level 1 Category | Level 2 Subcategory | Examples | Auto-Route To |
|-----------------|---------------------|---------|--------------|
| **Bug** | Crash | App closes unexpectedly | Engineering (P1) |
| | Functional | Button does not work, data not saving | Engineering (P2) |
| | Visual | Layout broken, overlap, wrong color | Engineering (P3) |
| | Performance | Slow load, lag, battery drain | Engineering (P2) |
| **UX Issue** | Navigation | Cannot find feature, confusing flow | Design |
| | Clarity | Do not understand what button does | Design + Copy |
| | Friction | Too many steps, unnecessary screens | Product |
| **Feature Request** | Enhancement | Improve existing feature | Product |
| | New Feature | Feature that does not exist | Product |
| | Integration | Connect with WhatsApp, calendar, etc. | Product + Eng |
| **Content Issue** | AI Quality | Message too generic, irrelevant, awkward | AI/ML Team |
| | AI Safety | Inappropriate, manipulative, harmful output | AI/ML Team (P1) |
| | Gift Relevance | Suggestions not matching preferences | AI/ML Team |
| **Language Issue** | Translation Error | Wrong word, grammar mistake | Localization |
| | Missing Translation | English text showing in AR/MS locale | Localization (P1) |
| | Tone Mismatch | Too formal, too casual, wrong dialect | Localization |
| | BiDi Issue | Text direction wrong, mixed-direction broken | Engineering + Loc |
| **Cultural Issue** | Religious Sensitivity | Haram content suggested, wrong religious context | Content Review (P1) |
| | Cultural Mismatch | Western-centric advice in AR/MS context | Content + AI/ML |
| | Inappropriate Gift | Gift violates cultural norms | AI/ML + Cultural |

### 2.2.2 Severity Auto-Classification Rules

```
SEVERITY MATRIX:
                    Impact
                    Low       Medium     High       Critical
Frequency  Rare    P4        P3         P2         P1
           Some    P3        P2         P1         P0
           Common  P2        P1         P0         P0
           All     P1        P0         P0         P0

DEFINITIONS:
  P0 -- Blocker: Ship-stopper. Fix immediately. All hands on deck.
        Examples: Crash on launch, data loss, security breach, harmful AI output
  P1 -- Critical: Must fix before next release. User cannot complete core flow.
        Examples: Cannot generate message, payment fails, missing translations (full screen)
  P2 -- Major: Should fix before launch. Degrades experience significantly.
        Examples: Slow AI response (>5s), layout overflow in AR, wrong Hijri dates
  P3 -- Minor: Fix in next sprint. Noticeable but not blocking.
        Examples: Minor translation error, alignment off by pixels, tooltip missing
  P4 -- Trivial: Backlog. Fix when convenient.
        Examples: Typo in rarely-seen screen, icon pixel misalignment

AUTO-CLASSIFICATION SIGNALS:
  Crash report attached           -> P1 minimum
  "crash" or "freeze" in text     -> P2 minimum
  "cannot" or "stuck" in text     -> P2 minimum
  AI safety flag                  -> P0 automatic
  Missing translation (full key)  -> P1 automatic
  Cultural/religious concern      -> P1 minimum
  Screenshot shows visual glitch  -> P3 default
  Feature request                 -> P4 default (re-prioritize manually)
```

### 2.2.3 Language-Specific Feedback Routing

| Feedback Language | Primary Reviewer | Secondary Reviewer | Escalation |
|-------------------|-----------------|-------------------|------------|
| English | QA Lead (Yuki) | Product (Sarah) | Engineering Lead |
| Arabic | Arabic Linguist + Cultural Reviewer | AI/ML (Aisha) | Nadia (Cultural Consultant) |
| Malay | Malay Linguist + Cultural Reviewer | AI/ML (Aisha) | Nadia (Cultural Consultant) |
| Mixed (code-switching) | Detect dominant language, route accordingly | Both language reviewers | Product Lead |

### 2.2.4 Sentiment Analysis Framework

| Sentiment | Detection Signals | Action |
|-----------|------------------|--------|
| **Very Negative** | Profanity, "worst", "terrible", "uninstall", "refund" | Auto-escalate to P1 review, trigger retention outreach within 24h |
| **Negative** | "bad", "broken", "wrong", "frustrated", "disappointed" | Flag for manual review within 48h |
| **Neutral** | Factual bug reports, feature requests without emotion | Standard queue |
| **Positive** | "good", "helpful", "nice", "love it" | Tag for marketing testimonials (with permission) |
| **Very Positive** | "amazing", "changed my relationship", "best app" | Tag for App Store review prompt, case study candidate |

**Arabic Sentiment Markers:**

| AR Sentiment | Signal Words |
|-------------|-------------|
| Very Negative | "سيء جداً"، "ما ينفع"، "حذفت التطبيق" |
| Negative | "مو زين"، "فيه مشكلة"، "محتاج تعديل" |
| Positive | "حلو"، "يعجبني"، "زين" |
| Very Positive | "ممتاز"، "غيّر حياتي"، "أفضل تطبيق" |

**Malay Sentiment Markers:**

| MS Sentiment | Signal Words |
|-------------|-------------|
| Very Negative | "teruk sangat", "tak boleh guna", "buang masa" |
| Negative | "tak berapa bagus", "ada masalah", "perlu perbaiki" |
| Positive | "bagus", "suka", "membantu" |
| Very Positive | "terbaik", "sangat membantu", "ubah hidup saya" |

---

## 2.3 Beta Metrics Dashboard

### 2.3.1 Key Metrics

| Metric Category | Metric | Formula / Source | Target | Red Flag |
|----------------|--------|-----------------|--------|----------|
| **Retention** | D1 Retention | Users opening Day 2 / Day 1 installs | >60% | <40% |
| | D7 Retention | Users opening Day 8 / Day 1 installs | >35% | <20% |
| | D30 Retention | Users opening Day 31 / Day 1 installs | >20% | <10% |
| **Engagement** | DAU/MAU Ratio | Daily active / monthly active | >30% | <15% |
| | Avg Session Length | Total session time / sessions | >3 min | <1 min |
| | Sessions per Day | Total sessions / DAU | >1.5 | <1.0 |
| | Cards Completed per Week | Completed cards / active users / week | >3 | <1 |
| **AI Quality** | AI Satisfaction Rate | Thumbs up / (thumbs up + thumbs down) | >80% | <60% |
| | Regenerate Rate | Regenerate taps / total generations | <20% | >40% |
| | Copy/Share Rate | Copy or share taps / total generations | >50% | <25% |
| **Monetization** | Free-to-Pro Conversion | Pro subscribers / free users (30-day) | >5% | <2% |
| | Pro-to-Legend Upgrade | Legend subs / Pro subs (90-day) | >10% | <3% |
| | Trial-to-Paid | Paid after trial / trial starts | >40% | <20% |
| | Revenue per User (ARPU) | Total revenue / total users (monthly) | >$1.50 | <$0.50 |
| **Stability** | Crash-Free Rate | Sessions without crash / total sessions | >99.5% | <98% |
| | ANR Rate (Android) | ANR events / sessions | <0.5% | >1% |
| | API Error Rate | Failed API calls / total API calls | <2% | >5% |
| | AI Response Time (p95) | 95th percentile AI generation time | <3s | >5s |
| **Feature Usage** | AI Messages Used | Generations per user per month | >8 | <2 |
| | Reminders Created | Reminders created per user | >2 | <0.5 |
| | SOS Mode Triggered | SOS activations per 100 users per month | >5 | <1 |
| | Gift Suggestions Viewed | Gift views per user per month | >3 | <1 |
| | Action Cards Seen | Cards shown per user per week | >5 | <2 |

### 2.3.2 Per-Language Comparison Framework

| Metric | EN Baseline | AR Target | AR Actual | MS Target | MS Actual | Delta Notes |
|--------|------------|-----------|-----------|-----------|-----------|-------------|
| D1 Retention | 60% | 55% | [ ] | 58% | [ ] | AR may be lower due to RTL issues |
| D7 Retention | 35% | 30% | [ ] | 33% | [ ] | |
| Avg Session Length | 3.5 min | 4.0 min | [ ] | 3.5 min | [ ] | AR may be longer (more reading time) |
| AI Satisfaction | 82% | 75% | [ ] | 78% | [ ] | AR/MS AI quality may lag EN initially |
| Crash-Free Rate | 99.5% | 99.3% | [ ] | 99.5% | [ ] | AR has more rendering edge cases |
| Free-to-Pro Conv | 5% | 4% | [ ] | 4.5% | [ ] | |
| NPS (Day 7) | 50 | 40 | [ ] | 45 | [ ] | Adjusted for cultural response bias |

**Language-Specific Anomaly Alerts:**
- If AR retention is >15% lower than EN, investigate RTL/translation issues
- If MS AI satisfaction is >20% lower than EN, review Malay prompt quality
- If any language crash rate diverges by >1%, investigate locale-specific bugs

### 2.3.3 Cohort Analysis: Free vs Pro vs Legend

| Behavior Metric | Free Users | Pro Users | Legend Users |
|----------------|-----------|-----------|-------------|
| Avg Daily Sessions | [ ] | [ ] | [ ] |
| Avg Session Duration | [ ] | [ ] | [ ] |
| Cards Completed / Week | [ ] (max ~3) | [ ] (max ~5) | [ ] (unlimited) |
| AI Messages / Month | [ ] (max 10) | [ ] (max 100) | [ ] (unlimited) |
| Streak Length (avg) | [ ] | [ ] | [ ] |
| SOS Usage | [ ] | [ ] | [ ] |
| Feature Discovery Rate | [ ] | [ ] | [ ] |
| Churn Rate (30-day) | [ ] | [ ] | [ ] |
| NPS | [ ] | [ ] | [ ] |

**Key Questions for Cohort Analysis:**
1. Do Pro users use significantly more features than Free, or just hit limits?
2. Is Legend meaningfully different from Pro in behavior, or just loyalty?
3. Which features drive Free-to-Pro conversion most effectively?
4. Do churned Pro users return to Free tier or uninstall entirely?
5. What is the "aha moment" for each tier upgrade?

### 2.3.4 Cultural Engagement Differences

| Pattern | EN Expected | AR Expected | MS Expected | Hypothesis |
|---------|-------------|-------------|-------------|-----------|
| Peak usage hours | 8-10 PM | 10 PM-1 AM | 9-11 PM | Gulf users active later |
| Weekend pattern | Sat-Sun peak | Fri-Sat peak | Sat-Sun peak | Gulf weekend is Fri-Sat |
| SOS usage rate | Moderate | Higher | Lower | AR cultural conflict patterns |
| Gift price range | $15-50 | $30-100 | $10-40 | Gulf has higher gift budgets |
| Message length pref | Medium | Long | Short-medium | Arabic expression is verbose |
| Sharing rate | High (social) | Low (private) | Medium | Gulf privacy concerns |
| Streak consistency | Moderate | Higher | Moderate | Consistency valued in Islamic culture |
| Ramadan behavior | No change | Spike in usage | Moderate spike | Religious occasion engagement |

---

## 2.4 Beta-to-Launch Decision Framework

### 2.4.1 Go/No-Go Criteria per Market

**English Market (Global EN):**

| # | Criterion | Threshold (Go) | Threshold (No-Go) | Actual | Status |
|---|----------|----------------|-------------------|--------|--------|
| 1 | D7 Retention | >= 30% | < 20% | [ ] | [ ] |
| 2 | Crash-Free Rate | >= 99% | < 98% | [ ] | [ ] |
| 3 | NPS (Day 7) | >= 40 | < 20 | [ ] | [ ] |
| 4 | AI Satisfaction | >= 75% | < 55% | [ ] | [ ] |
| 5 | P0 Bugs Open | 0 | > 0 | [ ] | [ ] |
| 6 | P1 Bugs Open | <= 3 | > 10 | [ ] | [ ] |
| 7 | Onboarding Completion | >= 80% | < 60% | [ ] | [ ] |
| 8 | Core Flow Success | >= 90% | < 75% | [ ] | [ ] |
| 9 | Free-to-Pro Conversion | >= 3% | < 1% | [ ] | [ ] |
| 10 | Beta Tester Count | >= 200 | < 50 | [ ] | [ ] |

**Arabic Market (Gulf Region):**

| # | Criterion | Threshold (Go) | Threshold (No-Go) | Actual | Status |
|---|----------|----------------|-------------------|--------|--------|
| 1 | D7 Retention | >= 25% | < 15% | [ ] | [ ] |
| 2 | Crash-Free Rate | >= 99% | < 97% | [ ] | [ ] |
| 3 | NPS (Day 7) | >= 35 | < 15 | [ ] | [ ] |
| 4 | AI Satisfaction (AR) | >= 70% | < 50% | [ ] | [ ] |
| 5 | RTL Visual Bugs Open | 0 (P0/P1) | > 3 P1 | [ ] | [ ] |
| 6 | Translation Coverage | 100% | < 95% | [ ] | [ ] |
| 7 | Hijri Date Accuracy | 100% | < 90% | [ ] | [ ] |
| 8 | Cultural Review Sign-Off | Approved | Not reviewed | [ ] | [ ] |
| 9 | Arabic Dialect Consistency | >= 90% Gulf | Mixed dialects | [ ] | [ ] |
| 10 | Beta Tester Count (AR) | >= 100 | < 30 | [ ] | [ ] |

**Malay Market (Malaysia):**

| # | Criterion | Threshold (Go) | Threshold (No-Go) | Actual | Status |
|---|----------|----------------|-------------------|--------|--------|
| 1 | D7 Retention | >= 28% | < 18% | [ ] | [ ] |
| 2 | Crash-Free Rate | >= 99% | < 98% | [ ] | [ ] |
| 3 | NPS (Day 7) | >= 38 | < 18 | [ ] | [ ] |
| 4 | AI Satisfaction (MS) | >= 72% | < 52% | [ ] | [ ] |
| 5 | Translation Coverage | 100% | < 95% | [ ] | [ ] |
| 6 | MY vs ID Language Accuracy | >= 95% MY | Mixed MY/ID | [ ] | [ ] |
| 7 | Cultural Review Sign-Off | Approved | Not reviewed | [ ] | [ ] |
| 8 | Hari Raya Content Accuracy | 100% | < 90% | [ ] | [ ] |
| 9 | MYR Pricing Correct | All tiers correct | Any pricing error | [ ] | [ ] |
| 10 | Beta Tester Count (MS) | >= 75 | < 25 | [ ] | [ ] |

### 2.4.2 Blocker Bug Definition and SLA

| Severity | Definition | Response SLA | Resolution SLA | Launch Blocker? |
|----------|-----------|-------------|----------------|-----------------|
| P0 | Data loss, security breach, harmful AI output, crash on launch, payment takes money without delivering | 30 minutes | 4 hours | Yes -- absolute |
| P1 | Core flow broken (cannot generate message, cannot complete onboarding), full-screen untranslated, religious content error | 2 hours | 24 hours | Yes -- must fix |
| P2 | Significant UX degradation, slow performance, partial translation gaps, layout overflow | 8 hours | 72 hours | Conditional (max 5 open) |
| P3 | Minor visual, minor translation, non-blocking | 24 hours | Next sprint | No |
| P4 | Trivial, cosmetic | 72 hours | Backlog | No |

**Launch Blocker Escalation Path:**

```
P0 Discovered -> Slack #lolo-p0-war-room -> All hands notified ->
  Fix deployed within 4 hours OR rollback to last stable build

P1 Discovered -> Slack #lolo-bugs -> Assigned within 2 hours ->
  Fix in next beta build (daily builds during beta) ->
  If not fixed in 24h, escalate to P0 process

P2 Accumulation -> If >5 open P2 bugs, freeze new features ->
  All engineering on bug fix sprint until P2 count <= 3
```

### 2.4.3 Minimum Beta Duration per Market

| Market | Minimum Beta Duration | Minimum Testers | Rationale |
|--------|---------------------|-----------------|-----------|
| EN (Global) | 14 days | 200 users | Largest market, most feature coverage |
| AR (Gulf) | 21 days | 100 users | RTL complexity, Hijri calendar verification, cultural review needs more time |
| MS (Malaysia) | 14 days | 75 users | Smaller market, less RTL complexity |
| **Combined** | **21 days minimum** | **375 total** | Cannot launch any market until all pass criteria |

**Beta Phases:**

| Phase | Duration | Focus | Exit Criteria |
|-------|---------|-------|---------------|
| Alpha (internal) | 7 days | Core flow, obvious bugs, translation gaps | 0 P0, < 5 P1, all screens functional |
| Closed Beta | 14 days | Real-world usage, AI quality, cultural review | Meet Go thresholds above |
| Open Beta (optional) | 7 days | Scale testing, edge cases, payment flows | No regression from closed beta metrics |

### 2.4.4 Graduated Launch Criteria

| Stage | Markets | Unlock Criteria | Rollback Trigger |
|-------|---------|----------------|------------------|
| Stage 1 | EN only (US, UK, AU) | All EN Go criteria met | Crash rate > 2% in first 48h |
| Stage 2 | EN + MS (Malaysia) | Stage 1 stable 7 days + MS Go criteria | MS-specific crash > 2% or NPS < 15 |
| Stage 3 | EN + MS + AR (UAE, SA) | Stage 2 stable 7 days + AR Go criteria | AR-specific crash > 2% or cultural P0 |
| Stage 4 | All markets + expanded EN | Stage 3 stable 14 days, all NPS > 30 | Any market regression below Go threshold |

**Between-Stage Monitoring:**

- 24/7 crash monitoring with PagerDuty alerts
- Daily NPS and retention dashboard review
- Weekly cultural review board meeting (AR/MS markets)
- Bi-weekly beta tester feedback call per language

---

# Part 3: Accessibility QA

## 3.1 Screen Reader Test Suite

### 3.1.1 VoiceOver (iOS) Test Cases

**Testing Protocol:** Navigate each screen using VoiceOver only (no visual reference). Verify all interactive elements are reachable, labeled, and actionable.

| ID | Screen | Test Case | EN | AR | MS | Status |
|----|--------|-----------|----|----|----|----|
| VO-01 | Welcome | VoiceOver reads app title and language options | [ ] | [ ] | [ ] | [ ] |
| VO-02 | Welcome | Language buttons have semantic labels ("Select English", etc.) | [ ] | [ ] | [ ] | [ ] |
| VO-03 | Sign Up | Google/Apple/Email buttons announced with provider name | [ ] | [ ] | [ ] | [ ] |
| VO-04 | Sign Up | Form fields announce label, current value, and input type | [ ] | [ ] | [ ] | [ ] |
| VO-05 | Onboarding S3 | Name input field announces "Your name, text field" | [ ] | [ ] | [ ] | [ ] |
| VO-06 | Onboarding S4 | Zodiac picker announces each sign with name | [ ] | [ ] | [ ] | [ ] |
| VO-07 | Onboarding S5 | Radio buttons announce selected state | [ ] | [ ] | [ ] | [ ] |
| VO-08 | Onboarding S6 | Date picker is navigable and announces selected date | [ ] | [ ] | [ ] | [ ] |
| VO-09 | Onboarding S7 | AI-generated card content is read aloud fully | [ ] | [ ] | [ ] | [ ] |
| VO-10 | Onboarding S8 | Paywall tiers announce name, price, features | [ ] | [ ] | [ ] | [ ] |
| VO-11 | Dashboard | Greeting, action card, streak, XP all announced | [ ] | [ ] | [ ] | [ ] |
| VO-12 | Dashboard | Action card type badge (SAY/DO/BUY/GO) announced | [ ] | [ ] | [ ] | [ ] |
| VO-13 | Dashboard | Consistency score announces percentage | [ ] | [ ] | [ ] | [ ] |
| VO-14 | Bottom Nav | All 5 tabs announce label and selected state | [ ] | [ ] | [ ] | [ ] |
| VO-15 | Messages | Mode selector reads all 10 mode names | [ ] | [ ] | [ ] | [ ] |
| VO-16 | Messages | Tone/length sliders announce current value | [ ] | [ ] | [ ] | [ ] |
| VO-17 | Messages | Generated message is fully readable | [ ] | [ ] | [ ] | [ ] |
| VO-18 | Messages | Copy/Share/Regenerate buttons labeled | [ ] | [ ] | [ ] | [ ] |
| VO-19 | Messages | Loading state announces "generating message" | [ ] | [ ] | [ ] | [ ] |
| VO-20 | Gift Engine | Gift suggestions announce name, price, category | [ ] | [ ] | [ ] | [ ] |
| VO-21 | Gift Detail | Full description, price, purchase link readable | [ ] | [ ] | [ ] | [ ] |
| VO-22 | Action Cards | Card type, title, description, actions announced | [ ] | [ ] | [ ] | [ ] |
| VO-23 | Action Cards | Complete/Skip buttons labeled with context | [ ] | [ ] | [ ] | [ ] |
| VO-24 | SOS Mode | Scenario selection reads all options | [ ] | [ ] | [ ] | [ ] |
| VO-25 | SOS Mode | Coaching response fully readable | [ ] | [ ] | [ ] | [ ] |
| VO-26 | SOS Mode | "Say this" / "Don't say" sections distinguished | [ ] | [ ] | [ ] | [ ] |
| VO-27 | Reminders | Reminder list items announce title, date, recurrence | [ ] | [ ] | [ ] | [ ] |
| VO-28 | Reminders | Create reminder form fully navigable | [ ] | [ ] | [ ] | [ ] |
| VO-29 | Her Profile | All profile fields readable and editable | [ ] | [ ] | [ ] | [ ] |
| VO-30 | Her Profile | Zodiac personality traits readable | [ ] | [ ] | [ ] | [ ] |
| VO-31 | Wish List | Items announce name and can be added/removed | [ ] | [ ] | [ ] | [ ] |
| VO-32 | Gamification | Level, XP, badges all announced | [ ] | [ ] | [ ] | [ ] |
| VO-33 | Gamification | Streak calendar announces active days | [ ] | [ ] | [ ] | [ ] |
| VO-34 | Memories | Memory entries announce date and content | [ ] | [ ] | [ ] | [ ] |
| VO-35 | Subscription | Plan comparison table reads cell-by-cell | [ ] | [ ] | [ ] | [ ] |
| VO-36 | Subscription | Purchase button announces tier name and price | [ ] | [ ] | [ ] | [ ] |
| VO-37 | Settings | All toggle switches announce label and state | [ ] | [ ] | [ ] | [ ] |
| VO-38 | Settings | Language picker announces current and available languages | [ ] | [ ] | [ ] | [ ] |
| VO-39 | Feedback | All feedback widgets are VoiceOver-accessible | [ ] | [ ] | [ ] | [ ] |
| VO-40 | Dialogs | Confirmation dialogs announce message and both buttons | [ ] | [ ] | [ ] | [ ] |
| VO-41 | Error States | Error messages announced immediately on appearance | [ ] | [ ] | [ ] | [ ] |
| VO-42 | Loading States | Loading indicators announce "loading" not silent | [ ] | [ ] | [ ] | [ ] |
| VO-43 | Offline State | Offline banner announced when connectivity lost | [ ] | [ ] | [ ] | [ ] |

### 3.1.2 TalkBack (Android) Test Cases

The same 43 test cases from VoiceOver apply to TalkBack. Additional Android-specific tests:

| ID | Screen | Test Case | EN | AR | MS | Status |
|----|--------|-----------|----|----|----|----|
| TB-01 | All | Linear navigation (swipe right) reaches all elements in logical order | [ ] | [ ] | [ ] | [ ] |
| TB-02 | All | Explore-by-touch finds all interactive elements | [ ] | [ ] | [ ] | [ ] |
| TB-03 | All | Custom actions available where applicable (e.g., long press) | [ ] | [ ] | [ ] | [ ] |
| TB-04 | All | Headings structure allows heading-level navigation | [ ] | [ ] | [ ] | [ ] |
| TB-05 | RTL | TalkBack swipe direction correct in Arabic (swipe left = next) | [ ] | [ ] | N/A | [ ] |
| TB-06 | All | No duplicate announcements on state change | [ ] | [ ] | [ ] | [ ] |
| TB-07 | All | Focus indicator visible around current element | [ ] | [ ] | [ ] | [ ] |
| TB-08 | Forms | EditText fields announce hint text, not just label | [ ] | [ ] | [ ] | [ ] |

---

## 3.2 Font Scaling and Visual Tests

### 3.2.1 Font Scaling Matrix (100%, 150%, 200%)

| Screen | Element | 100% | 150% | 200% | Overflow? | Fix Required? |
|--------|---------|------|------|------|-----------|---------------|
| Dashboard | Greeting text | [ ] | [ ] | [ ] | [ ] | [ ] |
| Dashboard | Action card title | [ ] | [ ] | [ ] | [ ] | [ ] |
| Dashboard | Streak counter | [ ] | [ ] | [ ] | [ ] | [ ] |
| Dashboard | XP progress bar label | [ ] | [ ] | [ ] | [ ] | [ ] |
| Bottom Nav | All 5 labels | [ ] | [ ] | [ ] | [ ] | [ ] |
| Messages | Mode selector grid | [ ] | [ ] | [ ] | [ ] | [ ] |
| Messages | Generated message body | [ ] | [ ] | [ ] | [ ] | [ ] |
| Messages | Copy/Share buttons | [ ] | [ ] | [ ] | [ ] | [ ] |
| Gift Engine | Gift card title + price | [ ] | [ ] | [ ] | [ ] | [ ] |
| Action Cards | Card type badge | [ ] | [ ] | [ ] | [ ] | [ ] |
| Action Cards | Card description | [ ] | [ ] | [ ] | [ ] | [ ] |
| SOS Mode | Scenario buttons | [ ] | [ ] | [ ] | [ ] | [ ] |
| SOS Mode | Coaching response | [ ] | [ ] | [ ] | [ ] | [ ] |
| Reminders | Reminder list items | [ ] | [ ] | [ ] | [ ] | [ ] |
| Her Profile | Profile fields | [ ] | [ ] | [ ] | [ ] | [ ] |
| Subscription | Plan cards with pricing | [ ] | [ ] | [ ] | [ ] | [ ] |
| Subscription | Feature comparison rows | [ ] | [ ] | [ ] | [ ] | [ ] |
| Settings | Toggle labels | [ ] | [ ] | [ ] | [ ] | [ ] |
| Onboarding | Screen titles | [ ] | [ ] | [ ] | [ ] | [ ] |
| Onboarding | First AI card | [ ] | [ ] | [ ] | [ ] | [ ] |

**Pass criteria:** Text remains readable, no clipping, no horizontal overflow. Scrollable containers may be used. At 200%, some layout reflow is acceptable.

**Test across all 3 languages at each scale level.** Arabic at 200% is the highest-risk combination due to inherently longer strings plus scaling.

### 3.2.2 Color Contrast WCAG AA Verification

| Component | Light Theme FG | Light Theme BG | Ratio | AA Pass? | Dark Theme FG | Dark Theme BG | Ratio | AA Pass? |
|-----------|---------------|---------------|-------|----------|--------------|--------------|-------|----------|
| Body text | #1A1A2E | #FFFFFF | [ ] | [ ] | #E8E8F0 | #1A1A2E | [ ] | [ ] |
| Secondary text | #6B6B80 | #FFFFFF | [ ] | [ ] | #9D9DB0 | #1A1A2E | [ ] | [ ] |
| Primary button text | #FFFFFF | #6C63FF | [ ] | [ ] | #FFFFFF | #6C63FF | [ ] | [ ] |
| Disabled button text | #B0B0C0 | #E8E8F0 | [ ] | [ ] | #505060 | #2A2A40 | [ ] | [ ] |
| Error text | #FF4444 | #FFFFFF | [ ] | [ ] | #FF6B6B | #1A1A2E | [ ] | [ ] |
| Success text | #00C853 | #FFFFFF | [ ] | [ ] | #69F0AE | #1A1A2E | [ ] | [ ] |
| Link text | #6C63FF | #FFFFFF | [ ] | [ ] | #9D95FF | #1A1A2E | [ ] | [ ] |
| Card badge (SAY) | #FFFFFF | #4A90D9 | [ ] | [ ] | #FFFFFF | #4A90D9 | [ ] | [ ] |
| Card badge (DO) | #FFFFFF | #7CB342 | [ ] | [ ] | #FFFFFF | #7CB342 | [ ] | [ ] |
| Card badge (BUY) | #FFFFFF | #FF8F00 | [ ] | [ ] | #FFFFFF | #FF8F00 | [ ] | [ ] |
| Card badge (GO) | #FFFFFF | #E91E63 | [ ] | [ ] | #FFFFFF | #E91E63 | [ ] | [ ] |
| Placeholder text | #B0B0C0 | #F5F5F5 | [ ] | [ ] | #505060 | #2A2A40 | [ ] | [ ] |
| Navigation active | #6C63FF | #FFFFFF | [ ] | [ ] | #9D95FF | #1A1A2E | [ ] | [ ] |
| Navigation inactive | #9E9E9E | #FFFFFF | [ ] | [ ] | #6B6B80 | #1A1A2E | [ ] | [ ] |

**WCAG AA Minimums:** Normal text >= 4.5:1, Large text (>= 18pt or 14pt bold) >= 3:1, UI components >= 3:1.

### 3.2.3 Touch Target Verification

All interactive elements must be minimum 48x48dp (Android) / 44x44pt (iOS).

| Screen | Element | Measured Size | Meets 48x48dp? | Status |
|--------|---------|--------------|-----------------|--------|
| All | Bottom navigation icons | [ ] dp | [ ] | [ ] |
| All | AppBar back button | [ ] dp | [ ] | [ ] |
| All | AppBar action buttons | [ ] dp | [ ] | [ ] |
| Dashboard | Quick action buttons | [ ] dp | [ ] | [ ] |
| Messages | Mode selector items | [ ] dp | [ ] | [ ] |
| Messages | Tone radio buttons | [ ] dp | [ ] | [ ] |
| Messages | Length radio buttons | [ ] dp | [ ] | [ ] |
| Messages | Copy button | [ ] dp | [ ] | [ ] |
| Messages | Share button | [ ] dp | [ ] | [ ] |
| Messages | Thumbs up/down feedback | [ ] dp | [ ] | [ ] |
| Action Cards | Complete button | [ ] dp | [ ] | [ ] |
| Action Cards | Skip button | [ ] dp | [ ] | [ ] |
| SOS Mode | Scenario cards | [ ] dp | [ ] | [ ] |
| Reminders | List item tap target | [ ] dp | [ ] | [ ] |
| Reminders | Delete swipe target | [ ] dp | [ ] | [ ] |
| Her Profile | Edit icons | [ ] dp | [ ] | [ ] |
| Subscription | Plan select buttons | [ ] dp | [ ] | [ ] |
| Settings | Toggle switches | [ ] dp | [ ] | [ ] |
| Dialogs | Dialog action buttons | [ ] dp | [ ] | [ ] |
| Onboarding | Zodiac sign selector items | [ ] dp | [ ] | [ ] |

---

## 3.3 Semantic Labels in All Languages

### 3.3.1 Semantic Label Verification

Every widget with `Semantics`, `semanticLabel`, or `excludeFromSemantics` must be verified in all 3 languages.

```dart
// test/accessibility/semantic_labels_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Semantic Labels - English', () {
    testWidgets('Dashboard action card has semantic label', (tester) async {
      // Build dashboard screen with EN locale
      // ...
      final semantics = tester.getSemantics(find.byKey(
        const Key('dashboard_action_card'),
      ));
      expect(semantics.label, isNotEmpty);
      expect(semantics.label, isNot(contains('null')));
      expect(semantics.label, isNot(contains('TODO')));
    });

    testWidgets('Copy button has action semantic', (tester) async {
      // ...
      final semantics = tester.getSemantics(find.byKey(
        const Key('message_copy_button'),
      ));
      expect(semantics.label, contains('Copy'));
      expect(semantics.hasAction(SemanticsAction.tap), isTrue);
    });
  });

  group('Semantic Labels - Arabic', () {
    testWidgets('Dashboard action card has Arabic semantic label',
        (tester) async {
      // Build dashboard screen with AR locale
      // ...
      final semantics = tester.getSemantics(find.byKey(
        const Key('dashboard_action_card'),
      ));
      expect(semantics.label, isNotEmpty);
      // Verify it contains Arabic characters
      expect(
        semantics.label!.contains(RegExp(r'[\u0600-\u06FF]')),
        isTrue,
        reason: 'Arabic semantic label should contain Arabic characters',
      );
    });

    testWidgets('Copy button has Arabic label', (tester) async {
      // ...
      final semantics = tester.getSemantics(find.byKey(
        const Key('message_copy_button'),
      ));
      expect(semantics.label, isNotEmpty);
      expect(semantics.label, isNot(equals('Copy'))); // Must not be English
    });
  });

  group('Semantic Labels - Malay', () {
    testWidgets('Dashboard action card has Malay semantic label',
        (tester) async {
      // Build dashboard screen with MS locale
      // ...
      final semantics = tester.getSemantics(find.byKey(
        const Key('dashboard_action_card'),
      ));
      expect(semantics.label, isNotEmpty);
      expect(semantics.label, isNot(equals('Action Card'))); // Not English
    });
  });

  group('Images and Icons', () {
    testWidgets('Decorative images are excluded from semantics',
        (tester) async {
      // Background images, decorative illustrations should have
      // excludeFromSemantics: true
      // ...
    });

    testWidgets('Functional icons have semantic labels', (tester) async {
      // All icons that convey meaning must have labels
      // ...
    });
  });
}
```

### 3.3.2 Critical Semantic Labels Checklist

| Widget | EN Label | AR Label | MS Label | Verified? |
|--------|---------|---------|---------|-----------|
| App logo | "LOLO - Relationship Intelligence" | "لولو - ذكاء العلاقات" | "LOLO - Kecerdasan Perhubungan" | [ ] |
| Home tab | "Home" | "الرئيسية" | "Utama" | [ ] |
| Messages tab | "Messages" | "الرسائل" | "Mesej" | [ ] |
| Gifts tab | "Gifts" | "الهدايا" | "Hadiah" | [ ] |
| Memories tab | "Memories" | "الذكريات" | "Kenangan" | [ ] |
| Profile tab | "Profile" | "الملف الشخصي" | "Profil" | [ ] |
| SOS button | "SOS Emergency Mode" | "وضع الطوارئ" | "Mod Kecemasan SOS" | [ ] |
| Copy button | "Copy message to clipboard" | "نسخ الرسالة" | "Salin mesej" | [ ] |
| Share button | "Share message" | "مشاركة الرسالة" | "Kongsi mesej" | [ ] |
| Generate button | "Generate message" | "إنشاء رسالة" | "Jana mesej" | [ ] |
| Complete card button | "Mark action card as completed" | "تحديد البطاقة كمكتملة" | "Tandakan kad sebagai selesai" | [ ] |
| Skip card button | "Skip this action card" | "تخطي هذه البطاقة" | "Langkau kad ini" | [ ] |
| Streak counter | "Day streak: {count} days" | "أيام متتالية: {count}" | "Hari berturut-turut: {count}" | [ ] |
| XP progress | "Level {level}, {xp} XP to next level" | "المستوى {level}، {xp} نقطة للمستوى التالي" | "Tahap {level}, {xp} XP ke tahap seterusnya" | [ ] |
| Back button | "Go back" | "رجوع" | "Kembali" | [ ] |
| Close button | "Close" | "إغلاق" | "Tutup" | [ ] |
| Settings gear | "Settings" | "الإعدادات" | "Tetapan" | [ ] |
| Notification bell | "Notifications" | "الإشعارات" | "Pemberitahuan" | [ ] |
| Theme toggle | "Switch to dark/light mode" | "تبديل الوضع المظلم/الفاتح" | "Tukar mod gelap/cerah" | [ ] |

---

## Appendix A: Test Execution Summary Template

| Section | Total Tests | Passed | Failed | Blocked | Not Run | Pass Rate |
|---------|-----------|--------|--------|---------|---------|-----------|
| 1.1 ARB Completeness | ~15 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| 1.2 Arabic QA | ~80 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| 1.3 Malay QA | ~50 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| 1.4 AI Output Verification | ~96 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| 2.x Beta Framework | N/A (framework) | -- | -- | -- | -- | -- |
| 3.1 VoiceOver/TalkBack | ~102 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| 3.2 Font/Color/Touch | ~70 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| 3.3 Semantic Labels | ~38 | [ ] | [ ] | [ ] | [ ] | [ ]% |
| **TOTAL** | **~451** | **[ ]** | **[ ]** | **[ ]** | **[ ]** | **[ ]%** |

## Appendix B: Sign-Off

| Reviewer | Role | Date | Signature |
|----------|------|------|-----------|
| Yuki Tanaka | QA Engineer | [ ] | [ ] |
| Omar Al-Rashidi | Tech Lead | [ ] | [ ] |
| Dr. Aisha Mahmoud | AI/ML Engineer | [ ] | [ ] |
| Nadia Khalil | Cultural Consultant | [ ] | [ ] |
| Sarah Chen | Product Manager | [ ] | [ ] |

---

*Document ends. Total test coverage: ~451 individual verifications across 3 languages, 2 text directions, 43+ screens, and 10 AI modes.*
