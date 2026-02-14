# LOLO Sprint 3 -- Flutter AI Router Client Implementation

**Document ID:** LOLO-DEV-S3-002
**Author:** Dr. Aisha Mahmoud, AI/ML Engineer
**Date:** 2026-02-15
**Version:** 1.0
**Classification:** Internal -- Confidential
**Sprint:** Sprint 3 -- AI Engine (Weeks 13-14)
**Dependencies:** AI Strategy (LOLO-AI-001), API Contracts v1.0, Tech Lead UI Screens (S3-01), Domain Expert Review (S3-001)

---

> **Purpose:** Production-ready Dart implementation of the Flutter-side AI service layer. This code communicates exclusively with the backend AI Router (`/api/v1/ai/*`) -- the client never calls AI models directly. Covers request/response DTOs, repository layer, Riverpod providers, caching, cost tracking, and content safety filtering.

---

## Part 1: AI Service Layer

### 1.1 Enums and Value Objects

#### `lib/features/ai/domain/enums/ai_enums.dart`

```dart
// FILE: lib/features/ai/domain/enums/ai_enums.dart

enum AiMessageMode {
  goodMorning('good_morning', 1),
  checkingIn('checking_in', 1),
  appreciation('appreciation', 2),
  motivation('motivation', 2),
  celebration('celebration', 2),
  flirting('flirting', 2),
  reassurance('reassurance', 3),
  longDistance('long_distance', 3),
  apology('apology', 4),
  afterArgument('after_argument', 4);

  const AiMessageMode(this.apiValue, this.baseDepth);
  final String apiValue;
  final int baseDepth;

  static AiMessageMode fromApi(String value) =>
      AiMessageMode.values.firstWhere((e) => e.apiValue == value,
          orElse: () => AiMessageMode.checkingIn);
}

enum AiRequestType {
  message('message'),
  actionCard('action_card'),
  gift('gift'),
  sosCoaching('sos_coaching'),
  sosAssessment('sos_assessment'),
  analysis('analysis'),
  memoryQuery('memory_query');

  const AiRequestType(this.apiValue);
  final String apiValue;
}

enum AiTone {
  warm('warm'),
  playful('playful'),
  serious('serious'),
  romantic('romantic'),
  gentle('gentle'),
  confident('confident');

  const AiTone(this.apiValue);
  final String apiValue;

  static AiTone fromApi(String v) =>
      AiTone.values.firstWhere((e) => e.apiValue == v, orElse: () => AiTone.warm);
}

enum AiLength {
  short('short'),
  medium('medium'),
  long_('long');

  const AiLength(this.apiValue);
  final String apiValue;

  static AiLength fromApi(String v) =>
      AiLength.values.firstWhere((e) => e.apiValue == v, orElse: () => AiLength.medium);
}

enum SubscriptionTier {
  free('free', 10, 2, 3, 5),
  pro('pro', 100, 10, 10, 30),
  legend('legend', -1, -1, -1, -1); // -1 = unlimited

  const SubscriptionTier(
      this.apiValue, this.monthlyMessages, this.monthlySos, this.dailyCards, this.monthlyGifts);
  final String apiValue;
  final int monthlyMessages;
  final int monthlySos;
  final int dailyCards;
  final int monthlyGifts;

  bool get isUnlimited => this == SubscriptionTier.legend;

  static SubscriptionTier fromApi(String v) =>
      SubscriptionTier.values.firstWhere((e) => e.apiValue == v,
          orElse: () => SubscriptionTier.free);
}

enum EmotionalState {
  happy, stressed, sad, angry, anxious, neutral, excited, tired, overwhelmed, vulnerable;

  bool get increasesDepth => this == angry || this == anxious;
}

enum CyclePhase {
  follicular, ovulation, lutealEarly, lutealLate, menstruation, unknown;

  String get apiValue => switch (this) {
        CyclePhase.follicular => 'follicular',
        CyclePhase.ovulation => 'ovulation',
        CyclePhase.lutealEarly => 'luteal_early',
        CyclePhase.lutealLate => 'luteal_late',
        CyclePhase.menstruation => 'menstruation',
        CyclePhase.unknown => 'unknown',
      };

  bool get increasesDepth => this == CyclePhase.lutealLate;
}

enum SosScenario {
  sheIsAngry('she_is_angry'),
  sheIsCrying('she_is_crying'),
  sheIsSilent('she_is_silent'),
  caughtInLie('caught_in_lie'),
  forgotImportantDate('forgot_important_date'),
  saidWrongThing('said_wrong_thing'),
  sheWantsToTalk('she_wants_to_talk'),
  herFamilyConflict('her_family_conflict'),
  jealousyIssue('jealousy_issue'),
  other('other');

  const SosScenario(this.apiValue);
  final String apiValue;
}

enum SosUrgency {
  happeningNow('happening_now'),
  justHappened('just_happened'),
  brewing('brewing');

  const SosUrgency(this.apiValue);
  final String apiValue;
}

enum GiftOccasion {
  birthday('birthday'),
  anniversary('anniversary'),
  eid('eid'),
  valentines('valentines'),
  justBecause('just_because'),
  apology('apology'),
  congratulations('congratulations'),
  hariRaya('hari_raya'),
  christmas('christmas'),
  other('other');

  const GiftOccasion(this.apiValue);
  final String apiValue;
}

enum GiftType {
  physical('physical'),
  experience('experience'),
  digital('digital'),
  handmade('handmade'),
  any('any');

  const GiftType(this.apiValue);
  final String apiValue;
}

enum ActionCardType {
  say('say'),
  do_('do'),
  buy('buy'),
  go('go');

  const ActionCardType(this.apiValue);
  final String apiValue;

  static ActionCardType fromApi(String v) =>
      ActionCardType.values.firstWhere((e) => e.apiValue == v,
          orElse: () => ActionCardType.do_);
}

enum CardDifficulty {
  easy, medium, challenging;

  static CardDifficulty fromApi(String v) => switch (v) {
        'easy' => CardDifficulty.easy,
        'medium' => CardDifficulty.medium,
        'challenging' => CardDifficulty.challenging,
        _ => CardDifficulty.medium,
      };
}

enum CardStatus {
  pending, completed, skipped, saved;

  static CardStatus fromApi(String v) => switch (v) {
        'completed' => CardStatus.completed,
        'skipped' => CardStatus.skipped,
        'saved' => CardStatus.saved,
        _ => CardStatus.pending,
      };
}
```

### 1.2 Request/Response DTOs

#### `lib/features/ai/domain/entities/ai_request.dart`

```dart
// FILE: lib/features/ai/domain/entities/ai_request.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

part 'ai_request.freezed.dart';
part 'ai_request.g.dart';

@freezed
class AiMessageRequest with _$AiMessageRequest {
  const factory AiMessageRequest({
    required AiMessageMode mode,
    required AiTone tone,
    required AiLength length,
    required String profileId,
    String? additionalContext,
    EmotionalState? emotionalState,
    int? situationSeverity,
    @Default(false) bool includeAlternatives,
  }) = _AiMessageRequest;

  factory AiMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$AiMessageRequestFromJson(json);
}

@freezed
class GiftRecommendationRequest with _$GiftRecommendationRequest {
  const factory GiftRecommendationRequest({
    required String profileId,
    required GiftOccasion occasion,
    String? occasionDetails,
    required double budgetMin,
    required double budgetMax,
    @Default('USD') String currency,
    @Default(GiftType.any) GiftType giftType,
    @Default([]) List<String> excludeCategories,
    @Default(5) int count,
  }) = _GiftRecommendationRequest;

  factory GiftRecommendationRequest.fromJson(Map<String, dynamic> json) =>
      _$GiftRecommendationRequestFromJson(json);
}

@freezed
class SosActivateRequest with _$SosActivateRequest {
  const factory SosActivateRequest({
    required SosScenario scenario,
    required SosUrgency urgency,
    String? briefContext,
    String? profileId,
  }) = _SosActivateRequest;

  factory SosActivateRequest.fromJson(Map<String, dynamic> json) =>
      _$SosActivateRequestFromJson(json);
}

@freezed
class SosAssessRequest with _$SosAssessRequest {
  const factory SosAssessRequest({
    required String sessionId,
    required SosAssessmentAnswers answers,
  }) = _SosAssessRequest;

  factory SosAssessRequest.fromJson(Map<String, dynamic> json) =>
      _$SosAssessRequestFromJson(json);
}

@freezed
class SosAssessmentAnswers with _$SosAssessmentAnswers {
  const factory SosAssessmentAnswers({
    required String howLongAgo,
    required String herCurrentState,
    required bool haveYouSpoken,
    required bool isSheTalking,
    required String yourFault,
    bool? previousSimilar,
    String? additionalContext,
  }) = _SosAssessmentAnswers;

  factory SosAssessmentAnswers.fromJson(Map<String, dynamic> json) =>
      _$SosAssessmentAnswersFromJson(json);
}

@freezed
class SosCoachRequest with _$SosCoachRequest {
  const factory SosCoachRequest({
    required String sessionId,
    required int stepNumber,
    String? userUpdate,
    String? herResponse,
    @Default(false) bool stream,
  }) = _SosCoachRequest;

  factory SosCoachRequest.fromJson(Map<String, dynamic> json) =>
      _$SosCoachRequestFromJson(json);
}
```

#### `lib/features/ai/domain/entities/ai_response.dart`

```dart
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
```

### 1.3 Emotional Depth Calculator

#### `lib/features/ai/domain/services/emotional_depth_calculator.dart`

```dart
// FILE: lib/features/ai/domain/services/emotional_depth_calculator.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class EmotionalDepthCalculator {
  const EmotionalDepthCalculator._();

  static int calculate({
    required AiMessageMode mode,
    EmotionalState? emotionalState,
    CyclePhase? cyclePhase,
    bool isPregnant = false,
    int? trimester,
    int? situationSeverity,
  }) {
    int score = mode.baseDepth;

    if (emotionalState != null && emotionalState.increasesDepth) {
      score++;
    }

    if (cyclePhase != null && cyclePhase.increasesDepth) {
      score++;
    }

    if (isPregnant && trimester == 1) {
      score++;
    }

    if (situationSeverity != null && situationSeverity >= 4) {
      score++;
    }

    return score.clamp(1, 5);
  }

  /// SOS always returns depth 5
  static int forSos() => 5;
}
```

### 1.4 Repository Interface

#### `lib/features/ai/domain/repositories/ai_repository.dart`

```dart
// FILE: lib/features/ai/domain/repositories/ai_repository.dart

import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

abstract class AiRepository {
  // --- Messages ---
  Future<Either<Failure, AiMessageResponse>> generateMessage(AiMessageRequest request);
  Future<Either<Failure, List<AiMessageResponse>>> getMessageHistory({
    AiMessageMode? mode,
    bool? favoritesOnly,
    int limit = 20,
    String? lastDocId,
  });
  Future<Either<Failure, void>> toggleFavorite(String messageId, bool isFavorited);
  Future<Either<Failure, void>> submitFeedback(String messageId, String feedback);

  // --- Gifts ---
  Future<Either<Failure, GiftRecommendationResponse>> getGiftRecommendations(
      GiftRecommendationRequest request);
  Future<Either<Failure, void>> submitGiftFeedback(String giftId, String outcome,
      {String? comment});

  // --- SOS ---
  Future<Either<Failure, SosActivateResponse>> activateSos(SosActivateRequest request);
  Future<Either<Failure, SosAssessResponse>> assessSos(SosAssessRequest request);
  Future<Either<Failure, SosCoachResponse>> getCoaching(SosCoachRequest request);
  Stream<SosCoachingEvent> streamCoaching(SosCoachRequest request);

  // --- Action Cards ---
  Future<Either<Failure, ActionCardsResponse>> getDailyCards({
    String? date,
    bool forceRefresh = false,
  });
  Future<Either<Failure, CardCompleteResponse>> completeCard(String cardId, {String? notes});
  Future<Either<Failure, ActionCard?>> skipCard(String cardId, {String? reason});
  Future<Either<Failure, void>> saveCard(String cardId);

  // --- Usage ---
  Future<Either<Failure, AiUsageInfo>> getUsage(AiRequestType type);
}

class SosCoachingEvent {
  final String eventType;
  final Map<String, dynamic> data;
  const SosCoachingEvent({required this.eventType, required this.data});
}
```

### 1.5 Repository Implementation

#### `lib/features/ai/data/repositories/ai_repository_impl.dart`

```dart
// FILE: lib/features/ai/data/repositories/ai_repository_impl.dart

import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/network/api_client.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';
import 'package:lolo/features/ai/data/services/content_safety_filter.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final ApiClient _api;
  final AiCacheManager _cache;
  final ContentSafetyFilter _safety;

  AiRepositoryImpl({
    required ApiClient api,
    required AiCacheManager cache,
    required ContentSafetyFilter safety,
  })  : _api = api,
        _cache = cache,
        _safety = safety;

  // --- Messages ---

  @override
  Future<Either<Failure, AiMessageResponse>> generateMessage(
      AiMessageRequest request) async {
    try {
      final validation = _safety.validateInput(request.additionalContext);
      if (!validation.isValid) {
        return Left(ContentSafetyFailure(validation.reason ?? 'Content blocked'));
      }

      final cacheKey = _cache.messageKey(
        mode: request.mode.apiValue,
        tone: request.tone.apiValue,
        context: request.additionalContext,
      );
      final cached = await _cache.get<AiMessageResponse>(cacheKey);
      if (cached != null) return Right(cached);

      final response = await _api.post('/ai/messages/generate', data: {
        'mode': request.mode.apiValue,
        'tone': request.tone.apiValue,
        'length': request.length.apiValue,
        'profileId': request.profileId,
        if (request.additionalContext != null)
          'additionalContext': request.additionalContext,
        if (request.emotionalState != null)
          'emotionalState': request.emotionalState!.name,
        if (request.situationSeverity != null)
          'situationSeverity': request.situationSeverity,
        'includeAlternatives': request.includeAlternatives,
      });

      final result = AiMessageResponse.fromJson(response.data['data']);

      final postValidation = _safety.validateOutput(result.content);
      if (!postValidation.isValid) {
        return Left(ContentSafetyFailure(postValidation.reason ?? 'Response blocked'));
      }

      final ttl = _cache.ttlForMode(request.mode);
      if (ttl > Duration.zero) {
        await _cache.put(cacheKey, result, ttl: ttl);
      }

      return Right(result);
    } on TierLimitException catch (e) {
      return Left(TierLimitFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AiMessageResponse>>> getMessageHistory({
    AiMessageMode? mode,
    bool? favoritesOnly,
    int limit = 20,
    String? lastDocId,
  }) async {
    try {
      final response = await _api.get('/ai/messages/history', queryParameters: {
        if (mode != null) 'mode': mode.apiValue,
        if (favoritesOnly != null) 'favorited': favoritesOnly,
        'limit': limit,
        if (lastDocId != null) 'lastDocId': lastDocId,
      });
      final list = (response.data['data'] as List)
          .map((e) => AiMessageResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String messageId, bool isFavorited) async {
    try {
      await _api.post('/ai/messages/$messageId/favorite', data: {
        'isFavorited': isFavorited,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> submitFeedback(String messageId, String feedback) async {
    try {
      await _api.post('/ai/messages/$messageId/feedback', data: {
        'feedback': feedback,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- Gifts ---

  @override
  Future<Either<Failure, GiftRecommendationResponse>> getGiftRecommendations(
      GiftRecommendationRequest request) async {
    try {
      final cacheKey = _cache.giftKey(
        occasion: request.occasion.apiValue,
        budgetMin: request.budgetMin,
        budgetMax: request.budgetMax,
      );
      final cached = await _cache.get<GiftRecommendationResponse>(cacheKey);
      if (cached != null) return Right(cached);

      final response = await _api.post('/gifts/recommend', data: {
        'profileId': request.profileId,
        'occasion': request.occasion.apiValue,
        if (request.occasionDetails != null) 'occasionDetails': request.occasionDetails,
        'budgetMin': request.budgetMin,
        'budgetMax': request.budgetMax,
        'currency': request.currency,
        'giftType': request.giftType.apiValue,
        if (request.excludeCategories.isNotEmpty)
          'excludeCategories': request.excludeCategories,
        'count': request.count,
      });

      final result = GiftRecommendationResponse.fromJson(response.data['data']);
      await _cache.put(cacheKey, result, ttl: const Duration(hours: 24));
      return Right(result);
    } on TierLimitException catch (e) {
      return Left(TierLimitFailure(e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitGiftFeedback(
      String giftId, String outcome, {String? comment}) async {
    try {
      await _api.post('/gifts/$giftId/feedback', data: {
        'outcome': outcome,
        if (comment != null) 'comment': comment,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- SOS ---

  @override
  Future<Either<Failure, SosActivateResponse>> activateSos(
      SosActivateRequest request) async {
    try {
      final response = await _api.post('/sos/activate', data: {
        'scenario': request.scenario.apiValue,
        'urgency': request.urgency.apiValue,
        if (request.briefContext != null) 'briefContext': request.briefContext,
        if (request.profileId != null) 'profileId': request.profileId,
      });
      return Right(SosActivateResponse.fromJson(response.data['data']));
    } on TierLimitException catch (e) {
      return Left(TierLimitFailure(e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, SosAssessResponse>> assessSos(SosAssessRequest request) async {
    try {
      final response = await _api.post('/sos/assess', data: {
        'sessionId': request.sessionId,
        'answers': request.answers.toJson(),
      });
      return Right(SosAssessResponse.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, SosCoachResponse>> getCoaching(SosCoachRequest request) async {
    try {
      final response = await _api.post('/sos/coach', data: {
        'sessionId': request.sessionId,
        'stepNumber': request.stepNumber,
        if (request.userUpdate != null) 'userUpdate': request.userUpdate,
        if (request.herResponse != null) 'herResponse': request.herResponse,
        'stream': false,
      });
      return Right(SosCoachResponse.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Stream<SosCoachingEvent> streamCoaching(SosCoachRequest request) async* {
    try {
      final response = await _api.post(
        '/sos/coach',
        data: {
          'sessionId': request.sessionId,
          'stepNumber': request.stepNumber,
          if (request.userUpdate != null) 'userUpdate': request.userUpdate,
          if (request.herResponse != null) 'herResponse': request.herResponse,
          'stream': true,
        },
        options: Options(
          headers: {'Accept': 'text/event-stream'},
          responseType: ResponseType.stream,
        ),
      );

      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';

      await for (final chunk in stream) {
        buffer += utf8.decode(chunk);
        final lines = buffer.split('\n');
        buffer = lines.removeLast();

        String? currentEvent;
        for (final line in lines) {
          if (line.startsWith('event: ')) {
            currentEvent = line.substring(7).trim();
          } else if (line.startsWith('data: ') && currentEvent != null) {
            final jsonStr = line.substring(6).trim();
            if (jsonStr.isNotEmpty) {
              try {
                final data = jsonDecode(jsonStr) as Map<String, dynamic>;
                yield SosCoachingEvent(eventType: currentEvent, data: data);
              } catch (_) {}
            }
            currentEvent = null;
          }
        }
      }
    } catch (e) {
      yield SosCoachingEvent(eventType: 'error', data: {'message': e.toString()});
    }
  }

  // --- Action Cards ---

  @override
  Future<Either<Failure, ActionCardsResponse>> getDailyCards({
    String? date,
    bool forceRefresh = false,
  }) async {
    try {
      final effectiveDate = date ?? DateTime.now().toIso8601String().substring(0, 10);

      if (!forceRefresh) {
        final cacheKey = 'cards:$effectiveDate';
        final cached = await _cache.get<ActionCardsResponse>(cacheKey);
        if (cached != null) return Right(cached);
      }

      final response = await _api.get('/action-cards', queryParameters: {
        'date': date,
        if (forceRefresh) 'forceRefresh': true,
      });

      final result = ActionCardsResponse.fromJson(response.data['data']);
      await _cache.put('cards:$effectiveDate', result,
          ttl: const Duration(hours: 12));
      return Right(result);
    } on TierLimitException catch (e) {
      return Left(TierLimitFailure(e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, CardCompleteResponse>> completeCard(
      String cardId, {String? notes}) async {
    try {
      final response = await _api.post('/action-cards/$cardId/complete', data: {
        if (notes != null) 'notes': notes,
      });
      _cache.invalidatePattern('cards:');
      return Right(CardCompleteResponse.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, ActionCard?>> skipCard(
      String cardId, {String? reason}) async {
    try {
      final response = await _api.post('/action-cards/$cardId/skip', data: {
        if (reason != null) 'reason': reason,
      });
      _cache.invalidatePattern('cards:');
      final replacement = response.data['data']['replacementCard'];
      if (replacement != null) {
        return Right(ActionCard.fromJson(replacement));
      }
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> saveCard(String cardId) async {
    try {
      await _api.post('/action-cards/$cardId/save');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- Usage ---

  @override
  Future<Either<Failure, AiUsageInfo>> getUsage(AiRequestType type) async {
    try {
      final response = await _api.get('/ai/usage', queryParameters: {
        'type': type.apiValue,
      });
      return Right(AiUsageInfo.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- Error Mapping ---

  Failure _mapDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final errorCode = e.response?.data?['error']?['code'] as String?;
    final errorMsg =
        e.response?.data?['error']?['message'] as String? ?? e.message ?? 'Unknown error';

    return switch (statusCode) {
      400 => ValidationFailure(errorMsg),
      401 => AuthFailure(errorMsg),
      403 when errorCode == 'TIER_LIMIT_EXCEEDED' => TierLimitFailure(errorMsg),
      403 => PermissionFailure(errorMsg),
      404 => NotFoundFailure(errorMsg),
      429 => RateLimitFailure(errorMsg,
          retryAfter: int.tryParse(
              e.response?.headers.value('retry-after') ?? '')),
      503 => AiServiceUnavailableFailure(errorMsg),
      _ => ServerFailure(errorMsg),
    };
  }
}
```

### 1.6 Failure Types

#### `lib/features/ai/domain/failures/ai_failures.dart`

```dart
// FILE: lib/features/ai/domain/failures/ai_failures.dart

import 'package:lolo/core/errors/failures.dart';

class TierLimitFailure extends Failure {
  const TierLimitFailure(super.message);
}

class ContentSafetyFailure extends Failure {
  const ContentSafetyFailure(super.message);
}

class RateLimitFailure extends Failure {
  final int? retryAfter;
  const RateLimitFailure(super.message, {this.retryAfter});
}

class AiServiceUnavailableFailure extends Failure {
  const AiServiceUnavailableFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
```

### 1.7 Prompt Context Builder

#### `lib/features/ai/data/services/prompt_context_builder.dart`

```dart
// FILE: lib/features/ai/data/services/prompt_context_builder.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class PromptContextBuilder {
  String? _partnerName;
  String? _userName;
  String? _zodiacSign;
  String? _loveLanguage;
  String? _communicationStyle;
  String? _culturalBackground;
  String? _religiousObservance;
  EmotionalState? _emotionalState;
  CyclePhase? _cyclePhase;
  bool _isPregnant = false;
  int? _trimester;
  String? _relationshipStatus;
  int? _relationshipDurationMonths;
  int? _humorLevel;
  String? _humorType;
  List<String> _recentMemories = [];
  List<String> _upcomingEvents = [];
  String _language = 'en';
  String? _dialect;

  PromptContextBuilder();

  PromptContextBuilder partnerProfile({
    required String partnerName,
    String? zodiacSign,
    String? loveLanguage,
    String? communicationStyle,
    String? culturalBackground,
    String? religiousObservance,
    int? humorLevel,
    String? humorType,
  }) {
    _partnerName = partnerName;
    _zodiacSign = zodiacSign;
    _loveLanguage = loveLanguage;
    _communicationStyle = communicationStyle;
    _culturalBackground = culturalBackground;
    _religiousObservance = religiousObservance;
    _humorLevel = humorLevel;
    _humorType = humorType;
    return this;
  }

  PromptContextBuilder userName(String name) {
    _userName = name;
    return this;
  }

  PromptContextBuilder relationship({
    required String status,
    int? durationMonths,
  }) {
    _relationshipStatus = status;
    _relationshipDurationMonths = durationMonths;
    return this;
  }

  PromptContextBuilder emotional(EmotionalState? state) {
    _emotionalState = state;
    return this;
  }

  PromptContextBuilder hormonal({
    CyclePhase? cyclePhase,
    bool isPregnant = false,
    int? trimester,
  }) {
    _cyclePhase = cyclePhase;
    _isPregnant = isPregnant;
    _trimester = trimester;
    return this;
  }

  PromptContextBuilder memories(List<String> memories) {
    _recentMemories = memories.take(5).toList();
    return this;
  }

  PromptContextBuilder calendar(List<String> events) {
    _upcomingEvents = events.take(3).toList();
    return this;
  }

  PromptContextBuilder locale({required String language, String? dialect}) {
    _language = language;
    _dialect = dialect;
    return this;
  }

  Map<String, dynamic> build() {
    return {
      if (_partnerName != null) 'partnerName': _partnerName,
      if (_userName != null) 'userName': _userName,
      if (_zodiacSign != null) 'zodiacSign': _zodiacSign,
      if (_loveLanguage != null) 'loveLanguage': _loveLanguage,
      if (_communicationStyle != null) 'communicationStyle': _communicationStyle,
      if (_culturalBackground != null) 'culturalBackground': _culturalBackground,
      if (_religiousObservance != null) 'religiousObservance': _religiousObservance,
      if (_emotionalState != null) 'emotionalState': _emotionalState!.name,
      if (_cyclePhase != null) 'cyclePhase': _cyclePhase!.apiValue,
      'isPregnant': _isPregnant,
      if (_trimester != null) 'trimester': _trimester,
      if (_relationshipStatus != null) 'relationshipStatus': _relationshipStatus,
      if (_relationshipDurationMonths != null)
        'relationshipDurationMonths': _relationshipDurationMonths,
      if (_humorLevel != null) 'humorLevel': _humorLevel,
      if (_humorType != null) 'humorType': _humorType,
      if (_recentMemories.isNotEmpty) 'recentMemories': _recentMemories,
      if (_upcomingEvents.isNotEmpty) 'upcomingEvents': _upcomingEvents,
      'language': _language,
      if (_dialect != null) 'dialect': _dialect,
    };
  }

  int computeEmotionalDepth(AiMessageMode mode) {
    return EmotionalDepthCalculator.calculate(
      mode: mode,
      emotionalState: _emotionalState,
      cyclePhase: _cyclePhase,
      isPregnant: _isPregnant,
      trimester: _trimester,
    );
  }
}

class EmotionalDepthCalculator {
  static int calculate({
    required AiMessageMode mode,
    EmotionalState? emotionalState,
    CyclePhase? cyclePhase,
    bool isPregnant = false,
    int? trimester,
    int? situationSeverity,
  }) {
    int score = mode.baseDepth;
    if (emotionalState != null && emotionalState.increasesDepth) score++;
    if (cyclePhase != null && cyclePhase.increasesDepth) score++;
    if (isPregnant && trimester == 1) score++;
    if (situationSeverity != null && situationSeverity >= 4) score++;
    return score.clamp(1, 5);
  }
}
```

---

## Part 2: Riverpod Providers + Services

### 2.1 Provider Registration

#### `lib/features/ai/presentation/providers/ai_providers.dart`

```dart
// FILE: lib/features/ai/presentation/providers/ai_providers.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/network/api_client.dart';
import 'package:lolo/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';
import 'package:lolo/features/ai/data/services/content_safety_filter.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
AiCacheManager aiCacheManager(AiCacheManagerRef ref) {
  return AiCacheManager();
}

@Riverpod(keepAlive: true)
ContentSafetyFilter contentSafetyFilter(ContentSafetyFilterRef ref) {
  return ContentSafetyFilter();
}

@Riverpod(keepAlive: true)
AiRepository aiRepository(AiRepositoryRef ref) {
  return AiRepositoryImpl(
    api: ref.watch(apiClientProvider),
    cache: ref.watch(aiCacheManagerProvider),
    safety: ref.watch(contentSafetyFilterProvider),
  );
}
```

### 2.2 Message Generation Provider

#### `lib/features/ai/presentation/providers/message_generation_provider.dart`

```dart
// FILE: lib/features/ai/presentation/providers/message_generation_provider.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';

part 'message_generation_provider.freezed.dart';
part 'message_generation_provider.g.dart';

@freezed
class MessageGenState with _$MessageGenState {
  const factory MessageGenState.idle() = _Idle;
  const factory MessageGenState.generating({String? statusText}) = _Generating;
  const factory MessageGenState.success(AiMessageResponse response) = _Success;
  const factory MessageGenState.tierLimitReached({
    required int used,
    required int limit,
  }) = _TierLimitReached;
  const factory MessageGenState.error(String message) = _Error;
}

@riverpod
class MessageGenerator extends _$MessageGenerator {
  @override
  MessageGenState build() => const MessageGenState.idle();

  Future<void> generate({
    required AiMessageMode mode,
    required AiTone tone,
    required AiLength length,
    required String profileId,
    String? additionalContext,
    EmotionalState? emotionalState,
    int? situationSeverity,
    bool includeAlternatives = false,
  }) async {
    final costTracker = ref.read(costTrackerProvider.notifier);
    final canProceed = await costTracker.checkLimit(AiRequestType.message);
    if (!canProceed) {
      final usage = costTracker.currentUsage;
      state = MessageGenState.tierLimitReached(
        used: usage?.used ?? 0,
        limit: usage?.limit ?? 0,
      );
      return;
    }

    state = const MessageGenState.generating(statusText: 'Crafting your message...');

    final request = AiMessageRequest(
      mode: mode,
      tone: tone,
      length: length,
      profileId: profileId,
      additionalContext: additionalContext,
      emotionalState: emotionalState,
      situationSeverity: situationSeverity,
      includeAlternatives: includeAlternatives,
    );

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.generateMessage(request);

    state = result.fold(
      (failure) => MessageGenState.error(failure.message),
      (response) {
        costTracker.recordUsage(AiRequestType.message, response.usage);
        return MessageGenState.success(response);
      },
    );
  }

  Future<void> toggleFavorite(String messageId, bool currentState) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.toggleFavorite(messageId, !currentState);
  }

  Future<void> submitFeedback(String messageId, String feedback) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.submitFeedback(messageId, feedback);
  }

  void reset() => state = const MessageGenState.idle();
}

@riverpod
class MessageHistory extends _$MessageHistory {
  static const _pageSize = 20;
  String? _lastDocId;
  bool _hasMore = true;

  @override
  AsyncValue<List<AiMessageResponse>> build() {
    _loadInitial();
    return const AsyncValue.loading();
  }

  Future<void> _loadInitial() async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getMessageHistory(limit: _pageSize);
    state = result.fold(
      (f) => AsyncValue.error(f.message, StackTrace.current),
      (messages) {
        _lastDocId = messages.lastOrNull?.id;
        _hasMore = messages.length >= _pageSize;
        return AsyncValue.data(messages);
      },
    );
  }

  Future<void> loadMore() async {
    if (!_hasMore || _lastDocId == null) return;
    final current = state.valueOrNull ?? [];
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getMessageHistory(
      limit: _pageSize,
      lastDocId: _lastDocId,
    );
    result.fold(
      (_) {},
      (messages) {
        _lastDocId = messages.lastOrNull?.id;
        _hasMore = messages.length >= _pageSize;
        state = AsyncValue.data([...current, ...messages]);
      },
    );
  }

  Future<void> refresh() async {
    _lastDocId = null;
    _hasMore = true;
    state = const AsyncValue.loading();
    await _loadInitial();
  }
}
```

### 2.3 Gift Recommendation Provider

#### `lib/features/ai/presentation/providers/gift_provider.dart`

```dart
// FILE: lib/features/ai/presentation/providers/gift_provider.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';

part 'gift_provider.freezed.dart';
part 'gift_provider.g.dart';

@freezed
class GiftRecommendationState with _$GiftRecommendationState {
  const factory GiftRecommendationState.idle() = _GiftIdle;
  const factory GiftRecommendationState.loading() = _GiftLoading;
  const factory GiftRecommendationState.success(GiftRecommendationResponse data) = _GiftSuccess;
  const factory GiftRecommendationState.tierLimitReached(int used, int limit) = _GiftTierLimit;
  const factory GiftRecommendationState.error(String message) = _GiftError;
}

@riverpod
class GiftRecommendationNotifier extends _$GiftRecommendationNotifier {
  @override
  GiftRecommendationState build() => const GiftRecommendationState.idle();

  Future<void> getRecommendations({
    required String profileId,
    required GiftOccasion occasion,
    required double budgetMin,
    required double budgetMax,
    String? occasionDetails,
    String currency = 'USD',
    GiftType giftType = GiftType.any,
    List<String> excludeCategories = const [],
    int count = 5,
  }) async {
    final costTracker = ref.read(costTrackerProvider.notifier);
    final canProceed = await costTracker.checkLimit(AiRequestType.gift);
    if (!canProceed) {
      final usage = costTracker.currentUsage;
      state = GiftRecommendationState.tierLimitReached(
        usage?.used ?? 0,
        usage?.limit ?? 0,
      );
      return;
    }

    state = const GiftRecommendationState.loading();

    final request = GiftRecommendationRequest(
      profileId: profileId,
      occasion: occasion,
      occasionDetails: occasionDetails,
      budgetMin: budgetMin,
      budgetMax: budgetMax,
      currency: currency,
      giftType: giftType,
      excludeCategories: excludeCategories,
      count: count,
    );

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getGiftRecommendations(request);

    state = result.fold(
      (f) => GiftRecommendationState.error(f.message),
      (data) {
        costTracker.recordUsage(AiRequestType.gift, data.usage);
        return GiftRecommendationState.success(data);
      },
    );
  }

  Future<void> submitFeedback(String giftId, String outcome, {String? comment}) async {
    final repo = ref.read(aiRepositoryProvider);
    await repo.submitGiftFeedback(giftId, outcome, comment: comment);
  }

  void reset() => state = const GiftRecommendationState.idle();
}
```

### 2.4 SOS Provider

#### `lib/features/ai/presentation/providers/sos_provider.dart`

```dart
// FILE: lib/features/ai/presentation/providers/sos_provider.dart

import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';

part 'sos_provider.freezed.dart';
part 'sos_provider.g.dart';

@freezed
class SosSessionState with _$SosSessionState {
  const factory SosSessionState.inactive() = _SosInactive;
  const factory SosSessionState.activating() = _SosActivating;
  const factory SosSessionState.activated(SosActivateResponse data) = _SosActivated;
  const factory SosSessionState.assessing() = _SosAssessing;
  const factory SosSessionState.assessed(SosAssessResponse assessment) = _SosAssessed;
  const factory SosSessionState.coaching(SosCoachResponse step) = _SosCoaching;
  const factory SosSessionState.streamingCoach({
    required int stepNumber,
    String? sayThis,
    String? bodyLanguage,
    List<String>? doNotSay,
    @Default(false) bool isComplete,
  }) = _SosStreamingCoach;
  const factory SosSessionState.tierLimitReached(int used, int limit) = _SosTierLimit;
  const factory SosSessionState.error(String message) = _SosError;
}

@riverpod
class SosSession extends _$SosSession {
  String? _activeSessionId;
  StreamSubscription<SosCoachingEvent>? _streamSub;

  @override
  SosSessionState build() => const SosSessionState.inactive();

  Future<void> activate({
    required SosScenario scenario,
    required SosUrgency urgency,
    String? briefContext,
    String? profileId,
  }) async {
    final costTracker = ref.read(costTrackerProvider.notifier);
    final canProceed = await costTracker.checkLimit(AiRequestType.sosAssessment);
    if (!canProceed) {
      final usage = costTracker.currentUsage;
      state = SosSessionState.tierLimitReached(
        usage?.used ?? 0,
        usage?.limit ?? 0,
      );
      return;
    }

    state = const SosSessionState.activating();

    final request = SosActivateRequest(
      scenario: scenario,
      urgency: urgency,
      briefContext: briefContext,
      profileId: profileId,
    );

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.activateSos(request);

    state = result.fold(
      (f) => SosSessionState.error(f.message),
      (data) {
        _activeSessionId = data.sessionId;
        return SosSessionState.activated(data);
      },
    );
  }

  Future<void> submitAssessment(SosAssessmentAnswers answers) async {
    if (_activeSessionId == null) {
      state = const SosSessionState.error('No active SOS session');
      return;
    }

    state = const SosSessionState.assessing();

    final request = SosAssessRequest(
      sessionId: _activeSessionId!,
      answers: answers,
    );

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.assessSos(request);

    state = result.fold(
      (f) => SosSessionState.error(f.message),
      (data) => SosSessionState.assessed(data),
    );
  }

  Future<void> getCoachingStep(int stepNumber, {
    String? userUpdate,
    String? herResponse,
    bool useStreaming = false,
  }) async {
    if (_activeSessionId == null) {
      state = const SosSessionState.error('No active SOS session');
      return;
    }

    final request = SosCoachRequest(
      sessionId: _activeSessionId!,
      stepNumber: stepNumber,
      userUpdate: userUpdate,
      herResponse: herResponse,
      stream: useStreaming,
    );

    if (useStreaming) {
      _startStreaming(request);
      return;
    }

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getCoaching(request);

    state = result.fold(
      (f) => SosSessionState.error(f.message),
      (data) => SosSessionState.coaching(data),
    );
  }

  void _startStreaming(SosCoachRequest request) {
    _streamSub?.cancel();
    state = SosSessionState.streamingCoach(stepNumber: request.stepNumber);

    final repo = ref.read(aiRepositoryProvider);
    _streamSub = repo.streamCoaching(request).listen(
      (event) {
        final current = state;
        if (current is! _SosStreamingCoach) return;

        switch (event.eventType) {
          case 'say_this':
            state = current.copyWith(sayThis: event.data['text'] as String?);
          case 'body_language':
            state = current.copyWith(bodyLanguage: event.data['text'] as String?);
          case 'do_not_say':
            final phrases = (event.data['phrases'] as List?)?.cast<String>();
            state = current.copyWith(doNotSay: phrases);
          case 'coaching_complete':
            state = current.copyWith(isComplete: true);
          case 'error':
            state = SosSessionState.error(
              event.data['message'] as String? ?? 'Streaming error',
            );
        }
      },
      onError: (e) {
        state = SosSessionState.error(e.toString());
      },
    );
  }

  void endSession() {
    _streamSub?.cancel();
    _streamSub = null;
    _activeSessionId = null;
    state = const SosSessionState.inactive();
  }

  @override
  void dispose() {
    _streamSub?.cancel();
  }
}
```

### 2.5 Action Card Provider

#### `lib/features/ai/presentation/providers/action_card_provider.dart`

```dart
// FILE: lib/features/ai/presentation/providers/action_card_provider.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';

part 'action_card_provider.freezed.dart';
part 'action_card_provider.g.dart';

@freezed
class ActionCardsState with _$ActionCardsState {
  const factory ActionCardsState.loading() = _CardsLoading;
  const factory ActionCardsState.loaded({
    required List<ActionCard> cards,
    required ActionCardSummary summary,
  }) = _CardsLoaded;
  const factory ActionCardsState.error(String message) = _CardsError;
}

@riverpod
class ActionCardsNotifier extends _$ActionCardsNotifier {
  @override
  ActionCardsState build() {
    _loadCards();
    return const ActionCardsState.loading();
  }

  Future<void> _loadCards({bool forceRefresh = false}) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getDailyCards(forceRefresh: forceRefresh);

    state = result.fold(
      (f) => ActionCardsState.error(f.message),
      (data) => ActionCardsState.loaded(
        cards: data.cards,
        summary: data.summary,
      ),
    );
  }

  Future<void> refresh({bool force = false}) async {
    state = const ActionCardsState.loading();
    await _loadCards(forceRefresh: force);
  }

  Future<CardCompleteResponse?> completeCard(String cardId, {String? notes}) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.completeCard(cardId, notes: notes);

    return result.fold(
      (_) => null,
      (response) {
        _updateCardStatus(cardId, CardStatus.completed);
        return response;
      },
    );
  }

  Future<ActionCard?> skipCard(String cardId, {String? reason}) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.skipCard(cardId, reason: reason);

    return result.fold(
      (_) => null,
      (replacement) {
        final current = state;
        if (current is _CardsLoaded) {
          final updatedCards = current.cards.where((c) => c.id != cardId).toList();
          if (replacement != null) {
            updatedCards.add(replacement);
          }
          state = current.copyWith(cards: updatedCards);
        }
        return replacement;
      },
    );
  }

  Future<void> saveCard(String cardId) async {
    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.saveCard(cardId);
    result.fold(
      (_) {},
      (_) => _updateCardStatus(cardId, CardStatus.saved),
    );
  }

  void _updateCardStatus(String cardId, CardStatus status) {
    final current = state;
    if (current is _CardsLoaded) {
      final updatedCards = current.cards.map((c) {
        if (c.id == cardId) return c.copyWith(status: status);
        return c;
      }).toList();
      final completedCount = updatedCards.where((c) => c.status == CardStatus.completed).length;
      state = current.copyWith(
        cards: updatedCards,
        summary: current.summary.copyWith(completedToday: completedCount),
      );
    }
  }
}
```

---

## Part 3: Caching, Cost Tracking, Content Safety

### 3.1 AI Cache Manager

#### `lib/features/ai/data/datasources/ai_cache_manager.dart`

```dart
// FILE: lib/features/ai/data/datasources/ai_cache_manager.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

part 'ai_cache_manager.g.dart';

@collection
class AiCacheEntry {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  late String jsonValue;
  late DateTime expiresAt;
  late DateTime createdAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class AiCacheManager {
  Isar? _isar;

  Future<void> init(Isar isar) async {
    _isar = isar;
  }

  // --- Cache Keys ---

  String messageKey({
    required String mode,
    required String tone,
    String? context,
  }) {
    final hash = _contextHash(context ?? '');
    return 'msg:$mode:$tone:$hash';
  }

  String giftKey({
    required String occasion,
    required double budgetMin,
    required double budgetMax,
  }) {
    return 'gift:$occasion:${budgetMin.toInt()}-${budgetMax.toInt()}';
  }

  String _contextHash(String input) {
    if (input.isEmpty) return 'empty';
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString().substring(0, 8);
  }

  // --- TTL Rules from AI Strategy Section 8.2 ---

  Duration ttlForMode(AiMessageMode mode) => switch (mode) {
        AiMessageMode.goodMorning => Duration.zero,
        AiMessageMode.checkingIn => Duration.zero,
        AiMessageMode.appreciation => Duration.zero,
        AiMessageMode.apology => Duration.zero,
        AiMessageMode.afterArgument => Duration.zero,
        AiMessageMode.flirting => Duration.zero,
        AiMessageMode.reassurance => const Duration(hours: 1),
        AiMessageMode.motivation => const Duration(hours: 2),
        AiMessageMode.celebration => const Duration(hours: 1),
        AiMessageMode.longDistance => const Duration(hours: 1),
      };

  // --- CRUD ---

  Future<T?> get<T>(String key) async {
    if (_isar == null) return null;

    final entry = await _isar!.aiCacheEntrys.where().keyEqualTo(key).findFirst();
    if (entry == null || entry.isExpired) {
      if (entry != null) {
        await _isar!.writeTxn(() => _isar!.aiCacheEntrys.delete(entry.id));
      }
      return null;
    }

    try {
      final json = jsonDecode(entry.jsonValue);
      return json as T;
    } catch (_) {
      return null;
    }
  }

  Future<void> put<T>(String key, T value, {required Duration ttl}) async {
    if (_isar == null || ttl == Duration.zero) return;

    final entry = AiCacheEntry()
      ..key = key
      ..jsonValue = jsonEncode(value)
      ..expiresAt = DateTime.now().add(ttl)
      ..createdAt = DateTime.now();

    await _isar!.writeTxn(() => _isar!.aiCacheEntrys.put(entry));
  }

  Future<void> invalidatePattern(String prefix) async {
    if (_isar == null) return;

    final entries = await _isar!.aiCacheEntrys
        .where()
        .filter()
        .keyStartsWith(prefix)
        .findAll();

    if (entries.isNotEmpty) {
      final ids = entries.map((e) => e.id).toList();
      await _isar!.writeTxn(() => _isar!.aiCacheEntrys.deleteAll(ids));
    }
  }

  Future<void> invalidateAll() async {
    if (_isar == null) return;
    await _isar!.writeTxn(() => _isar!.aiCacheEntrys.clear());
  }

  Future<void> purgeExpired() async {
    if (_isar == null) return;

    final now = DateTime.now();
    final expired = await _isar!.aiCacheEntrys
        .where()
        .filter()
        .expiresAtLessThan(now)
        .findAll();

    if (expired.isNotEmpty) {
      final ids = expired.map((e) => e.id).toList();
      await _isar!.writeTxn(() => _isar!.aiCacheEntrys.deleteAll(ids));
    }
  }

  Future<int> cacheSize() async {
    if (_isar == null) return 0;
    return _isar!.aiCacheEntrys.count();
  }
}
```

### 3.2 Cost Tracker Provider

#### `lib/features/ai/presentation/providers/cost_tracker_provider.dart`

```dart
// FILE: lib/features/ai/presentation/providers/cost_tracker_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cost_tracker_provider.g.dart';

class UsageSnapshot {
  final int used;
  final int limit;
  final int remaining;
  final DateTime resetsAt;
  final AiRequestType type;

  const UsageSnapshot({
    required this.used,
    required this.limit,
    required this.remaining,
    required this.resetsAt,
    required this.type,
  });

  double get usagePercentage => limit <= 0 ? 0 : (used / limit).clamp(0.0, 1.0);
  bool get isExhausted => limit > 0 && used >= limit;
  bool get isUnlimited => limit == -1;
}

@Riverpod(keepAlive: true)
class CostTracker extends _$CostTracker {
  final Map<AiRequestType, AiUsageInfo> _usageCache = {};
  AiUsageInfo? _lastQueried;

  @override
  Map<AiRequestType, UsageSnapshot> build() => {};

  AiUsageInfo? get currentUsage => _lastQueried;

  Future<bool> checkLimit(AiRequestType type) async {
    if (_usageCache.containsKey(type)) {
      final cached = _usageCache[type]!;
      _lastQueried = cached;
      if (cached.limit == -1) return true; // unlimited
      if (cached.used >= cached.limit) return false;
      return true;
    }

    final repo = ref.read(aiRepositoryProvider);
    final result = await repo.getUsage(type);

    return result.fold(
      (_) => true, // on error, allow and let server enforce
      (usage) {
        _usageCache[type] = usage;
        _lastQueried = usage;
        _updateState(type, usage);
        if (usage.limit == -1) return true;
        return usage.used < usage.limit;
      },
    );
  }

  void recordUsage(AiRequestType type, AiUsageInfo usage) {
    _usageCache[type] = usage;
    _lastQueried = usage;
    _updateState(type, usage);
    _persistUsage(type, usage);
  }

  void _updateState(AiRequestType type, AiUsageInfo usage) {
    state = {
      ...state,
      type: UsageSnapshot(
        used: usage.used,
        limit: usage.limit,
        remaining: usage.remaining,
        resetsAt: usage.resetsAt,
        type: type,
      ),
    };
  }

  Future<void> _persistUsage(AiRequestType type, AiUsageInfo usage) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('ai_usage_${type.apiValue}_used', usage.used);
      await prefs.setInt('ai_usage_${type.apiValue}_limit', usage.limit);
      await prefs.setString(
          'ai_usage_${type.apiValue}_resets', usage.resetsAt.toIso8601String());
    } catch (_) {}
  }

  Future<void> loadCachedUsage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final type in AiRequestType.values) {
        final used = prefs.getInt('ai_usage_${type.apiValue}_used');
        final limit = prefs.getInt('ai_usage_${type.apiValue}_limit');
        final resets = prefs.getString('ai_usage_${type.apiValue}_resets');

        if (used != null && limit != null && resets != null) {
          final resetsAt = DateTime.tryParse(resets);
          if (resetsAt != null && resetsAt.isAfter(DateTime.now())) {
            final usage = AiUsageInfo(
              used: used,
              limit: limit,
              remaining: (limit == -1) ? -1 : (limit - used).clamp(0, limit),
              resetsAt: resetsAt,
            );
            _usageCache[type] = usage;
            _updateState(type, usage);
          }
        }
      }
    } catch (_) {}
  }

  void clearCache() {
    _usageCache.clear();
    state = {};
  }

  UsageSnapshot? snapshotFor(AiRequestType type) => state[type];
}

@riverpod
UsageSnapshot? messageUsage(MessageUsageRef ref) {
  final tracker = ref.watch(costTrackerProvider);
  return tracker[AiRequestType.message];
}

@riverpod
UsageSnapshot? giftUsage(GiftUsageRef ref) {
  final tracker = ref.watch(costTrackerProvider);
  return tracker[AiRequestType.gift];
}

@riverpod
UsageSnapshot? sosUsage(SosUsageRef ref) {
  final tracker = ref.watch(costTrackerProvider);
  return tracker[AiRequestType.sosAssessment];
}
```

### 3.3 Content Safety Filter

#### `lib/features/ai/data/services/content_safety_filter.dart`

```dart
// FILE: lib/features/ai/data/services/content_safety_filter.dart

class SafetyValidationResult {
  final bool isValid;
  final String? reason;
  final SafetyCategory? category;

  const SafetyValidationResult.valid()
      : isValid = true,
        reason = null,
        category = null;

  const SafetyValidationResult.blocked(this.reason, this.category) : isValid = false;
}

enum SafetyCategory {
  manipulation,
  explicit,
  harmful,
  promptInjection,
  pii,
  aiIdentity,
}

class ContentSafetyFilter {
  // Pre-generation: validate user input before sending to backend
  SafetyValidationResult validateInput(String? text) {
    if (text == null || text.isEmpty) return const SafetyValidationResult.valid();

    final lower = text.toLowerCase();

    // Prompt injection detection
    for (final pattern in _injectionPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'LOLO cannot process this request.',
          SafetyCategory.promptInjection,
        );
      }
    }

    // Manipulation/harmful content detection
    for (final pattern in _manipulationPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'LOLO cannot help with this type of request.',
          SafetyCategory.manipulation,
        );
      }
    }

    // Explicit content detection
    for (final pattern in _explicitPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'LOLO cannot generate this type of content.',
          SafetyCategory.explicit,
        );
      }
    }

    // Length enforcement
    if (text.length > 500) {
      return const SafetyValidationResult.blocked(
        'Input exceeds maximum length.',
        SafetyCategory.harmful,
      );
    }

    return const SafetyValidationResult.valid();
  }

  // Post-generation: validate AI output before displaying
  SafetyValidationResult validateOutput(String content) {
    if (content.isEmpty) {
      return const SafetyValidationResult.blocked(
        'Empty response received.',
        SafetyCategory.harmful,
      );
    }

    final lower = content.toLowerCase();

    // AI identity leak detection
    for (final pattern in _aiIdentityPatterns) {
      if (lower.contains(pattern)) {
        return const SafetyValidationResult.blocked(
          'Response contained disallowed content.',
          SafetyCategory.aiIdentity,
        );
      }
    }

    // PII detection (phone numbers, emails)
    if (_phoneRegex.hasMatch(content) || _emailRegex.hasMatch(content)) {
      return const SafetyValidationResult.blocked(
        'Response contained personal information.',
        SafetyCategory.pii,
      );
    }

    // URL detection
    if (_urlRegex.hasMatch(content)) {
      return const SafetyValidationResult.blocked(
        'Response contained external links.',
        SafetyCategory.pii,
      );
    }

    return const SafetyValidationResult.valid();
  }

  // Sanitize free-text input (strip tags, normalize)
  String sanitize(String input) {
    var result = input;
    result = result.replaceAll(RegExp(r'<[^>]*>'), ''); // strip HTML
    result = result.replaceAll(RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F]'), ''); // control chars
    result = result.trim();
    return result;
  }

  static const _injectionPatterns = [
    'ignore previous instructions',
    'ignore all instructions',
    'ignore your instructions',
    'disregard previous',
    'disregard your',
    'forget your instructions',
    'override your',
    'you are now',
    'act as if',
    'pretend you are',
    'system prompt',
    'new instructions',
    'jailbreak',
    'developer mode',
    'dan mode',
  ];

  static const _manipulationPatterns = [
    'gaslight',
    'manipulate her',
    'make her jealous',
    'make her feel guilty',
    'control her',
    'how to lie to',
    'trick her into',
    'guilt trip',
    'emotional blackmail',
    'threaten',
    'stalk',
    'spy on',
    'track her without',
  ];

  static const _explicitPatterns = [
    'sexually explicit',
    'nude photo',
    'sexual act',
    'sexual position',
  ];

  static const _aiIdentityPatterns = [
    'as an ai',
    'i am an ai',
    "i'm an ai",
    'as a language model',
    'as an artificial',
    'i am chatgpt',
    'i am claude',
    'i am gemini',
    'i am grok',
    'powered by openai',
    'powered by anthropic',
    'lolo ai engine',
  ];

  static final _phoneRegex = RegExp(
    r'(?:\+?\d{1,3}[-.\s]?)?\(?\d{3}\)?[-.\s]?\d{3}[-.\s]?\d{4}',
  );

  static final _emailRegex = RegExp(
    r'[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}',
  );

  static final _urlRegex = RegExp(
    r'https?://[^\s]+',
  );
}
```

### 3.4 Tier Enforcement Service

#### `lib/features/ai/data/services/tier_enforcement.dart`

```dart
// FILE: lib/features/ai/data/services/tier_enforcement.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class TierEnforcement {
  const TierEnforcement._();

  static bool canAccessMode(SubscriptionTier tier, AiMessageMode mode) {
    // All modes accessible on Pro and Legend
    if (tier == SubscriptionTier.pro || tier == SubscriptionTier.legend) {
      return true;
    }
    // Free tier: first 3 modes (indices 0-2 in the enum) are accessible
    return mode.index <= 2;
  }

  static bool canIncludeAlternatives(SubscriptionTier tier) {
    return tier == SubscriptionTier.legend;
  }

  static bool canForceRefreshCards(SubscriptionTier tier) {
    return tier == SubscriptionTier.legend;
  }

  static bool canGetReplacementCard(SubscriptionTier tier) {
    return tier != SubscriptionTier.free;
  }

  static int maxGiftsPerRequest(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 3,
        SubscriptionTier.pro => 5,
        SubscriptionTier.legend => 10,
      };

  static int maxCardsPerDay(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 3,
        SubscriptionTier.pro => 10,
        SubscriptionTier.legend => -1, // unlimited
      };

  static String tierLimitMessage(SubscriptionTier tier, AiRequestType type) {
    final featureName = switch (type) {
      AiRequestType.message => 'AI messages',
      AiRequestType.gift => 'gift recommendations',
      AiRequestType.sosAssessment || AiRequestType.sosCoaching => 'SOS sessions',
      AiRequestType.actionCard => 'action cards',
      _ => 'AI features',
    };

    return switch (tier) {
      SubscriptionTier.free =>
        'You\'ve reached your free tier limit for $featureName. '
            'Upgrade to Pro for more.',
      SubscriptionTier.pro =>
        'You\'ve reached your Pro tier limit for $featureName. '
            'Upgrade to Legend for unlimited access.',
      SubscriptionTier.legend =>
        'Something went wrong. Legend tier should have unlimited access.',
    };
  }
}
```

### 3.5 AI Service Initializer

#### `lib/features/ai/data/services/ai_service_initializer.dart`

```dart
// FILE: lib/features/ai/data/services/ai_service_initializer.dart

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';

class AiServiceInitializer {
  static Future<AiCacheManager> initCache() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [AiCacheEntrySchema],
      directory: dir.path,
      name: 'ai_cache',
    );

    final manager = AiCacheManager();
    await manager.init(isar);

    // Purge expired entries on startup
    await manager.purgeExpired();

    return manager;
  }
}
```

### 3.6 Usage Display Widget Helper

#### `lib/features/ai/presentation/widgets/usage_indicator.dart`

```dart
// FILE: lib/features/ai/presentation/widgets/usage_indicator.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class AiUsageIndicator extends ConsumerWidget {
  final AiRequestType type;
  final bool compact;

  const AiUsageIndicator({
    super.key,
    required this.type,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snapshot = ref.watch(costTrackerProvider)[type];
    if (snapshot == null) return const SizedBox.shrink();
    if (snapshot.isUnlimited) {
      return compact
          ? const Icon(Icons.all_inclusive, size: 16)
          : const Text('Unlimited');
    }

    final theme = Theme.of(context);
    final percentage = snapshot.usagePercentage;
    final color = percentage > 0.9
        ? theme.colorScheme.error
        : percentage > 0.7
            ? Colors.orange
            : theme.colorScheme.primary;

    if (compact) {
      return Text(
        '${snapshot.remaining}',
        style: theme.textTheme.labelSmall?.copyWith(color: color),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${snapshot.used}/${snapshot.limit}',
              style: theme.textTheme.bodySmall?.copyWith(color: color),
            ),
            const SizedBox(width: 4),
            Text(
              _typeLabel,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        SizedBox(
          width: 120,
          child: LinearProgressIndicator(
            value: percentage,
            backgroundColor: color.withOpacity(0.15),
            valueColor: AlwaysStoppedAnimation(color),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    );
  }

  String get _typeLabel => switch (type) {
        AiRequestType.message => 'messages this month',
        AiRequestType.gift => 'gift requests this month',
        AiRequestType.sosAssessment => 'SOS sessions this month',
        AiRequestType.actionCard => 'cards today',
        _ => 'requests',
      };
}
```

---

## Architecture Summary

### File Structure

```
lib/features/ai/
  domain/
    enums/
      ai_enums.dart                    # All AI-related enums
    entities/
      ai_request.dart                  # Request DTOs (freezed)
      ai_response.dart                 # Response DTOs (freezed)
    repositories/
      ai_repository.dart               # Abstract repository contract
    failures/
      ai_failures.dart                 # AI-specific Failure subclasses
    services/
      emotional_depth_calculator.dart   # Depth scoring algorithm
  data/
    repositories/
      ai_repository_impl.dart          # Dio-based repository implementation
    datasources/
      ai_cache_manager.dart            # Isar-based local cache
    services/
      content_safety_filter.dart       # Client-side input/output validation
      prompt_context_builder.dart      # Context assembly builder
      tier_enforcement.dart            # Subscription tier rules
      ai_service_initializer.dart      # Cache + service bootstrap
  presentation/
    providers/
      ai_providers.dart                # Root provider registration
      message_generation_provider.dart # Message gen + history
      gift_provider.dart               # Gift recommendation state
      sos_provider.dart                # SOS session lifecycle + SSE
      action_card_provider.dart        # Daily cards state
      cost_tracker_provider.dart       # Usage tracking + persistence
    widgets/
      usage_indicator.dart             # Reusable usage display widget
```

### Data Flow

```
User Action
  -> Riverpod Provider (state management + tier check)
    -> CostTracker (usage validation)
    -> ContentSafetyFilter (pre-validation)
    -> AiRepository (Dio HTTP call to /api/v1/ai/*)
      -> AiCacheManager (check/store local cache)
    -> ContentSafetyFilter (post-validation)
  -> Provider updates state
  -> UI rebuilds
```

### Key Design Decisions

1. **Client never calls AI models directly** -- all requests go through `/api/v1/ai/*` endpoints where the backend AI Router handles model selection, failover, and prompt assembly.

2. **Tier enforcement is dual-layer** -- client checks locally for fast UX feedback, server enforces authoritatively. Client-side checks are optimistic and cached.

3. **SSE streaming for SOS coaching** -- the `streamCoaching` method parses Server-Sent Events for real-time coaching delivery during crisis situations.

4. **Cache TTL matches AI Strategy Section 8.2** -- modes like `goodMorning`, `apology`, and `flirting` have TTL=0 (never cached), while `motivation` and `reassurance` allow short caching windows.

5. **Content safety is defense-in-depth** -- client-side filtering catches obvious issues before they hit the network, but the backend performs authoritative safety validation.

6. **Emotional depth calculation lives client-side** -- used for UX decisions (showing depth indicators) but the server recalculates authoritatively for model routing.

---

*Dr. Aisha Mahmoud, AI/ML Engineer -- Sprint 3 AI Router Client Implementation*
