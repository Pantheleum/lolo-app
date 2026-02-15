import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_request_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';
import 'package:lolo/features/ai_messages/domain/repositories/message_repository.dart';
import 'package:lolo/features/ai_messages/presentation/providers/message_state.dart';

part 'message_provider.g.dart';

/// Manages message generation -- builds the request from the
/// configuration screen inputs and delegates to the repository.
@riverpod
class MessageGenerationNotifier extends _$MessageGenerationNotifier {
  @override
  MessageGenerationState build() => const MessageGenerationState.idle();

  /// Generate a new message with the given configuration.
  Future<void> generate({
    required MessageMode mode,
    required MessageTone tone,
    required MessageLength length,
    required int humorLevel,
    required String languageCode,
    required bool includePartnerName,
    String? contextText,
  }) async {
    state = const MessageGenerationState.generating();

    final request = MessageRequestEntity(
      mode: mode,
      tone: tone,
      length: length,
      humorLevel: humorLevel,
      languageCode: languageCode,
      includePartnerName: includePartnerName,
      contextText: contextText,
    );

    final repository = ref.read(messageRepositoryProvider);
    final result = await repository.generateMessage(request);

    state = result.fold(
      (failure) => MessageGenerationState.error(message: failure.message),
      (msg) => MessageGenerationState.success(message: msg),
    );
  }

  /// Regenerate the last generated message.
  Future<void> regenerate(String messageId) async {
    state = const MessageGenerationState.generating();

    final repository = ref.read(messageRepositoryProvider);
    final result = await repository.regenerateMessage(messageId);

    state = result.fold(
      (failure) => MessageGenerationState.error(message: failure.message),
      (msg) => MessageGenerationState.success(message: msg),
    );
  }

  /// Rate a generated message (1-5 stars).
  Future<void> rate(String messageId, int rating) async {
    final repository = ref.read(messageRepositoryProvider);
    await repository.rateMessage(messageId: messageId, rating: rating);

    // Update local state if currently showing this message
    state.whenOrNull(
      success: (message) {
        if (message.id == messageId) {
          state = MessageGenerationState.success(
            message: message.copyWith(rating: rating),
          );
        }
      },
    );
  }

  /// Toggle favorite status on the current message.
  Future<void> toggleFavorite(String messageId) async {
    final repository = ref.read(messageRepositoryProvider);
    await repository.toggleFavorite(messageId);

    state.whenOrNull(
      success: (message) {
        if (message.id == messageId) {
          state = MessageGenerationState.success(
            message: message.copyWith(isFavorite: !message.isFavorite),
          );
        }
      },
    );
  }

  void reset() {
    state = const MessageGenerationState.idle();
  }
}

/// Provides the current month's usage count for the usage counter
/// displayed on the result screen.
@riverpod
class MessageUsage extends _$MessageUsage {
  @override
  Future<({int used, int limit})> build() async {
    final repository = ref.watch(messageRepositoryProvider);
    final result = await repository.getUsageCount();
    return result.fold(
      (_) => (used: 0, limit: 10),
      (usage) => usage,
    );
  }
}
