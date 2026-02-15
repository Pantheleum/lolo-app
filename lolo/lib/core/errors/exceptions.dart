/// Base exception types for the LOLO app.
///
/// These are thrown in the Data layer and caught by Repository implementations,
/// which convert them to [Failure] types for the Domain layer.

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  final String? code;

  const ServerException({
    required this.message,
    this.statusCode,
    this.code,
  });

  @override
  String toString() => 'ServerException($statusCode): $message';
}

class CacheException implements Exception {
  final String message;

  const CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception {
  final String message;

  const NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class AuthException implements Exception {
  final String message;
  final String? code;

  const AuthException({required this.message, this.code});

  @override
  String toString() => 'AuthException($code): $message';
}

class ValidationException implements Exception {
  final String message;
  final Map<String, String>? fieldErrors;

  const ValidationException({required this.message, this.fieldErrors});

  @override
  String toString() => 'ValidationException: $message';
}

class TierLimitException implements Exception {
  final String message;
  final String? requiredTier;

  const TierLimitException({required this.message, this.requiredTier});

  @override
  String toString() => 'TierLimitException: $message';
}
