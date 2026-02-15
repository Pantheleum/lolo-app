import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_session.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos_mode/domain/entities/coaching_step.dart';

/// Contract for SOS Mode data access.
///
/// Supports real-time SSE streaming for coaching steps.
abstract class SosRepository {
  /// Activate an SOS session with scenario and urgency.
  Future<Either<Failure, SosSession>> activateSession({
    required SosScenario scenario,
    required SosUrgency urgency,
  });

  /// Submit assessment answers and receive severity + coaching plan.
  Future<Either<Failure, SosAssessment>> submitAssessment({
    required String sessionId,
    required SosAssessmentAnswers answers,
  });

  /// Stream coaching steps via SSE for real-time guidance.
  Stream<CoachingStep> streamCoachingSteps({required String sessionId});

  /// Complete an SOS session with rating and resolution notes.
  Future<Either<Failure, void>> completeSession({
    required String sessionId,
    required int rating,
    String? resolution,
    bool saveToMemoryVault,
  });

  /// Get a specific SOS session by ID.
  Future<Either<Failure, SosSession>> getSession(String sessionId);
}
