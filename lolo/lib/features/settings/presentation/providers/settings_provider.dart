import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lolo/features/settings/domain/entities/app_settings.dart';
import 'package:lolo/features/settings/domain/repositories/settings_repository.dart';
import 'package:lolo/features/settings/data/repositories/settings_repository_impl.dart';

part 'settings_provider.g.dart';

@Riverpod(keepAlive: true)
Future<SettingsRepository> settingsRepository(SettingsRepositoryRef ref) async {
  final prefs = await SharedPreferences.getInstance();
  return SettingsRepositoryImpl(prefs: prefs);
}

/// Provides app settings with persistence.
@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  Future<AppSettings> build() async {
    final repository = await ref.watch(settingsRepositoryProvider.future);
    final result = await repository.getSettings();
    return result.fold(
      (failure) => const AppSettings(),
      (settings) => settings,
    );
  }

  Future<void> setLocale(String locale) async {
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(locale: locale);
    await _save(updated);
  }

  Future<void> setThemeMode(String themeMode) async {
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(themeMode: themeMode);
    await _save(updated);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(notificationsEnabled: enabled);
    await _save(updated);
  }

  Future<void> setReminderNotifications(bool enabled) async {
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(reminderNotifications: enabled);
    await _save(updated);
  }

  Future<void> setDailyCardNotifications(bool enabled) async {
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(dailyCardNotifications: enabled);
    await _save(updated);
  }

  Future<void> setWeeklyDigest(bool enabled) async {
    final current = state.valueOrNull ?? const AppSettings();
    final updated = current.copyWith(weeklyDigest: enabled);
    await _save(updated);
  }

  Future<void> _save(AppSettings settings) async {
    final repository = await ref.read(settingsRepositoryProvider.future);
    final result = await repository.saveSettings(settings);
    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      AsyncData.new,
    );
  }
}
