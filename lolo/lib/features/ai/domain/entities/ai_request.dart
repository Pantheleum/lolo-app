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
