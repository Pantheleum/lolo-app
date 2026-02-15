/// Failure types for Clean Architecture error handling.
///
/// Use cases return `Result<T>` which wraps either a [Failure] or success data.
sealed class Failure {
  final String message;
  final String? code;

  const Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    required super.message,
    super.code,
    this.fieldErrors,
  });
}

class TierLimitFailure extends Failure {
  final String requiredTier;

  const TierLimitFailure({
    required super.message,
    required this.requiredTier,
    super.code,
  });
}
