import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_request_entity.dart';

/// Contract for AI message generation and history operations.
abstract class MessageRepository {
  /// Generate a new AI message based on the given configuration.
  Future<Either<Failure, GeneratedMessageEntity>> generateMessage(
    MessageRequestEntity request,
  );

  /// Regenerate a message with the same parameters but new output.
  Future<Either<Failure, GeneratedMessageEntity>> regenerateMessage(
    String originalMessageId,
  );

  /// Submit a 1-5 star rating for a generated message.
  Future<Either<Failure, void>> rateMessage({
    required String messageId,
    required int rating,
  });

  /// Toggle the favorite status of a message.
  Future<Either<Failure, void>> toggleFavorite(String messageId);

  /// Get paginated message history with optional filters.
  Future<Either<Failure, List<GeneratedMessageEntity>>> getMessageHistory({
    int page = 1,
    int pageSize = 20,
    bool? favoritesOnly,
    MessageMode? modeFilter,
    String? searchQuery,
  });

  /// Get current month's usage count and limit.
  Future<Either<Failure, ({int used, int limit})>> getUsageCount();
}
