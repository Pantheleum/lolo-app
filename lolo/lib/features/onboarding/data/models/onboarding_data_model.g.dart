// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnboardingDataModel _$OnboardingDataModelFromJson(Map<String, dynamic> json) =>
    OnboardingDataModel(
      language: json['language'] as String,
      userName: json['userName'] as String?,
      partnerName: json['partnerName'] as String?,
      partnerZodiac: json['partnerZodiac'] as String?,
      relationshipStatus: json['relationshipStatus'] as String?,
      keyDate: json['keyDate'] == null
          ? null
          : DateTime.parse(json['keyDate'] as String),
      keyDateType: json['keyDateType'] as String?,
      email: json['email'] as String?,
      authProvider: json['authProvider'] as String?,
      firebaseUid: json['firebaseUid'] as String?,
      currentStep: (json['currentStep'] as num?)?.toInt() ?? 0,
      isComplete: json['isComplete'] as bool? ?? false,
    );

Map<String, dynamic> _$OnboardingDataModelToJson(
        OnboardingDataModel instance) =>
    <String, dynamic>{
      'language': instance.language,
      'userName': instance.userName,
      'partnerName': instance.partnerName,
      'partnerZodiac': instance.partnerZodiac,
      'relationshipStatus': instance.relationshipStatus,
      'keyDate': instance.keyDate?.toIso8601String(),
      'keyDateType': instance.keyDateType,
      'email': instance.email,
      'authProvider': instance.authProvider,
      'firebaseUid': instance.firebaseUid,
      'currentStep': instance.currentStep,
      'isComplete': instance.isComplete,
    };
