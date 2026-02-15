import 'package:freezed_annotation/freezed_annotation.dart';

part 'zodiac_profile_entity.freezed.dart';

/// Zodiac-derived personality traits and relationship guidance.
///
/// Pre-populated from GET /profiles/:id/zodiac-defaults when the
/// user selects a zodiac sign. Can be overridden per-field by the user.
@freezed
class ZodiacProfileEntity with _$ZodiacProfileEntity {
  const factory ZodiacProfileEntity({
    required String sign,
    required String element,
    required String modality,
    required String rulingPlanet,
    @Default([]) List<String> personality,
    @Default([]) List<String> communicationTips,
    @Default([]) List<String> emotionalNeeds,
    String? conflictStyle,
    @Default([]) List<String> giftPreferences,
    String? loveLanguageAffinity,
    Map<String, String>? bestApproachDuring,
  }) = _ZodiacProfileEntity;
}
