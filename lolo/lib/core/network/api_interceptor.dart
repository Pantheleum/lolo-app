import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/localization/locale_provider.dart';
import 'package:lolo/core/constants/app_constants.dart';

/// Injects Firebase Auth ID token and standard headers into every request.
///
/// Headers added:
/// - Authorization: Bearer <Firebase ID token>
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
    // Get Firebase Auth ID token (auto-refreshes when expired)
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final token = await user.getIdToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
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
    // Handle 401: force-refresh the token and retry once
    if (err.response?.statusCode == 401) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        try {
          final freshToken = await user.getIdToken(true);
          err.requestOptions.headers['Authorization'] = 'Bearer $freshToken';
          final response = await Dio().fetch<dynamic>(err.requestOptions);
          return handler.resolve(response);
        } on DioException catch (retryError) {
          return handler.next(retryError);
        } catch (_) {
          // Force refresh failed
        }
      }
    }
    handler.next(err);
  }

  String _generateRequestId() {
    final now = DateTime.now().microsecondsSinceEpoch;
    return '$now-${now.hashCode.toRadixString(16)}';
  }
}
