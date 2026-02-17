import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/sos_mode/data/datasources/sos_remote_datasource.dart';
import 'package:lolo/features/sos_mode/data/repositories/sos_repository_impl.dart';
import 'package:lolo/features/sos_mode/domain/entities/coaching_step.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos_mode/domain/entities/sos_session.dart';
import 'package:lolo/features/sos_mode/domain/repositories/sos_repository.dart';

/// Active SOS session state.
class SosState {
  final SosSession? session;
  final SosAssessment? assessment;
  final List<CoachingStep> coachingSteps;
  final bool isLoading;
  final bool isStreaming;
  final String? error;
  final bool isComplete;

  const SosState({
    this.session,
    this.assessment,
    this.coachingSteps = const [],
    this.isLoading = false,
    this.isStreaming = false,
    this.error,
    this.isComplete = false,
  });

  SosState copyWith({
    SosSession? session,
    SosAssessment? assessment,
    List<CoachingStep>? coachingSteps,
    bool? isLoading,
    bool? isStreaming,
    String? error,
    bool? isComplete,
  }) =>
      SosState(
        session: session ?? this.session,
        assessment: assessment ?? this.assessment,
        coachingSteps: coachingSteps ?? this.coachingSteps,
        isLoading: isLoading ?? this.isLoading,
        isStreaming: isStreaming ?? this.isStreaming,
        error: error,
        isComplete: isComplete ?? this.isComplete,
      );
}

/// Manages the entire SOS Mode flow: activation, assessment, coaching, completion.
class SosNotifier extends Notifier<SosState> {
  StreamSubscription<CoachingStep>? _coachingSub;

  @override
  SosState build() => const SosState();

  SosRepository get _repository => ref.read(sosRepositoryProvider);

  /// Step 1: Activate SOS with scenario and urgency.
  Future<void> activateSession({
    required SosScenario scenario,
    required SosUrgency urgency,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.activateSession(
      scenario: scenario,
      urgency: urgency,
    );
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (session) => state = state.copyWith(
        isLoading: false,
        session: session,
      ),
    );
  }

  /// Step 2: Submit assessment answers.
  Future<void> submitAssessment(SosAssessmentAnswers answers) async {
    final sessionId = state.session?.sessionId;
    if (sessionId == null) return;

    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.submitAssessment(
      sessionId: sessionId,
      answers: answers,
    );
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (assessment) => state = state.copyWith(
        isLoading: false,
        assessment: assessment,
      ),
    );
  }

  /// Step 3: Start streaming coaching steps via SSE.
  void startCoaching() {
    final sessionId = state.session?.sessionId;
    if (sessionId == null) return;

    state = state.copyWith(isStreaming: true, coachingSteps: []);

    _coachingSub?.cancel();
    _coachingSub = _repository
        .streamCoachingSteps(sessionId: sessionId)
        .listen(
      (step) {
        state = state.copyWith(
          coachingSteps: [...state.coachingSteps, step],
        );
      },
      onDone: () {
        state = state.copyWith(isStreaming: false);
      },
      onError: (Object error) {
        state = state.copyWith(
          isStreaming: false,
          error: error.toString(),
        );
      },
    );
  }

  /// Step 4: Complete the SOS session.
  Future<void> completeSession({
    required int rating,
    String? resolution,
    bool saveToMemoryVault = false,
  }) async {
    final sessionId = state.session?.sessionId;
    if (sessionId == null) return;

    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.completeSession(
      sessionId: sessionId,
      rating: rating,
      resolution: resolution,
      saveToMemoryVault: saveToMemoryVault,
    );
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (_) => state = state.copyWith(
        isLoading: false,
        isComplete: true,
      ),
    );
  }

  /// Reset state for a new SOS session.
  void reset() {
    _coachingSub?.cancel();
    state = const SosState();
  }
}

final sosNotifierProvider = NotifierProvider<SosNotifier, SosState>(
  SosNotifier.new,
);

/// Provider for SosRepository backed by remote data source.
final sosRepositoryProvider = Provider<SosRepository>((ref) {
  final dio = ref.watch(dioProvider);
  final remote = SosRemoteDataSource(dio);
  return SosRepositoryImpl(remote: remote);
});
