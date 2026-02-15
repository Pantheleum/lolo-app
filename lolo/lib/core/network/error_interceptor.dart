import 'package:dio/dio.dart';
import 'package:lolo/core/network/network_exceptions.dart';

/// Maps Dio errors to typed [NetworkException] instances.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final exception = _mapDioError(err);
    handler.next(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: exception,
      ),
    );
  }

  NetworkException _mapDioError(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return const NetworkException.timeout();
    }

    if (err.type == DioExceptionType.connectionError) {
      return const NetworkException.noConnection();
    }

    final statusCode = err.response?.statusCode;
    final errorBody = err.response?.data;
    final errorMap = (errorBody is Map) ? errorBody['error'] : null;
    final errorCode = (errorMap is Map) ? errorMap['code'] as String? : null;
    final errorMessage = (errorMap is Map) ? errorMap['message'] as String? : null;

    return switch (statusCode) {
      400 => NetworkException.badRequest(
          message: errorMessage as String? ?? 'Invalid request',
          code: errorCode as String?,
        ),
      401 => const NetworkException.unauthorized(),
      403 => NetworkException.forbidden(
          code: errorCode as String? ?? 'PERMISSION_DENIED',
          message: errorMessage as String? ?? 'Access denied',
        ),
      404 => NetworkException.notFound(
          message: errorMessage as String? ?? 'Not found',
        ),
      409 => NetworkException.conflict(
          message: errorMessage as String? ?? 'Conflict',
          code: errorCode as String?,
        ),
      429 => const NetworkException.rateLimited(),
      500 || 502 || 503 => NetworkException.serverError(
          message: errorMessage as String? ?? 'Server error',
        ),
      _ => NetworkException.unknown(
          message: err.message ?? 'Unknown error',
        ),
    };
  }
}
