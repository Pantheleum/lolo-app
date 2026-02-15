import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Supported locales for the LOLO app.
const supportedLocales = [
  Locale('en'),
  Locale('ar'),
  Locale('ms'),
];

/// Persisted locale preference key in Hive.
const _kLocaleKey = 'app_locale';
const _kSettingsBox = 'settings';

/// Provides the current app locale with persistence.
///
/// Reads from Hive on initialization, writes on change.
/// The [LoloApp] widget watches this provider to set [MaterialApp.locale].
class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(_initialLocale());

  static Locale _initialLocale() {
    final box = Hive.box(_kSettingsBox);
    final stored = box.get(_kLocaleKey, defaultValue: 'en') as String;
    return Locale(stored);
  }

  /// Change the app locale at runtime.
  ///
  /// Persists to Hive and triggers a full widget tree rebuild
  /// via MaterialApp.locale.
  void setLocale(Locale locale) {
    final box = Hive.box(_kSettingsBox);
    box.put(_kLocaleKey, locale.languageCode);
    state = locale;
  }

  /// Whether the current locale is RTL.
  bool get isRtl => state.languageCode == 'ar';
}

/// Provider for [LocaleNotifier].
final localeNotifierProvider =
    StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

/// Convenience provider that exposes just the locale value.
final localeProvider = Provider<Locale>((ref) {
  return ref.watch(localeNotifierProvider);
});

/// Theme mode notifier with persistence.
class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const _kThemeKey = 'theme_mode';

  ThemeModeNotifier() : super(_initialThemeMode());

  static ThemeMode _initialThemeMode() {
    final box = Hive.box(_kSettingsBox);
    final stored = box.get(_kThemeKey, defaultValue: 'dark') as String;
    return stored == 'light' ? ThemeMode.light : ThemeMode.dark;
  }

  void setThemeMode(ThemeMode mode) {
    final box = Hive.box(_kSettingsBox);
    box.put(_kThemeKey, mode == ThemeMode.light ? 'light' : 'dark');
    state = mode;
  }

  void toggle() {
    setThemeMode(state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark);
  }
}

/// Provider for [ThemeModeNotifier].
final themeModeNotifierProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

/// Convenience provider for ThemeMode.
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeModeNotifierProvider);
});
