import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';
import 'package:lolo/features/gift_engine/data/models/gift_recommendation_model.dart';

/// Remote data source for the Gift Recommendation Engine.
///
/// Communicates with the backend REST API via Dio.
class GiftRemoteDataSource {
  final Dio _dio;
  const GiftRemoteDataSource(this._dio);

  /// GET /gifts/categories — browse gifts with filters.
  Future<List<GiftRecommendationModel>> browseGifts({
    int page = 1,
    int pageSize = 20,
    String? category,
    String? searchQuery,
    bool? lowBudgetOnly,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiEndpoints.giftsCategories,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (category != null) 'category': category,
        if (searchQuery != null) 'search': searchQuery,
        if (lowBudgetOnly == true) 'lowBudget': true,
      },
    );
    final dataList = response.data['data'] as List;
    return dataList
        .map((e) =>
            GiftRecommendationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /gifts/categories/:id — get a single gift by ID.
  Future<GiftRecommendationModel> getGiftById(String id) async {
    final response = await _dio.get<dynamic>('${ApiEndpoints.giftsCategories}/$id');
    return GiftRecommendationModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  /// POST /gifts/recommend — get AI-powered recommendations.
  Future<List<GiftRecommendationModel>> getAiRecommendations({
    String? occasion,
    String? city,
    String? country,
  }) async {
    final response = await _dio.post<dynamic>(
      ApiEndpoints.giftsRecommend,
      data: {
        if (occasion != null) 'occasion': occasion,
        if (city != null) 'city': city,
        if (country != null) 'country': country,
      },
    );
    final dataList = response.data['data'] as List;
    return dataList
        .map((e) =>
            GiftRecommendationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// POST /gifts/wishlist — toggle save/favorite on a gift.
  Future<void> toggleSave(String giftId) async {
    await _dio.post<dynamic>(
      ApiEndpoints.giftsWishlist,
      data: {'giftId': giftId},
    );
  }

  /// POST /gifts/:id/feedback — submit like/dislike feedback.
  Future<void> submitFeedback({
    required String giftId,
    required bool liked,
  }) async {
    await _dio.post<dynamic>(
      ApiEndpoints.giftFeedback(giftId),
      data: {'liked': liked},
    );
  }

  /// GET /gifts/categories/:id/related — get related gifts.
  Future<List<GiftRecommendationModel>> getRelatedGifts(String giftId) async {
    final response =
        await _dio.get<dynamic>('${ApiEndpoints.giftsCategories}/$giftId/related');
    final dataList = response.data['data'] as List;
    return dataList
        .map((e) =>
            GiftRecommendationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /gifts/history — get past gift recommendations.
  Future<List<GiftRecommendationModel>> getGiftHistory({
    int page = 1,
    int pageSize = 20,
    bool? likedOnly,
    bool? dislikedOnly,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiEndpoints.giftsHistory,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (likedOnly == true) 'liked': true,
        if (dislikedOnly == true) 'disliked': true,
      },
    );
    final dataList = response.data['data'] as List;
    return dataList
        .map((e) =>
            GiftRecommendationModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
