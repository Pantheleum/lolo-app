import 'package:json_annotation/json_annotation.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

part 'onboarding_data_model.g.dart';

/// DTO for serializing [OnboardingDataEntity] to/from JSON.
///
/// Used for:
/// - Hive local draft persistence (toJson/fromJson)
/// - Backend API payloads (toRegisterPayload, toProfilePayload)
@JsonSerializable()
class OnboardingDataModel {
  final String language;
  final String? userName;
  final String? partnerName;
  final String? partnerZodiac;
  final String? relationshipStatus;
  final DateTime? keyDate;
  final String? keyDateType;
  final String? email;
  final String? authProvider;
  final String? firebaseUid;
  final int currentStep;
  final bool isComplete;

  const OnboardingDataModel({
    required this.language,
    this.userName,
    this.partnerName,
    this.partnerZodiac,
    this.relationshipStatus,
    this.keyDate,
    this.keyDateType,
    this.email,
    this.authProvider,
    this.firebaseUid,
    this.currentStep = 0,
    this.isComplete = false,
  });

  factory OnboardingDataModel.fromJson(Map<String, dynamic> json) =>
      _$OnboardingDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$OnboardingDataModelToJson(this);

  /// Convert from domain entity to data model.
  factory OnboardingDataModel.fromEntity(OnboardingDataEntity entity) =>
      OnboardingDataModel(
        language: entity.language,
        userName: entity.userName,
        partnerName: entity.partnerName,
        partnerZodiac: entity.partnerZodiac,
        relationshipStatus: entity.relationshipStatus,
        keyDate: entity.keyDate,
        keyDateType: entity.keyDateType,
        email: entity.email,
        authProvider: entity.authProvider,
        firebaseUid: entity.firebaseUid,
        currentStep: entity.currentStep,
        isComplete: entity.isComplete,
      );

  /// Convert to domain entity.
  OnboardingDataEntity toEntity() => OnboardingDataEntity(
        language: language,
        userName: userName,
        partnerName: partnerName,
        partnerZodiac: partnerZodiac,
        relationshipStatus: relationshipStatus,
        keyDate: keyDate,
        keyDateType: keyDateType,
        email: email,
        authProvider: authProvider,
        firebaseUid: firebaseUid,
        currentStep: currentStep,
        isComplete: isComplete,
      );

  /// Payload for POST /auth/register.
  Map<String, dynamic> toRegisterPayload() => {
        'email': email,
        'displayName': userName,
        'language': language,
      };

  /// Payload for POST /profiles (create partner profile).
  Map<String, dynamic> toProfilePayload() => {
        'name': partnerName,
        if (partnerZodiac != null) 'zodiacSign': partnerZodiac,
        'relationshipStatus': relationshipStatus,
        if (keyDate != null) 'anniversaryDate': keyDate!.toIso8601String(),
      };
}
