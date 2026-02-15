import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';

part 'gift_recommendation_entity.freezed.dart';

/// Immutable entity for a gift recommendation.
///
/// Contains the gift details, AI reasoning, trait matches,
/// save status, and user feedback.
@freezed
class GiftRecommendationEntity with _$GiftRecommendationEntity {
  const factory GiftRecommendationEntity({
    required String id,
    required String name,
    required String priceRange,
    required GiftCategory category,
    String? imageUrl,
    String? whySheLoveIt,
    @Default([]) List<String> matchedTraits,
    String? buyUrl,
    @Default(false) bool isSaved,
    @Default(false) bool isLowBudget,
    DateTime? createdAt,
    /// null = no feedback, true = liked, false = disliked
    bool? feedback,
    String? learningNote,
  }) = _GiftRecommendationEntity;
}
