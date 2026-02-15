import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/api_client.dart';
import 'package:lolo/features/ai_messages/domain/entities/generated_message_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_length.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_mode.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_request_entity.dart';
import 'package:lolo/features/ai_messages/domain/entities/message_tone.dart';

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

/// API-backed implementation of [MessageRepository].
///
/// Delegates HTTP calls to [ApiClient] and maps JSON responses
/// to domain entities.
class MessageRepositoryImpl implements MessageRepository {
  final ApiClient _api;

  MessageRepositoryImpl({required ApiClient api}) : _api = api;

  @override
  Future<Either<Failure, GeneratedMessageEntity>> generateMessage(
    MessageRequestEntity request,
  ) async {
    try {
      final response = await _api.post('/ai/messages/generate', data: {
        'mode': request.mode.name,
        'tone': request.tone.name,
        'length': request.length.name,
        'humorLevel': request.humorLevel,
        'languageCode': request.languageCode,
        'includePartnerName': request.includePartnerName,
        if (request.contextText != null) 'contextText': request.contextText,
      });
      final data = response.data['data'] as Map<String, dynamic>;
      return Right(_mapMessage(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GeneratedMessageEntity>> regenerateMessage(
    String originalMessageId,
  ) async {
    try {
      final response = await _api.post(
        '/ai/messages/$originalMessageId/regenerate',
      );
      final data = response.data['data'] as Map<String, dynamic>;
      return Right(_mapMessage(data));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> rateMessage({
    required String messageId,
    required int rating,
  }) async {
    try {
      await _api.post('/ai/messages/$messageId/rate', data: {'rating': rating});
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String messageId) async {
    try {
      await _api.post('/ai/messages/$messageId/favorite');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GeneratedMessageEntity>>> getMessageHistory({
    int page = 1,
    int pageSize = 20,
    bool? favoritesOnly,
    MessageMode? modeFilter,
    String? searchQuery,
  }) async {
    try {
      final response = await _api.get('/ai/messages/history', queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (favoritesOnly != null) 'favoritesOnly': favoritesOnly,
        if (modeFilter != null) 'mode': modeFilter.name,
        if (searchQuery != null) 'search': searchQuery,
      });
      final list = (response.data['data'] as List)
          .map((e) => _mapMessage(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ({int used, int limit})>> getUsageCount() async {
    try {
      final response = await _api.get('/ai/messages/usage');
      final data = response.data['data'] as Map<String, dynamic>;
      return Right((
        used: data['used'] as int,
        limit: data['limit'] as int,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  GeneratedMessageEntity _mapMessage(Map<String, dynamic> m) {
    return GeneratedMessageEntity(
      id: m['id'] as String,
      content: m['content'] as String,
      mode: MessageMode.values.firstWhere(
        (e) => e.name == m['mode'],
        orElse: () => MessageMode.romantic,
      ),
      tone: MessageTone.values.firstWhere(
        (e) => e.name == m['tone'],
        orElse: () => MessageTone.heartfelt,
      ),
      length: MessageLength.values.firstWhere(
        (e) => e.name == m['length'],
        orElse: () => MessageLength.medium,
      ),
      createdAt: DateTime.parse(m['createdAt'] as String),
      rating: m['rating'] as int? ?? 0,
      isFavorite: m['isFavorite'] as bool? ?? false,
      modelBadge: m['modelBadge'] as String?,
      languageCode: m['languageCode'] as String?,
      context: m['context'] as String?,
      includePartnerName: m['includePartnerName'] as bool? ?? false,
    );
  }
}

/// Provider for [MessageRepository], backed by [ApiClient].
final messageRepositoryProvider = Provider<MessageRepository>((ref) {
  return MessageRepositoryImpl(api: ref.watch(apiClientProvider));
});
