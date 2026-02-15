// FILE: lib/features/ai/presentation/providers/message_generation_provider.dart

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:lolo/features/ai/presentation/providers/cost_tracker_provider.dart';

part 'message_generation_provider.freezed.dart';

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

class MessageGenerator extends Notifier<MessageGenState> {
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

final messageGeneratorProvider =
    NotifierProvider<MessageGenerator, MessageGenState>(
  MessageGenerator.new,
);

class MessageHistory extends Notifier<AsyncValue<List<AiMessageResponse>>> {
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

final messageHistoryProvider =
    NotifierProvider<MessageHistory, AsyncValue<List<AiMessageResponse>>>(
  MessageHistory.new,
);
