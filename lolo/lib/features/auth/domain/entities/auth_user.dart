import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';

/// Authenticated user entity.
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    @Default(false) bool isEmailVerified,
    @Default('free') String subscriptionTier,
    DateTime? createdAt,
  }) = _AuthUser;

  const AuthUser._();

  /// Whether the user has a premium subscription.
  bool get isPremium => subscriptionTier != 'free';
}
