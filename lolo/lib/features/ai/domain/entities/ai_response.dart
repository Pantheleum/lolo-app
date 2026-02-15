// FILE: lib/features/ai/domain/entities/ai_response.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

part 'ai_response.freezed.dart';
part 'ai_response.g.dart';

@freezed
class AiMessageResponse with _$AiMessageResponse {
  const factory AiMessageResponse({
    required String id,
    required String content,
    @Default([]) List<String> alternatives,
    required String mode,
    required String tone,
    required String length,
    required String language,
    required AiMetadata metadata,
    required String feedbackId,
    required AiUsageInfo usage,
    required DateTime createdAt,
  }) = _AiMessageResponse;

  factory AiMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$AiMessageResponseFromJson(json);
}

@freezed
class AiMetadata with _$AiMetadata {
  const factory AiMetadata({
    required String modelUsed,
    required int emotionalDepthScore,
    required int latencyMs,
    @Default(false) bool cached,
    @Default(false) bool wasFallback,
  }) = _AiMetadata;

  factory AiMetadata.fromJson(Map<String, dynamic> json) =>
      _$AiMetadataFromJson(json);
}

@freezed
class AiUsageInfo with _$AiUsageInfo {
  const factory AiUsageInfo({
    required int used,
    required int limit,
    required int remaining,
    required DateTime resetsAt,
  }) = _AiUsageInfo;

  factory AiUsageInfo.fromJson(Map<String, dynamic> json) =>
      _$AiUsageInfoFromJson(json);
}

@freezed
class GiftRecommendation with _$GiftRecommendation {
  const factory GiftRecommendation({
    required String id,
    required String name,
    required String description,
    required String category,
    required GiftPrice estimatedPrice,
    required String personalizedReasoning,
    required List<String> whereToBuy,
    required String imageCategory,
    required String giftType,
    @Default(true) bool culturallyAppropriate,
    @Default(0.0) double matchScore,
    @Default([]) List<String> pairsWith,
  }) = _GiftRecommendation;

  factory GiftRecommendation.fromJson(Map<String, dynamic> json) =>
      _$GiftRecommendationFromJson(json);
}

@freezed
class GiftPrice with _$GiftPrice {
  const factory GiftPrice({
    required double min,
    required double max,
    @Default('USD') String currency,
  }) = _GiftPrice;

  factory GiftPrice.fromJson(Map<String, dynamic> json) =>
      _$GiftPriceFromJson(json);
}

@freezed
class GiftRecommendationResponse with _$GiftRecommendationResponse {
  const factory GiftRecommendationResponse({
    required List<GiftRecommendation> recommendations,
    required AiMetadata metadata,
    required AiUsageInfo usage,
  }) = _GiftRecommendationResponse;

  factory GiftRecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$GiftRecommendationResponseFromJson(json);
}

@freezed
class SosActivateResponse with _$SosActivateResponse {
  const factory SosActivateResponse({
    required String sessionId,
    required String scenario,
    required String urgency,
    required SosImmediateAdvice immediateAdvice,
    @Default(true) bool severityAssessmentRequired,
    @Default(4) int estimatedResolutionSteps,
    required DateTime createdAt,
  }) = _SosActivateResponse;

  factory SosActivateResponse.fromJson(Map<String, dynamic> json) =>
      _$SosActivateResponseFromJson(json);
}

@freezed
class SosImmediateAdvice with _$SosImmediateAdvice {
  const factory SosImmediateAdvice({
    required String doNow,
    required String doNotDo,
    required String bodyLanguage,
  }) = _SosImmediateAdvice;

  factory SosImmediateAdvice.fromJson(Map<String, dynamic> json) =>
      _$SosImmediateAdviceFromJson(json);
}

@freezed
class SosAssessResponse with _$SosAssessResponse {
  const factory SosAssessResponse({
    required String sessionId,
    required int severityScore,
    required String severityLabel,
    required SosCoachingPlan coachingPlan,
  }) = _SosAssessResponse;

  factory SosAssessResponse.fromJson(Map<String, dynamic> json) =>
      _$SosAssessResponseFromJson(json);
}

@freezed
class SosCoachingPlan with _$SosCoachingPlan {
  const factory SosCoachingPlan({
    required int totalSteps,
    required int estimatedMinutes,
    required String approach,
    required String keyInsight,
  }) = _SosCoachingPlan;

  factory SosCoachingPlan.fromJson(Map<String, dynamic> json) =>
      _$SosCoachingPlanFromJson(json);
}

@freezed
class SosCoachResponse with _$SosCoachResponse {
  const factory SosCoachResponse({
    required String sessionId,
    required int stepNumber,
    required int totalSteps,
    required SosCoachingContent coaching,
    @Default(false) bool isLastStep,
    String? nextStepPrompt,
  }) = _SosCoachResponse;

  factory SosCoachResponse.fromJson(Map<String, dynamic> json) =>
      _$SosCoachResponseFromJson(json);
}

@freezed
class SosCoachingContent with _$SosCoachingContent {
  const factory SosCoachingContent({
    required String sayThis,
    required String whyItWorks,
    @Default([]) List<String> doNotSay,
    String? bodyLanguageTip,
    String? toneAdvice,
    String? waitFor,
  }) = _SosCoachingContent;

  factory SosCoachingContent.fromJson(Map<String, dynamic> json) =>
      _$SosCoachingContentFromJson(json);
}

@freezed
class ActionCard with _$ActionCard {
  const factory ActionCard({
    required String id,
    required ActionCardType type,
    required String title,
    String? titleLocalized,
    required String description,
    String? descriptionLocalized,
    String? personalizedDetail,
    required CardDifficulty difficulty,
    String? estimatedTime,
    @Default(0) int xpReward,
    @Default(CardStatus.pending) CardStatus status,
    @Default([]) List<String> contextTags,
    DateTime? expiresAt,
  }) = _ActionCard;

  factory ActionCard.fromJson(Map<String, dynamic> json) =>
      _$ActionCardFromJson(json);
}

@freezed
class ActionCardsResponse with _$ActionCardsResponse {
  const factory ActionCardsResponse({
    required String date,
    required List<ActionCard> cards,
    required ActionCardSummary summary,
  }) = _ActionCardsResponse;

  factory ActionCardsResponse.fromJson(Map<String, dynamic> json) =>
      _$ActionCardsResponseFromJson(json);
}

@freezed
class ActionCardSummary with _$ActionCardSummary {
  const factory ActionCardSummary({
    @Default(0) int totalCards,
    @Default(0) int completedToday,
    @Default(0) int totalXpAvailable,
  }) = _ActionCardSummary;

  factory ActionCardSummary.fromJson(Map<String, dynamic> json) =>
      _$ActionCardSummaryFromJson(json);
}

@freezed
class CardCompleteResponse with _$CardCompleteResponse {
  const factory CardCompleteResponse({
    required String id,
    required String status,
    required DateTime completedAt,
    required int xpAwarded,
    required XpBreakdown xpBreakdown,
    required StreakUpdate streakUpdate,
    String? encouragement,
  }) = _CardCompleteResponse;

  factory CardCompleteResponse.fromJson(Map<String, dynamic> json) =>
      _$CardCompleteResponseFromJson(json);
}

@freezed
class XpBreakdown with _$XpBreakdown {
  const factory XpBreakdown({
    @Default(0) int base,
    @Default(0) int streakBonus,
    @Default(0) int difficultyBonus,
  }) = _XpBreakdown;

  factory XpBreakdown.fromJson(Map<String, dynamic> json) =>
      _$XpBreakdownFromJson(json);
}

@freezed
class StreakUpdate with _$StreakUpdate {
  const factory StreakUpdate({
    @Default(0) int currentDays,
    @Default(false) bool isActiveToday,
  }) = _StreakUpdate;

  factory StreakUpdate.fromJson(Map<String, dynamic> json) =>
      _$StreakUpdateFromJson(json);
}
