import 'package:freezed_annotation/freezed_annotation.dart';

part 'cultural_context_entity.freezed.dart';

/// Cultural background and religious observance settings.
///
/// Affects AI tone (e.g., Ramadan awareness), content filtering
/// (no alcohol-related gifts for high observance), and auto-added
/// Islamic holidays to the reminder calendar.
@freezed
class CulturalContextEntity with _$CulturalContextEntity {
  const factory CulturalContextEntity({
    String? background,
    String? religiousObservance,
    String? dialect,
  }) = _CulturalContextEntity;

  const CulturalContextEntity._();

  /// Whether Islamic holidays should be auto-added to reminders.
  bool get shouldAddIslamicHolidays =>
      religiousObservance == 'high' || religiousObservance == 'moderate';

  /// Whether content should be filtered for religious sensitivity.
  bool get isHighObservance => religiousObservance == 'high';
}
