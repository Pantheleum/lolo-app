import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/settings/domain/entities/app_settings.dart';

/// Contract for app settings persistence.
abstract class SettingsRepository {
  /// Load settings from local storage.
  Future<Either<Failure, AppSettings>> getSettings();

  /// Save settings to local storage.
  Future<Either<Failure, AppSettings>> saveSettings(AppSettings settings);

  /// Update a single setting field.
  Future<Either<Failure, AppSettings>> updateSetting(
    String key,
    dynamic value,
  );

  /// Clear all settings (reset to defaults).
  Future<Either<Failure, void>> clearSettings();
}
