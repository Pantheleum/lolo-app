import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';

/// Remote data source for onboarding API calls.
///
/// Handles two sequential API calls on completion:
/// 1. POST /auth/register -- create user account (if email auth)
/// 2. POST /profiles -- create partner profile
class OnboardingRemoteDataSource {
  final Dio _dio;

  const OnboardingRemoteDataSource(this._dio);

  /// Register user via email. Returns the Firebase UID and tokens.
  ///
  /// Skipped for Google/Apple auth (handled by firebase_auth SDK).
  Future<Map<String, dynamic>> registerWithEmail({
    required String email,
    required String password,
    required String displayName,
    required String language,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.authRegister,
      data: {
        'email': email,
        'password': password,
        'displayName': displayName,
        'language': language,
      },
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// Create the partner profile after authentication.
  Future<Map<String, dynamic>> createProfile(
    OnboardingDataModel model,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.profiles,
      data: model.toProfilePayload(),
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// Mark onboarding as complete on the user's auth profile.
  Future<void> markOnboardingComplete() async {
    await _dio.put(
      ApiEndpoints.authProfile,
      data: {'onboardingComplete': true},
    );
  }
}
