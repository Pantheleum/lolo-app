// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AiMessageResponseImpl _$$AiMessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AiMessageResponseImpl(
      id: json['id'] as String,
      content: json['content'] as String,
      alternatives: (json['alternatives'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      mode: json['mode'] as String,
      tone: json['tone'] as String,
      length: json['length'] as String,
      language: json['language'] as String,
      metadata: AiMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      feedbackId: json['feedbackId'] as String,
      usage: AiUsageInfo.fromJson(json['usage'] as Map<String, dynamic>),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AiMessageResponseImplToJson(
        _$AiMessageResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'alternatives': instance.alternatives,
      'mode': instance.mode,
      'tone': instance.tone,
      'length': instance.length,
      'language': instance.language,
      'metadata': instance.metadata,
      'feedbackId': instance.feedbackId,
      'usage': instance.usage,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$AiMetadataImpl _$$AiMetadataImplFromJson(Map<String, dynamic> json) =>
    _$AiMetadataImpl(
      modelUsed: json['modelUsed'] as String,
      emotionalDepthScore: (json['emotionalDepthScore'] as num).toInt(),
      latencyMs: (json['latencyMs'] as num).toInt(),
      cached: json['cached'] as bool? ?? false,
      wasFallback: json['wasFallback'] as bool? ?? false,
    );

Map<String, dynamic> _$$AiMetadataImplToJson(_$AiMetadataImpl instance) =>
    <String, dynamic>{
      'modelUsed': instance.modelUsed,
      'emotionalDepthScore': instance.emotionalDepthScore,
      'latencyMs': instance.latencyMs,
      'cached': instance.cached,
      'wasFallback': instance.wasFallback,
    };

_$AiUsageInfoImpl _$$AiUsageInfoImplFromJson(Map<String, dynamic> json) =>
    _$AiUsageInfoImpl(
      used: (json['used'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      remaining: (json['remaining'] as num).toInt(),
      resetsAt: DateTime.parse(json['resetsAt'] as String),
    );

Map<String, dynamic> _$$AiUsageInfoImplToJson(_$AiUsageInfoImpl instance) =>
    <String, dynamic>{
      'used': instance.used,
      'limit': instance.limit,
      'remaining': instance.remaining,
      'resetsAt': instance.resetsAt.toIso8601String(),
    };

_$GiftRecommendationImpl _$$GiftRecommendationImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftRecommendationImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      category: json['category'] as String,
      estimatedPrice:
          GiftPrice.fromJson(json['estimatedPrice'] as Map<String, dynamic>),
      personalizedReasoning: json['personalizedReasoning'] as String,
      whereToBuy: (json['whereToBuy'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      imageCategory: json['imageCategory'] as String,
      giftType: json['giftType'] as String,
      culturallyAppropriate: json['culturallyAppropriate'] as bool? ?? true,
      matchScore: (json['matchScore'] as num?)?.toDouble() ?? 0.0,
      pairsWith: (json['pairsWith'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GiftRecommendationImplToJson(
        _$GiftRecommendationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'estimatedPrice': instance.estimatedPrice,
      'personalizedReasoning': instance.personalizedReasoning,
      'whereToBuy': instance.whereToBuy,
      'imageCategory': instance.imageCategory,
      'giftType': instance.giftType,
      'culturallyAppropriate': instance.culturallyAppropriate,
      'matchScore': instance.matchScore,
      'pairsWith': instance.pairsWith,
    };

_$GiftPriceImpl _$$GiftPriceImplFromJson(Map<String, dynamic> json) =>
    _$GiftPriceImpl(
      min: (json['min'] as num).toDouble(),
      max: (json['max'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
    );

Map<String, dynamic> _$$GiftPriceImplToJson(_$GiftPriceImpl instance) =>
    <String, dynamic>{
      'min': instance.min,
      'max': instance.max,
      'currency': instance.currency,
    };

_$GiftRecommendationResponseImpl _$$GiftRecommendationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$GiftRecommendationResponseImpl(
      recommendations: (json['recommendations'] as List<dynamic>)
          .map((e) => GiftRecommendation.fromJson(e as Map<String, dynamic>))
          .toList(),
      metadata: AiMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      usage: AiUsageInfo.fromJson(json['usage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GiftRecommendationResponseImplToJson(
        _$GiftRecommendationResponseImpl instance) =>
    <String, dynamic>{
      'recommendations': instance.recommendations,
      'metadata': instance.metadata,
      'usage': instance.usage,
    };

_$SosActivateResponseImpl _$$SosActivateResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SosActivateResponseImpl(
      sessionId: json['sessionId'] as String,
      scenario: json['scenario'] as String,
      urgency: json['urgency'] as String,
      immediateAdvice: SosImmediateAdvice.fromJson(
          json['immediateAdvice'] as Map<String, dynamic>),
      severityAssessmentRequired:
          json['severityAssessmentRequired'] as bool? ?? true,
      estimatedResolutionSteps:
          (json['estimatedResolutionSteps'] as num?)?.toInt() ?? 4,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$SosActivateResponseImplToJson(
        _$SosActivateResponseImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'scenario': instance.scenario,
      'urgency': instance.urgency,
      'immediateAdvice': instance.immediateAdvice,
      'severityAssessmentRequired': instance.severityAssessmentRequired,
      'estimatedResolutionSteps': instance.estimatedResolutionSteps,
      'createdAt': instance.createdAt.toIso8601String(),
    };

_$SosImmediateAdviceImpl _$$SosImmediateAdviceImplFromJson(
        Map<String, dynamic> json) =>
    _$SosImmediateAdviceImpl(
      doNow: json['doNow'] as String,
      doNotDo: json['doNotDo'] as String,
      bodyLanguage: json['bodyLanguage'] as String,
    );

Map<String, dynamic> _$$SosImmediateAdviceImplToJson(
        _$SosImmediateAdviceImpl instance) =>
    <String, dynamic>{
      'doNow': instance.doNow,
      'doNotDo': instance.doNotDo,
      'bodyLanguage': instance.bodyLanguage,
    };

_$SosAssessResponseImpl _$$SosAssessResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SosAssessResponseImpl(
      sessionId: json['sessionId'] as String,
      severityScore: (json['severityScore'] as num).toInt(),
      severityLabel: json['severityLabel'] as String,
      coachingPlan: SosCoachingPlan.fromJson(
          json['coachingPlan'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SosAssessResponseImplToJson(
        _$SosAssessResponseImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'severityScore': instance.severityScore,
      'severityLabel': instance.severityLabel,
      'coachingPlan': instance.coachingPlan,
    };

_$SosCoachingPlanImpl _$$SosCoachingPlanImplFromJson(
        Map<String, dynamic> json) =>
    _$SosCoachingPlanImpl(
      totalSteps: (json['totalSteps'] as num).toInt(),
      estimatedMinutes: (json['estimatedMinutes'] as num).toInt(),
      approach: json['approach'] as String,
      keyInsight: json['keyInsight'] as String,
    );

Map<String, dynamic> _$$SosCoachingPlanImplToJson(
        _$SosCoachingPlanImpl instance) =>
    <String, dynamic>{
      'totalSteps': instance.totalSteps,
      'estimatedMinutes': instance.estimatedMinutes,
      'approach': instance.approach,
      'keyInsight': instance.keyInsight,
    };

_$SosCoachResponseImpl _$$SosCoachResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$SosCoachResponseImpl(
      sessionId: json['sessionId'] as String,
      stepNumber: (json['stepNumber'] as num).toInt(),
      totalSteps: (json['totalSteps'] as num).toInt(),
      coaching:
          SosCoachingContent.fromJson(json['coaching'] as Map<String, dynamic>),
      isLastStep: json['isLastStep'] as bool? ?? false,
      nextStepPrompt: json['nextStepPrompt'] as String?,
    );

Map<String, dynamic> _$$SosCoachResponseImplToJson(
        _$SosCoachResponseImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'stepNumber': instance.stepNumber,
      'totalSteps': instance.totalSteps,
      'coaching': instance.coaching,
      'isLastStep': instance.isLastStep,
      'nextStepPrompt': instance.nextStepPrompt,
    };

_$SosCoachingContentImpl _$$SosCoachingContentImplFromJson(
        Map<String, dynamic> json) =>
    _$SosCoachingContentImpl(
      sayThis: json['sayThis'] as String,
      whyItWorks: json['whyItWorks'] as String,
      doNotSay: (json['doNotSay'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      bodyLanguageTip: json['bodyLanguageTip'] as String?,
      toneAdvice: json['toneAdvice'] as String?,
      waitFor: json['waitFor'] as String?,
    );

Map<String, dynamic> _$$SosCoachingContentImplToJson(
        _$SosCoachingContentImpl instance) =>
    <String, dynamic>{
      'sayThis': instance.sayThis,
      'whyItWorks': instance.whyItWorks,
      'doNotSay': instance.doNotSay,
      'bodyLanguageTip': instance.bodyLanguageTip,
      'toneAdvice': instance.toneAdvice,
      'waitFor': instance.waitFor,
    };

_$ActionCardImpl _$$ActionCardImplFromJson(Map<String, dynamic> json) =>
    _$ActionCardImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ActionCardTypeEnumMap, json['type']),
      title: json['title'] as String,
      titleLocalized: json['titleLocalized'] as String?,
      description: json['description'] as String,
      descriptionLocalized: json['descriptionLocalized'] as String?,
      personalizedDetail: json['personalizedDetail'] as String?,
      difficulty: $enumDecode(_$CardDifficultyEnumMap, json['difficulty']),
      estimatedTime: json['estimatedTime'] as String?,
      xpReward: (json['xpReward'] as num?)?.toInt() ?? 0,
      status: $enumDecodeNullable(_$CardStatusEnumMap, json['status']) ??
          CardStatus.pending,
      contextTags: (json['contextTags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      expiresAt: json['expiresAt'] == null
          ? null
          : DateTime.parse(json['expiresAt'] as String),
    );

Map<String, dynamic> _$$ActionCardImplToJson(_$ActionCardImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ActionCardTypeEnumMap[instance.type]!,
      'title': instance.title,
      'titleLocalized': instance.titleLocalized,
      'description': instance.description,
      'descriptionLocalized': instance.descriptionLocalized,
      'personalizedDetail': instance.personalizedDetail,
      'difficulty': _$CardDifficultyEnumMap[instance.difficulty]!,
      'estimatedTime': instance.estimatedTime,
      'xpReward': instance.xpReward,
      'status': _$CardStatusEnumMap[instance.status]!,
      'contextTags': instance.contextTags,
      'expiresAt': instance.expiresAt?.toIso8601String(),
    };

const _$ActionCardTypeEnumMap = {
  ActionCardType.say: 'say',
  ActionCardType.do_: 'do_',
  ActionCardType.buy: 'buy',
  ActionCardType.go: 'go',
};

const _$CardDifficultyEnumMap = {
  CardDifficulty.easy: 'easy',
  CardDifficulty.medium: 'medium',
  CardDifficulty.challenging: 'challenging',
};

const _$CardStatusEnumMap = {
  CardStatus.pending: 'pending',
  CardStatus.completed: 'completed',
  CardStatus.skipped: 'skipped',
  CardStatus.saved: 'saved',
};

_$ActionCardsResponseImpl _$$ActionCardsResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ActionCardsResponseImpl(
      date: json['date'] as String,
      cards: (json['cards'] as List<dynamic>)
          .map((e) => ActionCard.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary:
          ActionCardSummary.fromJson(json['summary'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ActionCardsResponseImplToJson(
        _$ActionCardsResponseImpl instance) =>
    <String, dynamic>{
      'date': instance.date,
      'cards': instance.cards,
      'summary': instance.summary,
    };

_$ActionCardSummaryImpl _$$ActionCardSummaryImplFromJson(
        Map<String, dynamic> json) =>
    _$ActionCardSummaryImpl(
      totalCards: (json['totalCards'] as num?)?.toInt() ?? 0,
      completedToday: (json['completedToday'] as num?)?.toInt() ?? 0,
      totalXpAvailable: (json['totalXpAvailable'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$ActionCardSummaryImplToJson(
        _$ActionCardSummaryImpl instance) =>
    <String, dynamic>{
      'totalCards': instance.totalCards,
      'completedToday': instance.completedToday,
      'totalXpAvailable': instance.totalXpAvailable,
    };

_$CardCompleteResponseImpl _$$CardCompleteResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$CardCompleteResponseImpl(
      id: json['id'] as String,
      status: json['status'] as String,
      completedAt: DateTime.parse(json['completedAt'] as String),
      xpAwarded: (json['xpAwarded'] as num).toInt(),
      xpBreakdown:
          XpBreakdown.fromJson(json['xpBreakdown'] as Map<String, dynamic>),
      streakUpdate:
          StreakUpdate.fromJson(json['streakUpdate'] as Map<String, dynamic>),
      encouragement: json['encouragement'] as String?,
    );

Map<String, dynamic> _$$CardCompleteResponseImplToJson(
        _$CardCompleteResponseImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'completedAt': instance.completedAt.toIso8601String(),
      'xpAwarded': instance.xpAwarded,
      'xpBreakdown': instance.xpBreakdown,
      'streakUpdate': instance.streakUpdate,
      'encouragement': instance.encouragement,
    };

_$XpBreakdownImpl _$$XpBreakdownImplFromJson(Map<String, dynamic> json) =>
    _$XpBreakdownImpl(
      base: (json['base'] as num?)?.toInt() ?? 0,
      streakBonus: (json['streakBonus'] as num?)?.toInt() ?? 0,
      difficultyBonus: (json['difficultyBonus'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$XpBreakdownImplToJson(_$XpBreakdownImpl instance) =>
    <String, dynamic>{
      'base': instance.base,
      'streakBonus': instance.streakBonus,
      'difficultyBonus': instance.difficultyBonus,
    };

_$StreakUpdateImpl _$$StreakUpdateImplFromJson(Map<String, dynamic> json) =>
    _$StreakUpdateImpl(
      currentDays: (json['currentDays'] as num?)?.toInt() ?? 0,
      isActiveToday: json['isActiveToday'] as bool? ?? false,
    );

Map<String, dynamic> _$$StreakUpdateImplToJson(_$StreakUpdateImpl instance) =>
    <String, dynamic>{
      'currentDays': instance.currentDays,
      'isActiveToday': instance.isActiveToday,
    };
