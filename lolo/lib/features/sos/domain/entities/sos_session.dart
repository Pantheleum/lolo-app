import 'package:freezed_annotation/freezed_annotation.dart';

part 'sos_session.freezed.dart';

enum SosScenario {
  sheIsAngry, sheIsCrying, sheIsSilent, caughtInLie,
  forgotImportantDate, saidWrongThing, sheWantsToTalk,
  herFamilyConflict, jealousyIssue, other
}

enum SosUrgency { happeningNow, justHappened, brewing }

@freezed
class SosSession with _$SosSession {
  const factory SosSession({
    required String sessionId,
    required SosScenario scenario,
    required SosUrgency urgency,
    required SosImmediateAdvice immediateAdvice,
    required bool severityAssessmentRequired,
    required int estimatedResolutionSteps,
    required DateTime createdAt,
  }) = _SosSession;
}

@freezed
class SosImmediateAdvice with _$SosImmediateAdvice {
  const factory SosImmediateAdvice({
    required String doNow,
    required String doNotDo,
    required String bodyLanguage,
  }) = _SosImmediateAdvice;
}
