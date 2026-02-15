import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_settings.freezed.dart';

/// App-level settings entity persisted in local storage.
@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('en') String locale,
    @Default('system') String themeMode,
    @Default(true) bool notificationsEnabled,
    @Default(true) bool reminderNotifications,
    @Default(true) bool dailyCardNotifications,
    @Default(true) bool weeklyDigest,
  }) = _AppSettings;
}
