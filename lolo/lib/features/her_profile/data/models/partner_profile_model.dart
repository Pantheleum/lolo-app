import 'package:json_annotation/json_annotation.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';

part 'partner_profile_model.g.dart';

/// DTO for partner profile with JSON + Firestore mapping.
@JsonSerializable(explicitToJson: true)
class PartnerProfileModel {
  final String id;
  final String userId;
  final String name;
  final String? birthday;
  final String? zodiacSign;
  final Map<String, dynamic>? zodiacTraits;
  final String? loveLanguage;
  final String? communicationStyle;
  final String relationshipStatus;
  final String? anniversaryDate;
  final String? photoUrl;
  final Map<String, dynamic>? preferences;
  final Map<String, dynamic>? culturalContext;
  final int profileCompletionPercent;
  final String createdAt;
  final String updatedAt;

  const PartnerProfileModel({
    required this.id,
    required this.userId,
    required this.name,
    this.birthday,
    this.zodiacSign,
    this.zodiacTraits,
    this.loveLanguage,
    this.communicationStyle,
    required this.relationshipStatus,
    this.anniversaryDate,
    this.photoUrl,
    this.preferences,
    this.culturalContext,
    this.profileCompletionPercent = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PartnerProfileModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerProfileModelToJson(this);

  /// Convert API/Firestore response to domain entity.
  PartnerProfileEntity toEntity() => PartnerProfileEntity(
        id: id,
        userId: userId,
        name: name,
        birthday: birthday != null ? DateTime.tryParse(birthday!) : null,
        zodiacSign: zodiacSign,
        zodiacTraits: zodiacTraits != null
            ? ZodiacProfileEntity(
                sign: zodiacTraits!['sign'] as String? ?? zodiacSign ?? '',
                element: zodiacTraits!['element'] as String? ?? '',
                modality: zodiacTraits!['modality'] as String? ?? '',
                rulingPlanet: zodiacTraits!['rulingPlanet'] as String? ?? '',
                personality: _toStringList(zodiacTraits!['personality']),
                communicationTips:
                    _toStringList(zodiacTraits!['communicationTips']),
                emotionalNeeds:
                    _toStringList(zodiacTraits!['emotionalNeeds']),
                conflictStyle: zodiacTraits!['conflictStyle'] as String?,
                giftPreferences:
                    _toStringList(zodiacTraits!['giftPreferences']),
                loveLanguageAffinity:
                    zodiacTraits!['loveLanguageAffinity'] as String?,
                bestApproachDuring:
                    (zodiacTraits!['bestApproachDuring'] as Map?)
                        ?.cast<String, String>(),
              )
            : null,
        loveLanguage: loveLanguage,
        communicationStyle: communicationStyle,
        relationshipStatus: relationshipStatus,
        anniversaryDate:
            anniversaryDate != null ? DateTime.tryParse(anniversaryDate!) : null,
        photoUrl: photoUrl,
        preferences: preferences != null
            ? PartnerPreferencesEntity(
                favorites: _parsePreferenceFavorites(preferences!['favorites']),
                dislikes: _toStringList(preferences!['dislikes']),
                hobbies: _toStringList(preferences!['hobbies']),
                stressCoping: preferences!['stressCoping'] as String?,
                notes: preferences!['notes'] as String?,
              )
            : null,
        culturalContext: culturalContext != null
            ? CulturalContextEntity(
                background: culturalContext!['background'] as String?,
                religiousObservance:
                    culturalContext!['religiousObservance'] as String?,
                dialect: culturalContext!['dialect'] as String?,
              )
            : null,
        profileCompletionPercent: profileCompletionPercent,
        createdAt: DateTime.parse(createdAt),
        updatedAt: DateTime.parse(updatedAt),
      );

  static List<String> _toStringList(dynamic value) {
    if (value is List) return value.cast<String>();
    return [];
  }

  static Map<String, List<String>> _parsePreferenceFavorites(dynamic value) {
    if (value is! Map) return {};
    return value.map((k, v) => MapEntry(
          k.toString(),
          (v is List) ? v.cast<String>() : <String>[],
        ));
  }
}
