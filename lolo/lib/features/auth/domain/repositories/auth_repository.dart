import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/auth/domain/entities/auth_user.dart';

/// Contract for authentication operations.
abstract class AuthRepository {
  /// Stream of authentication state changes.
  Stream<AuthUser?> get authStateChanges;

  /// Get current authenticated user, or null.
  AuthUser? get currentUser;

  /// Sign in with email and password.
  Future<Either<Failure, AuthUser>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Create a new account with email and password.
  Future<Either<Failure, AuthUser>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Sign in with Google.
  Future<Either<Failure, AuthUser>> signInWithGoogle();

  /// Sign in with Apple.
  Future<Either<Failure, AuthUser>> signInWithApple();

  /// Send password reset email.
  Future<Either<Failure, void>> sendPasswordResetEmail(String email);

  /// Sign out the current user.
  Future<Either<Failure, void>> signOut();

  /// Delete the current user account.
  Future<Either<Failure, void>> deleteAccount();
}
