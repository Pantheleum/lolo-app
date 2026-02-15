import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';

/// Contract for gift recommendation operations.
abstract class GiftRepository {
  /// Browse gifts with category filter, search, and budget filter.
  Future<Either<Failure, List<GiftRecommendationEntity>>> browseGifts({
    int page = 1,
    int pageSize = 20,
    GiftCategory? category,
    String? searchQuery,
    bool? lowBudgetOnly,
  });

  /// Get a single gift by ID.
  Future<Either<Failure, GiftRecommendationEntity>> getGiftById(String id);

  /// Get AI-powered gift recommendations based on partner profile.
  Future<Either<Failure, List<GiftRecommendationEntity>>>
      getAiRecommendations();

  /// Toggle the saved/favorite status of a gift.
  Future<Either<Failure, void>> toggleSave(String giftId);

  /// Submit feedback for a gift recommendation.
  Future<Either<Failure, void>> submitFeedback({
    required String giftId,
    required bool liked,
  });

  /// Get related gifts for a given gift.
  Future<Either<Failure, List<GiftRecommendationEntity>>> getRelatedGifts(
    String giftId,
  );

  /// Get gift history with optional feedback filter.
  Future<Either<Failure, List<GiftRecommendationEntity>>> getGiftHistory({
    int page = 1,
    int pageSize = 20,
    bool? likedOnly,
    bool? dislikedOnly,
  });
}
