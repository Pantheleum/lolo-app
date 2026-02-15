import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/sos/data/repositories/sos_repository.dart';
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';

part 'sos_providers.freezed.dart';

@freezed
class SosFlowState with _$SosFlowState {
  const factory SosFlowState.idle() = _Idle;
  const factory SosFlowState.activating() = _Activating;
  const factory SosFlowState.activated(SosSession session) = _Activated;
  const factory SosFlowState.assessed(SosSession session, SosAssessment assessment) = _Assessed;
  const factory SosFlowState.coaching(SosSession session, CoachingStep step) = _Coaching;
  const factory SosFlowState.resolved() = _Resolved;
  const factory SosFlowState.error(String message) = _Error;
}

class SosSessionNotifier extends Notifier<SosFlowState> {
  @override
  SosFlowState build() => const SosFlowState.idle();

  Future<void> activate({
    required String scenario,
    required String urgency,
    String? briefContext,
  }) async {
    state = const SosFlowState.activating();
    final repo = ref.read(sosRepositoryProvider);
    final result = await repo.activate(
      scenario: scenario,
      urgency: urgency,
      briefContext: briefContext,
    );
    state = result.fold(
      (f) => SosFlowState.error(f.message),
      (session) => SosFlowState.activated(session),
    );
  }

  Future<void> assess(Map<String, dynamic> answers) async {
    final current = state;
    if (current is! _Activated) return;
    final repo = ref.read(sosRepositoryProvider);
    final result = await repo.assess(
      sessionId: current.session.sessionId,
      answers: answers,
    );
    state = result.fold(
      (f) => SosFlowState.error(f.message),
      (assessment) => SosFlowState.assessed(current.session, assessment),
    );
  }

  Future<void> getCoaching(int stepNumber, {String? userUpdate}) async {
    SosSession? session;
    state.whenOrNull(
      activated: (s) => session = s,
      assessed: (s, _) => session = s,
      coaching: (s, _) => session = s,
    );
    if (session == null) return;

    final repo = ref.read(sosRepositoryProvider);
    await for (final step in repo.coachStream(
      sessionId: session!.sessionId,
      stepNumber: stepNumber,
      userUpdate: userUpdate,
    )) {
      state = SosFlowState.coaching(session!, step);
    }
  }

  Future<void> resolve(String outcome, {int? rating}) async {
    String? sessionId;
    state.whenOrNull(
      activated: (s) => sessionId = s.sessionId,
      assessed: (s, _) => sessionId = s.sessionId,
      coaching: (s, _) => sessionId = s.sessionId,
    );
    if (sessionId == null) return;
    final repo = ref.read(sosRepositoryProvider);
    await repo.resolve(sessionId: sessionId!, outcome: outcome, rating: rating);
    state = const SosFlowState.resolved();
  }
}

final sosSessionNotifierProvider =
    NotifierProvider<SosSessionNotifier, SosFlowState>(
  SosSessionNotifier.new,
);
