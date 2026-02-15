import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/auth/domain/entities/auth_user.dart';
import 'package:lolo/features/auth/domain/repositories/auth_repository.dart';

/// Firebase Auth backed implementation of [AuthRepository].
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
  })  : _auth = auth,
        _googleSignIn = googleSignIn;

  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthUser? _mapFirebaseUser(User? user) {
    if (user == null) return null;
    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
      createdAt: user.metadata.creationTime,
    );
  }

  @override
  Stream<AuthUser?> get authStateChanges =>
      _auth.authStateChanges().map(_mapFirebaseUser);

  @override
  AuthUser? get currentUser => _mapFirebaseUser(_auth.currentUser);

  @override
  Future<Either<Failure, AuthUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = _mapFirebaseUser(credential.user);
      if (user == null) {
        return const Left(AuthFailure(message: 'Sign in failed'));
      }
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(
        message: _mapAuthErrorMessage(e.code),
        code: e.code,
      ));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (displayName != null) {
        await credential.user?.updateDisplayName(displayName);
        await credential.user?.reload();
      }
      final user = _mapFirebaseUser(_auth.currentUser);
      if (user == null) {
        return const Left(AuthFailure(message: 'Sign up failed'));
      }
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(
        message: _mapAuthErrorMessage(e.code),
        code: e.code,
      ));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return const Left(AuthFailure(message: 'Google sign in cancelled'));
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final result = await _auth.signInWithCredential(credential);
      final user = _mapFirebaseUser(result.user);
      if (user == null) {
        return const Left(AuthFailure(message: 'Google sign in failed'));
      }
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthUser>> signInWithApple() async {
    try {
      final appleProvider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');
      final result = await _auth.signInWithProvider(appleProvider);
      final user = _mapFirebaseUser(result.user);
      if (user == null) {
        return const Left(AuthFailure(message: 'Apple sign in failed'));
      }
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(
        message: _mapAuthErrorMessage(e.code),
        code: e.code,
      ));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAccount() async {
    try {
      await _auth.currentUser?.delete();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(
        message: _mapAuthErrorMessage(e.code),
        code: e.code,
      ));
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }

  String _mapAuthErrorMessage(String code) => switch (code) {
        'user-not-found' => 'No account found with this email',
        'wrong-password' => 'Incorrect password',
        'email-already-in-use' => 'An account already exists with this email',
        'weak-password' => 'Password must be at least 6 characters',
        'invalid-email' => 'Please enter a valid email address',
        'user-disabled' => 'This account has been disabled',
        'too-many-requests' => 'Too many attempts. Please try again later',
        'requires-recent-login' =>
          'Please sign in again before deleting your account',
        _ => 'Authentication failed. Please try again',
      };
}
