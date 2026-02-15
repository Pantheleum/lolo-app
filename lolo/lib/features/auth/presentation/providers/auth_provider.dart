import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/auth/domain/entities/auth_user.dart';
import 'package:lolo/features/auth/domain/repositories/auth_repository.dart';
import 'package:lolo/features/auth/data/repositories/auth_repository_impl.dart';

part 'auth_provider.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepositoryImpl(
    auth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(),
  );
}

/// Streams the current auth state across the app.
@Riverpod(keepAlive: true)
Stream<AuthUser?> authState(AuthStateRef ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
}

/// Current authenticated user (synchronous read).
@riverpod
AuthUser? currentUser(CurrentUserRef ref) {
  return ref.watch(authRepositoryProvider).currentUser;
}

/// Sign-in notifier for managing loading/error state during authentication.
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithEmail(
          email: email,
          password: password,
        );
    return result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        return false;
      },
      (_) {
        state = const AsyncData(null);
        return true;
      },
    );
  }

  Future<bool> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signUpWithEmail(
          email: email,
          password: password,
          displayName: displayName,
        );
    return result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        return false;
      },
      (_) {
        state = const AsyncData(null);
        return true;
      },
    );
  }

  Future<bool> signInWithGoogle() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithGoogle();
    return result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        return false;
      },
      (_) {
        state = const AsyncData(null);
        return true;
      },
    );
  }

  Future<bool> signInWithApple() async {
    state = const AsyncLoading();
    final result = await ref.read(authRepositoryProvider).signInWithApple();
    return result.fold(
      (failure) {
        state = AsyncError(failure.message, StackTrace.current);
        return false;
      },
      (_) {
        state = const AsyncData(null);
        return true;
      },
    );
  }

  Future<void> sendPasswordReset(String email) async {
    state = const AsyncLoading();
    final result =
        await ref.read(authRepositoryProvider).sendPasswordResetEmail(email);
    state = result.fold(
      (failure) => AsyncError(failure.message, StackTrace.current),
      (_) => const AsyncData(null),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData(null);
  }
}
