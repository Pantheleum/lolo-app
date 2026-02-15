// FILE: lib/features/ai/domain/failures/ai_failures.dart

import 'package:lolo/core/errors/failures.dart';

class TierLimitFailure extends Failure {
  const TierLimitFailure(super.message);
}

class ContentSafetyFailure extends Failure {
  const ContentSafetyFailure(super.message);
}

class RateLimitFailure extends Failure {
  final int? retryAfter;
  const RateLimitFailure(super.message, {this.retryAfter});
}

class AiServiceUnavailableFailure extends Failure {
  const AiServiceUnavailableFailure(super.message);
}

class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

class PermissionFailure extends Failure {
  const PermissionFailure(super.message);
}

class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}
