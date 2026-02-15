import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';

part 'message_state.freezed.dart';

/// States for the message generation flow.
@freezed
class MessageGenerationState with _$MessageGenerationState {
  const factory MessageGenerationState.idle() = _Idle;
  const factory MessageGenerationState.generating() = _Generating;
  const factory MessageGenerationState.success({
    required GeneratedMessageEntity message,
  }) = _Success;
  const factory MessageGenerationState.error({
    required String message,
  }) = _Error;
}

/// States for message history list.
@freezed
class MessageHistoryState with _$MessageHistoryState {
  const factory MessageHistoryState.initial() = _HistoryInitial;
  const factory MessageHistoryState.loading() = _HistoryLoading;
  const factory MessageHistoryState.loaded({
    required List<GeneratedMessageEntity> messages,
    required bool hasMore,
    required int currentPage,
    @Default(false) bool isLoadingMore,
  }) = _HistoryLoaded;
  const factory MessageHistoryState.error({
    required String message,
  }) = _HistoryError;
}
