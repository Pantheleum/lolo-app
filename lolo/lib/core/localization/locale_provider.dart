import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_provider.g.dart';

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
@Riverpod(keepAlive: true)
class LocaleNotifier extends _$LocaleNotifier {
  @override
  Locale build() {
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

/// Convenience provider that exposes just the locale value.
final localeProvider = Provider<Locale>((ref) {
  return ref.watch(localeNotifierProvider);
});

/// Theme mode provider with persistence.
@Riverpod(keepAlive: true)
class ThemeModeNotifier extends _$ThemeModeNotifier {
  static const _kThemeKey = 'theme_mode';

  @override
  ThemeMode build() {
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

/// Convenience provider for ThemeMode.
final themeModeProvider = Provider<ThemeMode>((ref) {
  return ref.watch(themeModeNotifierProvider);
});
