import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/settings/domain/entities/app_settings.dart';
import 'package:lolo/features/settings/domain/repositories/settings_repository.dart';

/// SharedPreferences-backed implementation of [SettingsRepository].
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl({required SharedPreferences prefs}) : _prefs = prefs;

  final SharedPreferences _prefs;

  static const _keyLocale = 'settings_locale';
  static const _keyThemeMode = 'settings_theme_mode';
  static const _keyNotifications = 'settings_notifications';
  static const _keyReminders = 'settings_reminder_notifications';
  static const _keyDailyCards = 'settings_daily_card_notifications';
  static const _keyWeeklyDigest = 'settings_weekly_digest';

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      return Right(AppSettings(
        locale: _prefs.getString(_keyLocale) ?? 'en',
        themeMode: _prefs.getString(_keyThemeMode) ?? 'system',
        notificationsEnabled: _prefs.getBool(_keyNotifications) ?? true,
        reminderNotifications: _prefs.getBool(_keyReminders) ?? true,
        dailyCardNotifications: _prefs.getBool(_keyDailyCards) ?? true,
        weeklyDigest: _prefs.getBool(_keyWeeklyDigest) ?? true,
      ));
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppSettings>> saveSettings(
      AppSettings settings) async {
    try {
      await _prefs.setString(_keyLocale, settings.locale);
      await _prefs.setString(_keyThemeMode, settings.themeMode);
      await _prefs.setBool(_keyNotifications, settings.notificationsEnabled);
      await _prefs.setBool(_keyReminders, settings.reminderNotifications);
      await _prefs.setBool(_keyDailyCards, settings.dailyCardNotifications);
      await _prefs.setBool(_keyWeeklyDigest, settings.weeklyDigest);
      return Right(settings);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppSettings>> updateSetting(
    String key,
    dynamic value,
  ) async {
    try {
      if (value is String) {
        await _prefs.setString(key, value);
      } else if (value is bool) {
        await _prefs.setBool(key, value);
      }
      return getSettings();
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearSettings() async {
    try {
      await _prefs.remove(_keyLocale);
      await _prefs.remove(_keyThemeMode);
      await _prefs.remove(_keyNotifications);
      await _prefs.remove(_keyReminders);
      await _prefs.remove(_keyDailyCards);
      await _prefs.remove(_keyWeeklyDigest);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
