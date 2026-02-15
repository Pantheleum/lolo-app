// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiMessageRequestImpl _$$AiMessageRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$AiMessageRequestImpl(
      mode: $enumDecode(_$AiMessageModeEnumMap, json['mode']),
      tone: $enumDecode(_$AiToneEnumMap, json['tone']),
      length: $enumDecode(_$AiLengthEnumMap, json['length']),
      profileId: json['profileId'] as String,
      additionalContext: json['additionalContext'] as String?,
      emotionalState:
          $enumDecodeNullable(_$EmotionalStateEnumMap, json['emotionalState']),
      situationSeverity: (json['situationSeverity'] as num?)?.toInt(),
      includeAlternatives: json['includeAlternatives'] as bool? ?? false,
    );

Map<String, dynamic> _$$AiMessageRequestImplToJson(
        _$AiMessageRequestImpl instance) =>
    <String, dynamic>{
      'mode': _$AiMessageModeEnumMap[instance.mode]!,
      'tone': _$AiToneEnumMap[instance.tone]!,
      'length': _$AiLengthEnumMap[instance.length]!,
      'profileId': instance.profileId,
      'additionalContext': instance.additionalContext,
      'emotionalState': _$EmotionalStateEnumMap[instance.emotionalState],
      'situationSeverity': instance.situationSeverity,
      'includeAlternatives': instance.includeAlternatives,
    };

const _$AiMessageModeEnumMap = {
  AiMessageMode.goodMorning: 'goodMorning',
  AiMessageMode.checkingIn: 'checkingIn',
  AiMessageMode.appreciation: 'appreciation',
  AiMessageMode.motivation: 'motivation',
  AiMessageMode.celebration: 'celebration',
  AiMessageMode.flirting: 'flirting',
  AiMessageMode.reassurance: 'reassurance',
  AiMessageMode.longDistance: 'longDistance',
  AiMessageMode.apology: 'apology',
  AiMessageMode.afterArgument: 'afterArgument',
};

const _$AiToneEnumMap = {
  AiTone.warm: 'warm',
  AiTone.playful: 'playful',
  AiTone.serious: 'serious',
  AiTone.romantic: 'romantic',
  AiTone.gentle: 'gentle',
  AiTone.confident: 'confident',
};

const _$AiLengthEnumMap = {
  AiLength.short: 'short',
  AiLength.medium: 'medium',
  AiLength.long_: 'long_',
};

const _$EmotionalStateEnumMap = {
  EmotionalState.happy: 'happy',
  EmotionalState.stressed: 'stressed',
  EmotionalState.sad: 'sad',
  EmotionalState.angry: 'angry',
  EmotionalState.anxious: 'anxious',
  EmotionalState.neutral: 'neutral',
  EmotionalState.excited: 'excited',
  EmotionalState.tired: 'tired',
  EmotionalState.overwhelmed: 'overwhelmed',
  EmotionalState.vulnerable: 'vulnerable',
};

_$GiftRecommendationRequestImpl _$$GiftRecommendationRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftRecommendationRequestImpl(
      profileId: json['profileId'] as String,
      occasion: $enumDecode(_$GiftOccasionEnumMap, json['occasion']),
      occasionDetails: json['occasionDetails'] as String?,
      budgetMin: (json['budgetMin'] as num).toDouble(),
      budgetMax: (json['budgetMax'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      giftType: $enumDecodeNullable(_$GiftTypeEnumMap, json['giftType']) ??
          GiftType.any,
      excludeCategories: (json['excludeCategories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      count: (json['count'] as num?)?.toInt() ?? 5,
    );

Map<String, dynamic> _$$GiftRecommendationRequestImplToJson(
        _$GiftRecommendationRequestImpl instance) =>
    <String, dynamic>{
      'profileId': instance.profileId,
      'occasion': _$GiftOccasionEnumMap[instance.occasion]!,
      'occasionDetails': instance.occasionDetails,
      'budgetMin': instance.budgetMin,
      'budgetMax': instance.budgetMax,
      'currency': instance.currency,
      'giftType': _$GiftTypeEnumMap[instance.giftType]!,
      'excludeCategories': instance.excludeCategories,
      'count': instance.count,
    };

const _$GiftOccasionEnumMap = {
  GiftOccasion.birthday: 'birthday',
  GiftOccasion.anniversary: 'anniversary',
  GiftOccasion.eid: 'eid',
  GiftOccasion.valentines: 'valentines',
  GiftOccasion.justBecause: 'justBecause',
  GiftOccasion.apology: 'apology',
  GiftOccasion.congratulations: 'congratulations',
  GiftOccasion.hariRaya: 'hariRaya',
  GiftOccasion.christmas: 'christmas',
  GiftOccasion.other: 'other',
};

const _$GiftTypeEnumMap = {
  GiftType.physical: 'physical',
  GiftType.experience: 'experience',
  GiftType.digital: 'digital',
  GiftType.handmade: 'handmade',
  GiftType.any: 'any',
};

_$SosActivateRequestImpl _$$SosActivateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SosActivateRequestImpl(
      scenario: $enumDecode(_$SosScenarioEnumMap, json['scenario']),
      urgency: $enumDecode(_$SosUrgencyEnumMap, json['urgency']),
      briefContext: json['briefContext'] as String?,
      profileId: json['profileId'] as String?,
    );

Map<String, dynamic> _$$SosActivateRequestImplToJson(
        _$SosActivateRequestImpl instance) =>
    <String, dynamic>{
      'scenario': _$SosScenarioEnumMap[instance.scenario]!,
      'urgency': _$SosUrgencyEnumMap[instance.urgency]!,
      'briefContext': instance.briefContext,
      'profileId': instance.profileId,
    };

const _$SosScenarioEnumMap = {
  SosScenario.sheIsAngry: 'sheIsAngry',
  SosScenario.sheIsCrying: 'sheIsCrying',
  SosScenario.sheIsSilent: 'sheIsSilent',
  SosScenario.caughtInLie: 'caughtInLie',
  SosScenario.forgotImportantDate: 'forgotImportantDate',
  SosScenario.saidWrongThing: 'saidWrongThing',
  SosScenario.sheWantsToTalk: 'sheWantsToTalk',
  SosScenario.herFamilyConflict: 'herFamilyConflict',
  SosScenario.jealousyIssue: 'jealousyIssue',
  SosScenario.other: 'other',
};

const _$SosUrgencyEnumMap = {
  SosUrgency.happeningNow: 'happeningNow',
  SosUrgency.justHappened: 'justHappened',
  SosUrgency.brewing: 'brewing',
};

_$SosAssessRequestImpl _$$SosAssessRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SosAssessRequestImpl(
      sessionId: json['sessionId'] as String,
      answers: SosAssessmentAnswers.fromJson(
          json['answers'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SosAssessRequestImplToJson(
        _$SosAssessRequestImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'answers': instance.answers,
    };

_$SosAssessmentAnswersImpl _$$SosAssessmentAnswersImplFromJson(
        Map<String, dynamic> json) =>
    _$SosAssessmentAnswersImpl(
      howLongAgo: json['howLongAgo'] as String,
      herCurrentState: json['herCurrentState'] as String,
      haveYouSpoken: json['haveYouSpoken'] as bool,
      isSheTalking: json['isSheTalking'] as bool,
      yourFault: json['yourFault'] as String,
      previousSimilar: json['previousSimilar'] as bool?,
      additionalContext: json['additionalContext'] as String?,
    );

Map<String, dynamic> _$$SosAssessmentAnswersImplToJson(
        _$SosAssessmentAnswersImpl instance) =>
    <String, dynamic>{
      'howLongAgo': instance.howLongAgo,
      'herCurrentState': instance.herCurrentState,
      'haveYouSpoken': instance.haveYouSpoken,
      'isSheTalking': instance.isSheTalking,
      'yourFault': instance.yourFault,
      'previousSimilar': instance.previousSimilar,
      'additionalContext': instance.additionalContext,
    };

_$SosCoachRequestImpl _$$SosCoachRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$SosCoachRequestImpl(
      sessionId: json['sessionId'] as String,
      stepNumber: (json['stepNumber'] as num).toInt(),
      userUpdate: json['userUpdate'] as String?,
      herResponse: json['herResponse'] as String?,
      stream: json['stream'] as bool? ?? false,
    );

Map<String, dynamic> _$$SosCoachRequestImplToJson(
        _$SosCoachRequestImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'stepNumber': instance.stepNumber,
      'userUpdate': instance.userUpdate,
      'herResponse': instance.herResponse,
      'stream': instance.stream,
    };
