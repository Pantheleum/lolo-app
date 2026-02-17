import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/sos_mode/data/datasources/sos_remote_datasource.dart';
import 'package:lolo/features/sos_mode/domain/entities/coaching_step.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_session.dart';
import 'package:lolo/features/sos_mode/domain/repositories/sos_repository.dart';

/// Firebase + SSE streaming implementation of [SosRepository].
class SosRepositoryImpl implements SosRepository {
  final SosRemoteDataSource _remote;

  const SosRepositoryImpl({required SosRemoteDataSource remote})
      : _remote = remote;

  @override
  Future<Either<Failure, SosSession>> activateSession({
    required SosScenario scenario,
    required SosUrgency urgency,
  }) async {
    try {
      final data = await _remote.activateSession(
        scenario: scenario.name,
        urgency: urgency.name,
      );
      return Right(_mapSession(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SosAssessment>> submitAssessment({
    required String sessionId,
    required SosAssessmentAnswers answers,
  }) async {
    try {
      final data = await _remote.submitAssessment(
        sessionId: sessionId,
        answers: {
          'howLongAgo': answers.howLongAgo,
          'herCurrentState': answers.herCurrentState,
          'isYourFault': answers.isYourFault,
          'whatHappened': answers.whatHappened,
          if (answers.additionalContext != null)
            'additionalContext': answers.additionalContext,
        },
      );
      return Right(_mapAssessment(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<CoachingStep> streamCoachingSteps({required String sessionId}) {
    return _remote.streamCoachingSteps(sessionId: sessionId).map(_mapStep);
  }

  @override
  Future<Either<Failure, void>> completeSession({
    required String sessionId,
    required int rating,
    String? resolution,
    bool saveToMemoryVault = false,
  }) async {
    try {
      await _remote.completeSession(
        sessionId: sessionId,
        rating: rating,
        resolution: resolution,
        saveToMemoryVault: saveToMemoryVault,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SosSession>> getSession(String sessionId) async {
    try {
      final data = await _remote.getSession(sessionId);
      return Right(_mapSession(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  SosSession _mapSession(Map<String, dynamic> data) => SosSession(
        sessionId: data['sessionId'] as String,
        scenario: SosScenario.values.firstWhere(
          (e) => e.name == data['scenario'],
          orElse: () => SosScenario.other,
        ),
        urgency: SosUrgency.values.firstWhere(
          (e) => e.name == data['urgency'],
          orElse: () => SosUrgency.happeningNow,
        ),
        immediateAdvice: SosImmediateAdvice(
          doNow: data['immediateAdvice']?['doNow'] as String? ?? '',
          doNotDo: data['immediateAdvice']?['doNotDo'] as String? ?? '',
          bodyLanguage:
              data['immediateAdvice']?['bodyLanguage'] as String? ?? '',
        ),
        severityAssessmentRequired:
            data['severityAssessmentRequired'] as bool? ?? true,
        estimatedResolutionSteps:
            data['estimatedResolutionSteps'] as int? ?? 5,
        createdAt: DateTime.tryParse(data['createdAt'] as String? ?? '') ??
            DateTime.now(),
      );

  SosAssessment _mapAssessment(Map<String, dynamic> data) => SosAssessment(
        sessionId: data['sessionId'] as String,
        severityScore: data['severityScore'] as int? ?? 5,
        severityLabel: data['severityLabel'] as String? ?? 'moderate',
        coachingPlan: SosCoachingPlan(
          totalSteps: data['coachingPlan']?['totalSteps'] as int? ?? 3,
          estimatedMinutes:
              data['coachingPlan']?['estimatedMinutes'] as int? ?? 10,
          approach: data['coachingPlan']?['approach'] as String? ?? '',
          keyInsight: data['coachingPlan']?['keyInsight'] as String? ?? '',
        ),
      );

  CoachingStep _mapStep(Map<String, dynamic> data) => CoachingStep(
        sessionId: data['sessionId'] as String? ?? '',
        stepNumber: data['stepNumber'] as int? ?? 1,
        totalSteps: data['totalSteps'] as int? ?? 1,
        sayThis: data['sayThis'] as String? ?? '',
        whyItWorks: data['whyItWorks'] as String? ?? '',
        doNotSay:
            (data['doNotSay'] as List?)?.cast<String>() ?? const [],
        bodyLanguageTip: data['bodyLanguageTip'] as String? ?? '',
        toneAdvice: data['toneAdvice'] as String? ?? '',
        waitFor: data['waitFor'] as String?,
        isLastStep: data['isLastStep'] as bool? ?? false,
        nextStepPrompt: data['nextStepPrompt'] as String?,
      );
}
