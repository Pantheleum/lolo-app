// FILE: lib/features/ai/domain/repositories/ai_repository.dart

import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

abstract class AiRepository {
  // --- Messages ---
  Future<Either<Failure, AiMessageResponse>> generateMessage(AiMessageRequest request);
  Future<Either<Failure, List<AiMessageResponse>>> getMessageHistory({
    AiMessageMode? mode,
    bool? favoritesOnly,
    int limit = 20,
    String? lastDocId,
  });
  Future<Either<Failure, void>> toggleFavorite(String messageId, bool isFavorited);
  Future<Either<Failure, void>> submitFeedback(String messageId, String feedback);

  // --- Gifts ---
  Future<Either<Failure, GiftRecommendationResponse>> getGiftRecommendations(
      GiftRecommendationRequest request);
  Future<Either<Failure, void>> submitGiftFeedback(String giftId, String outcome,
      {String? comment});

  // --- SOS ---
  Future<Either<Failure, SosActivateResponse>> activateSos(SosActivateRequest request);
  Future<Either<Failure, SosAssessResponse>> assessSos(SosAssessRequest request);
  Future<Either<Failure, SosCoachResponse>> getCoaching(SosCoachRequest request);
  Stream<SosCoachingEvent> streamCoaching(SosCoachRequest request);

  // --- Action Cards ---
  Future<Either<Failure, ActionCardsResponse>> getDailyCards({
    String? date,
    bool forceRefresh = false,
  });
  Future<Either<Failure, CardCompleteResponse>> completeCard(String cardId, {String? notes});
  Future<Either<Failure, ActionCard?>> skipCard(String cardId, {String? reason});
  Future<Either<Failure, void>> saveCard(String cardId);

  // --- Usage ---
  Future<Either<Failure, AiUsageInfo>> getUsage(AiRequestType type);
}

class SosCoachingEvent {
  final String eventType;
  final Map<String, dynamic> data;
  const SosCoachingEvent({required this.eventType, required this.data});
}
