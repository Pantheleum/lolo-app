/// Typed network exceptions for the LOLO app.
///
/// Each variant maps to a specific HTTP error category.
/// Use pattern matching to handle different error types in the UI.
sealed class NetworkException implements Exception {
  const NetworkException();

  const factory NetworkException.noConnection() = NoConnectionException;
  const factory NetworkException.timeout() = TimeoutException;
  const factory NetworkException.unauthorized() = UnauthorizedException;
  const factory NetworkException.forbidden({
    required String code,
    String? message,
  }) = ForbiddenException;
  const factory NetworkException.badRequest({
    String? message,
    String? code,
  }) = BadRequestException;
  const factory NetworkException.notFound({String? message}) =
      NotFoundException;
  const factory NetworkException.conflict({
    String? message,
    String? code,
  }) = ConflictException;
  const factory NetworkException.rateLimited() = RateLimitedException;
  const factory NetworkException.serverError({String? message}) =
      ServerErrorException;
  const factory NetworkException.unknown({String? message}) =
      UnknownNetworkException;

  String? get userMessage;
}

class NoConnectionException extends NetworkException {
  const NoConnectionException();

  @override
  String get userMessage => 'No internet connection. Check your network.';
}

class TimeoutException extends NetworkException {
  const TimeoutException();

  @override
  String get userMessage => 'Request timed out. Please try again.';
}

class UnauthorizedException extends NetworkException {
  const UnauthorizedException();

  @override
  String get userMessage => 'Session expired. Please log in again.';
}

class ForbiddenException extends NetworkException {
  final String code;
  @override
  final String? userMessage;

  const ForbiddenException({required this.code, String? message})
      : userMessage = message ?? 'Access denied.';
}

class BadRequestException extends NetworkException {
  @override
  final String? userMessage;
  final String? code;

  const BadRequestException({String? message, this.code})
      : userMessage = message ?? 'Invalid request.';
}

class NotFoundException extends NetworkException {
  @override
  final String? userMessage;

  const NotFoundException({String? message})
      : userMessage = message ?? 'Resource not found.';
}

class ConflictException extends NetworkException {
  @override
  final String? userMessage;
  final String? code;

  const ConflictException({String? message, this.code})
      : userMessage = message ?? 'Conflict detected.';
}

class RateLimitedException extends NetworkException {
  const RateLimitedException();

  @override
  String get userMessage => 'Too many requests. Please wait a moment.';
}

class ServerErrorException extends NetworkException {
  @override
  final String? userMessage;

  const ServerErrorException({String? message})
      : userMessage = message ?? 'Server error. We are working on it.';
}

class UnknownNetworkException extends NetworkException {
  @override
  final String? userMessage;

  const UnknownNetworkException({String? message})
      : userMessage = message ?? 'Something went wrong.';
}
