import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/localization/locale_provider.dart';
import 'package:lolo/core/storage/secure_storage_service.dart';
import 'package:lolo/core/constants/app_constants.dart';

/// Injects authentication token and standard headers into every request.
///
/// Headers added:
/// - Authorization: Bearer <token>
/// - Accept-Language: en|ar|ms
/// - X-Client-Version: app version
/// - X-Platform: ios|android
/// - X-Request-Id: UUID v4 per request
class ApiInterceptor extends Interceptor {
  final Ref _ref;

  ApiInterceptor({required Ref ref}) : _ref = ref;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Auth token
    final token = await SecureStorageService.getAuthToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    // Locale
    final locale = _ref.read(localeProvider);
    options.headers['Accept-Language'] = locale.languageCode;

    // Client metadata
    options.headers['X-Client-Version'] = AppConstants.appVersion;
    options.headers['X-Platform'] = AppConstants.platform;
    options.headers['X-Request-Id'] = _generateRequestId();

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // Handle 401: attempt token refresh
    if (err.response?.statusCode == 401) {
      final refreshed = await _attemptTokenRefresh();
      if (refreshed) {
        // Retry the original request with new token
        final token = await SecureStorageService.getAuthToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        try {
          final response = await Dio().fetch<dynamic>(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryError) {
          return handler.next(retryError);
        }
      }
    }
    handler.next(err);
  }

  Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshToken = await SecureStorageService.getRefreshToken();
      if (refreshToken == null) return false;

      final response = await Dio().post<dynamic>(
        '${AppConstants.baseUrl}/auth/refresh-token',
        data: {'refreshToken': refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data['data'];
        await SecureStorageService.saveAuthToken(data['idToken'] as String);
        await SecureStorageService.saveRefreshToken(
          data['refreshToken'] as String,
        );
        return true;
      }
    } catch (_) {
      // Refresh failed -- user will need to re-authenticate
    }
    return false;
  }

  String _generateRequestId() {
    // Simple UUID v4 approximation
    final now = DateTime.now().microsecondsSinceEpoch;
    return '$now-${now.hashCode.toRadixString(16)}';
  }
}
