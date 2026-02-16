import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';
import 'package:lolo/features/her_profile/data/models/partner_profile_model.dart';

/// Remote data source for the Her Profile Engine.
///
/// Communicates with the /profiles API endpoints.
class HerProfileRemoteDataSource {
  final Dio _dio;
  const HerProfileRemoteDataSource(this._dio);

  /// GET /profiles/:id
  Future<PartnerProfileModel> getProfile(String profileId) async {
    final response = await _dio.get('${ApiEndpoints.profiles}/$profileId');
    return PartnerProfileModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  /// PUT /profiles/:id (partial update)
  Future<PartnerProfileModel> updateProfile(
    String profileId,
    Map<String, dynamic> updates,
  ) async {
    await _dio.put(
      '${ApiEndpoints.profiles}/$profileId',
      data: updates,
    );
    // Refetch full profile after update
    return getProfile(profileId);
  }

  /// PUT /profiles/:id/preferences
  Future<Map<String, dynamic>> updatePreferences(
    String profileId,
    Map<String, dynamic> preferences,
  ) async {
    final response = await _dio.put(
      '${ApiEndpoints.profiles}/$profileId/preferences',
      data: preferences,
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// PUT /profiles/:id/cultural-context
  Future<Map<String, dynamic>> updateCulturalContext(
    String profileId,
    Map<String, dynamic> context,
  ) async {
    final response = await _dio.put(
      '${ApiEndpoints.profiles}/$profileId/cultural-context',
      data: context,
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// GET /profiles/:id/zodiac-defaults?sign=scorpio
  Future<Map<String, dynamic>> getZodiacDefaults(String sign) async {
    final response = await _dio.get(
      '${ApiEndpoints.profiles}/zodiac-defaults',
      queryParameters: {'sign': sign},
    );
    return response.data['data'] as Map<String, dynamic>;
  }
}
