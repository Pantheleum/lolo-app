import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/network/api_interceptor.dart';
import 'package:lolo/core/network/error_interceptor.dart';
import 'package:lolo/core/constants/app_constants.dart';

part 'dio_client.g.dart';

/// Singleton Dio instance with LOLO interceptors.
///
/// Interceptor chain (order matters):
/// 1. ApiInterceptor -- injects auth token, Accept-Language, X-Client-Version
/// 2. ErrorInterceptor -- maps HTTP errors to typed Failures
/// 3. LogInterceptor -- debug-only request/response logging
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 15),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // 1. Auth + headers interceptor
  dio.interceptors.add(
    ApiInterceptor(ref: ref),
  );

  // 2. Error mapping interceptor
  dio.interceptors.add(
    ErrorInterceptor(),
  );

  // 3. Logging (debug only)
  assert(
    () {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (obj) => print('[DIO] $obj'),
        ),
      );
      return true;
    }(),
  );

  return dio;
}
