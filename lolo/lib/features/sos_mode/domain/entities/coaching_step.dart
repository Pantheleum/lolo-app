import 'package:freezed_annotation/freezed_annotation.dart';

part 'coaching_step.freezed.dart';

@freezed
class CoachingStep with _$CoachingStep {
  const factory CoachingStep({
    required String sessionId,
    required int stepNumber,
    required int totalSteps,
    required String sayThis,
    required String whyItWorks,
    required List<String> doNotSay,
    required String bodyLanguageTip,
    required String toneAdvice,
    String? waitFor,
    required bool isLastStep,
    String? nextStepPrompt,
  }) = _CoachingStep;
}
