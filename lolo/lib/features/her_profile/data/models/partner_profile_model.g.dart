// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'partner_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerProfileModel _$PartnerProfileModelFromJson(Map<String, dynamic> json) =>
    PartnerProfileModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      name: json['name'] as String,
      birthday: json['birthday'] as String?,
      zodiacSign: json['zodiacSign'] as String?,
      zodiacTraits: json['zodiacTraits'] as Map<String, dynamic>?,
      loveLanguage: json['loveLanguage'] as String?,
      communicationStyle: json['communicationStyle'] as String?,
      relationshipStatus: json['relationshipStatus'] as String,
      anniversaryDate: json['anniversaryDate'] as String?,
      photoUrl: json['photoUrl'] as String?,
      preferences: json['preferences'] as Map<String, dynamic>?,
      culturalContext: json['culturalContext'] as Map<String, dynamic>?,
      profileCompletionPercent:
          (json['profileCompletionPercent'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$PartnerProfileModelToJson(
        PartnerProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'name': instance.name,
      'birthday': instance.birthday,
      'zodiacSign': instance.zodiacSign,
      'zodiacTraits': instance.zodiacTraits,
      'loveLanguage': instance.loveLanguage,
      'communicationStyle': instance.communicationStyle,
      'relationshipStatus': instance.relationshipStatus,
      'anniversaryDate': instance.anniversaryDate,
      'photoUrl': instance.photoUrl,
      'preferences': instance.preferences,
      'culturalContext': instance.culturalContext,
      'profileCompletionPercent': instance.profileCompletionPercent,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
