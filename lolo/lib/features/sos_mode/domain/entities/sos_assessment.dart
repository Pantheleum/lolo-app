import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_assessment.freezed.dart';

@freezed
class SosAssessment with _$SosAssessment {
  const factory SosAssessment({
    required String sessionId,
    required int severityScore,
    required String severityLabel,
    required SosCoachingPlan coachingPlan,
  }) = _SosAssessment;
}

@freezed
class SosCoachingPlan with _$SosCoachingPlan {
  const factory SosCoachingPlan({
    required int totalSteps,
    required int estimatedMinutes,
    required String approach,
    required String keyInsight,
  }) = _SosCoachingPlan;
}

@freezed
class SosAssessmentAnswers with _$SosAssessmentAnswers {
  const factory SosAssessmentAnswers({
    required String howLongAgo,
    required String herCurrentState,
    required bool isYourFault,
    required String whatHappened,
    String? additionalContext,
  }) = _SosAssessmentAnswers;
}
