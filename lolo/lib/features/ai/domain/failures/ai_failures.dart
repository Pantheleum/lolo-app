import 'package:lolo/core/errors/failures.dart';

class AiTierLimitFailure extends Failure {
  const AiTierLimitFailure({required super.message, super.code});
}

class ContentSafetyFailure extends Failure {
  const ContentSafetyFailure({required super.message, super.code});
}

class RateLimitFailure extends Failure {
  final int? retryAfter;
  const RateLimitFailure({required super.message, super.code, this.retryAfter});
}

class AiServiceUnavailableFailure extends Failure {
  const AiServiceUnavailableFailure({required super.message, super.code});
}

class AiValidationFailure extends Failure {
  const AiValidationFailure({required super.message, super.code});
}

class AiAuthFailure extends Failure {
  const AiAuthFailure({required super.message, super.code});
}

class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code});
}

class NotFoundFailure extends Failure {
  const NotFoundFailure({required super.message, super.code});
}
