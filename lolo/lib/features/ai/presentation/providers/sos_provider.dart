// FILE: lib/features/ai/presentation/providers/sos_provider.dart

import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';

part 'sos_provider.freezed.dart';

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

class SosSession extends Notifier<SosSessionState> {
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
      onError: (Object e) {
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
}

final sosSessionProvider =
    NotifierProvider<SosSession, SosSessionState>(
  SosSession.new,
);
