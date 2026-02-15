import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';

part 'partner_profile_entity.freezed.dart';

/// Complete partner profile entity.
///
/// This is the central data object for the "Her Profile Engine" module.
/// It feeds into AI message personalization, gift recommendations,
/// action card generation, and SOS coaching.
@freezed
class PartnerProfileEntity with _$PartnerProfileEntity {
  const factory PartnerProfileEntity({
    required String id,
    required String userId,
    required String name,
    DateTime? birthday,
    String? zodiacSign,
    ZodiacProfileEntity? zodiacTraits,
    String? loveLanguage,
    String? communicationStyle,
    required String relationshipStatus,
    DateTime? anniversaryDate,
    String? photoUrl,
    PartnerPreferencesEntity? preferences,
    CulturalContextEntity? culturalContext,
    @Default(0) int profileCompletionPercent,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PartnerProfileEntity;

  const PartnerProfileEntity._();

  /// Whether the profile has enough data for quality AI personalization.
  bool get hasMinimumForAI =>
      zodiacSign != null || loveLanguage != null || preferences != null;

  /// Display-friendly zodiac name with capitalization.
  String get zodiacDisplayName {
    if (zodiacSign == null) return '';
    return zodiacSign![0].toUpperCase() + zodiacSign!.substring(1);
  }
}
