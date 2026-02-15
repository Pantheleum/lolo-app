import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';

/// Data model for gift recommendations from the API.
///
/// Handles JSON serialization and conversion to/from domain entity.
class GiftRecommendationModel {
  final String id;
  final String name;
  final String priceRange;
  final String category;
  final String? imageUrl;
  final String? whySheLoveIt;
  final List<String> matchedTraits;
  final String? buyUrl;
  final bool isSaved;
  final bool isLowBudget;
  final DateTime? createdAt;
  final bool? feedback;
  final String? learningNote;

  const GiftRecommendationModel({
    required this.id,
    required this.name,
    required this.priceRange,
    required this.category,
    this.imageUrl,
    this.whySheLoveIt,
    this.matchedTraits = const [],
    this.buyUrl,
    this.isSaved = false,
    this.isLowBudget = false,
    this.createdAt,
    this.feedback,
    this.learningNote,
  });

  factory GiftRecommendationModel.fromJson(Map<String, dynamic> json) {
    return GiftRecommendationModel(
      id: json['id'] as String,
      name: json['name'] as String,
      priceRange: json['priceRange'] as String? ?? '',
      category: json['category'] as String? ?? 'all',
      imageUrl: json['imageUrl'] as String?,
      whySheLoveIt: json['whySheLoveIt'] as String?,
      matchedTraits: (json['matchedTraits'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      buyUrl: json['buyUrl'] as String?,
      isSaved: json['isSaved'] as bool? ?? false,
      isLowBudget: json['isLowBudget'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'] as String)
          : null,
      feedback: json['feedback'] as bool?,
      learningNote: json['learningNote'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'priceRange': priceRange,
        'category': category,
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (whySheLoveIt != null) 'whySheLoveIt': whySheLoveIt,
        'matchedTraits': matchedTraits,
        if (buyUrl != null) 'buyUrl': buyUrl,
        'isSaved': isSaved,
        'isLowBudget': isLowBudget,
        if (createdAt != null) 'createdAt': createdAt!.toIso8601String(),
        if (feedback != null) 'feedback': feedback,
        if (learningNote != null) 'learningNote': learningNote,
      };

  /// Convert to domain entity.
  GiftRecommendationEntity toEntity() {
    return GiftRecommendationEntity(
      id: id,
      name: name,
      priceRange: priceRange,
      category: _parseCategory(category),
      imageUrl: imageUrl,
      whySheLoveIt: whySheLoveIt,
      matchedTraits: matchedTraits,
      buyUrl: buyUrl,
      isSaved: isSaved,
      isLowBudget: isLowBudget,
      createdAt: createdAt,
      feedback: feedback,
      learningNote: learningNote,
    );
  }

  /// Parse category string into enum.
  static GiftCategory _parseCategory(String value) {
    return GiftCategory.values.firstWhere(
      (c) => c.name == value,
      orElse: () => GiftCategory.all,
    );
  }
}
