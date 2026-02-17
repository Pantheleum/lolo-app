import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lolo/core/localization/locale_provider.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:lolo/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:lolo/features/onboarding/domain/usecases/save_onboarding_step_usecase.dart';
import 'package:lolo/features/onboarding/domain/usecases/complete_onboarding_usecase.dart';
import 'package:lolo/features/onboarding/domain/usecases/get_onboarding_progress_usecase.dart';
import 'package:lolo/features/onboarding/presentation/providers/onboarding_state.dart';

// ---------------------------------------------------------------------------
// Data source, repository, and use case providers
// ---------------------------------------------------------------------------

final onboardingLocalDataSourceProvider =
    Provider<OnboardingLocalDataSource>((ref) {
  return OnboardingLocalDataSource();
});

final onboardingRemoteDataSourceProvider =
    Provider<OnboardingRemoteDataSource>((ref) {
  return OnboardingRemoteDataSource(ref.watch(dioProvider));
});

final onboardingRepositoryProvider = Provider<OnboardingRepository>((ref) {
  return OnboardingRepositoryImpl(
    localDataSource: ref.watch(onboardingLocalDataSourceProvider),
    remoteDataSource: ref.watch(onboardingRemoteDataSourceProvider),
  );
});

final saveOnboardingStepUseCaseProvider =
    Provider<SaveOnboardingStepUseCase>((ref) {
  return SaveOnboardingStepUseCase(ref.watch(onboardingRepositoryProvider));
});

final completeOnboardingUseCaseProvider =
    Provider<CompleteOnboardingUseCase>((ref) {
  return CompleteOnboardingUseCase(ref.watch(onboardingRepositoryProvider));
});

final getOnboardingProgressUseCaseProvider =
    Provider<GetOnboardingProgressUseCase>((ref) {
  return GetOnboardingProgressUseCase(ref.watch(onboardingRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Presentation providers
// ---------------------------------------------------------------------------

/// Manages the 8-step onboarding flow state.
///
/// Steps:
/// 0. Language selector (auto-advance on tap)
/// 1. Welcome page (tagline + benefits + CTA)
/// 2. Sign-up page (email / Google / Apple)
/// 3. Your name
/// 4. Her name + zodiac
/// 5. Relationship status
/// 6. Key date (anniversary / wedding)
/// 7. First AI action card (typewriter animation)
class OnboardingNotifier extends Notifier<OnboardingState> {
  late SaveOnboardingStepUseCase _saveStep;
  late CompleteOnboardingUseCase _complete;
  late GetOnboardingProgressUseCase _getProgress;

  @override
  OnboardingState build() {
    _saveStep = ref.watch(saveOnboardingStepUseCaseProvider);
    _complete = ref.watch(completeOnboardingUseCaseProvider);
    _getProgress = ref.watch(getOnboardingProgressUseCaseProvider);

    // Check for saved draft on initialization
    _loadSavedDraft();

    return const OnboardingState.initial();
  }

  OnboardingDataEntity _data = const OnboardingDataEntity();

  /// Load any previously saved draft to support resume.
  Future<void> _loadSavedDraft() async {
    final result = await _getProgress();
    result.fold(
      (_) => null, // No draft, start fresh
      (draft) {
        if (draft != null) {
          _data = draft;
          state = OnboardingState.active(
            data: _data,
            currentStep: _data.currentStep,
          );
        } else {
          state = OnboardingState.active(
            data: _data,
            currentStep: 0,
          );
        }
      },
    );
  }

  /// Step 0: Set language and auto-advance.
  Future<void> setLanguage(String languageCode) async {
    _data = _data.copyWith(language: languageCode, currentStep: 1);

    // Update the app-wide locale
    ref.read(localeNotifierProvider.notifier).setLocale(
          Locale(languageCode),
        );

    await _persistAndAdvance(1);
  }

  /// Step 2: Sign up with email.
  Future<void> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    state = const OnboardingState.authenticating();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _data = _data.copyWith(
        email: email,
        authProvider: 'email',
        firebaseUid: credential.user?.uid,
        currentStep: 3,
      );
      await _persistAndAdvance(3);
    } on FirebaseAuthException catch (e) {
      state = OnboardingState.error(
        message: _mapAuthError(e.code),
        lastData: _data,
      );
    }
  }

  /// Step 2: Sign in with Google.
  Future<void> signInWithGoogle() async {
    state = const OnboardingState.authenticating();
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User cancelled
        state = OnboardingState.active(
          data: _data,
          currentStep: 2,
        );
        return;
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCred =
          await FirebaseAuth.instance.signInWithCredential(credential);

      _data = _data.copyWith(
        email: userCred.user?.email,
        authProvider: 'google',
        firebaseUid: userCred.user?.uid,
        userName: userCred.user?.displayName,
        currentStep: 3,
      );
      await _persistAndAdvance(3);
    } catch (e) {
      state = OnboardingState.error(
        message: e is FirebaseAuthException
            ? _mapAuthError(e.code)
            : 'Google sign-in failed. Please try email sign-up or check your connection.',
        lastData: _data,
      );
    }
  }

  /// Step 2: Sign in with Apple.
  Future<void> signInWithApple() async {
    state = const OnboardingState.authenticating();
    try {
      final appleProvider = AppleAuthProvider()
        ..addScope('email')
        ..addScope('name');

      final userCred =
          await FirebaseAuth.instance.signInWithProvider(appleProvider);

      _data = _data.copyWith(
        email: userCred.user?.email,
        authProvider: 'apple',
        firebaseUid: userCred.user?.uid,
        userName: userCred.user?.displayName,
        currentStep: 3,
      );
      await _persistAndAdvance(3);
    } catch (e) {
      state = OnboardingState.error(
        message: e is FirebaseAuthException
            ? _mapAuthError(e.code)
            : 'Apple sign-in failed. Please try email sign-up.',
        lastData: _data,
      );
    }
  }

  /// Step 3: Set user's name.
  Future<void> setUserName(String name) async {
    _data = _data.copyWith(userName: name, currentStep: 4);
    await _persistAndAdvance(4);
  }

  /// Step 4: Set partner name, optional nickname, and optional zodiac.
  Future<void> setPartnerInfo({
    required String name,
    String? nickname,
    String? zodiacSign,
  }) async {
    _data = _data.copyWith(
      partnerName: name,
      partnerNickname: nickname,
      partnerZodiac: zodiacSign,
      currentStep: 5,
    );
    await _persistAndAdvance(5);
  }

  /// Step 5: Set relationship status.
  Future<void> setRelationshipStatus(String status) async {
    _data = _data.copyWith(
      relationshipStatus: status,
      currentStep: 6,
    );
    await _persistAndAdvance(6);
  }

  /// Step 6: Set key date.
  Future<void> setKeyDate({
    required DateTime date,
    required String dateType,
  }) async {
    _data = _data.copyWith(
      keyDate: date,
      keyDateType: dateType,
      currentStep: 7,
    );
    await _persistAndAdvance(7);
  }

  /// Step 7: Complete onboarding and show first card.
  Future<void> completeAndShowFirstCard() async {
    state = OnboardingState.generatingFirstCard(
      partnerName: _data.partnerName ?? '',
    );

    final result = await _complete(_data);
    result.fold(
      (failure) => state = OnboardingState.error(
        message: failure.message,
        lastData: _data,
      ),
      (_) => state = const OnboardingState.completed(),
    );
  }

  /// Navigate back one step.
  void goBack() {
    final current = _data.currentStep;
    if (current > 0) {
      final newStep = current - 1;
      _data = _data.copyWith(currentStep: newStep);
      state = OnboardingState.active(data: _data, currentStep: newStep);
    }
  }

  /// Advance to the welcome screen (from language).
  Future<void> advanceToWelcome() async {
    _data = _data.copyWith(currentStep: 1);
    await _persistAndAdvance(1);
  }

  /// Advance from welcome to sign-up.
  Future<void> advanceToSignUp() async {
    _data = _data.copyWith(currentStep: 2);
    await _persistAndAdvance(2);
  }

  /// Persist draft and update state to the given step.
  Future<void> _persistAndAdvance(int step) async {
    await _saveStep(_data);
    state = OnboardingState.active(data: _data, currentStep: step);
  }

  /// Map Firebase auth error codes to user-friendly messages.
  String _mapAuthError(String code) => switch (code) {
        'email-already-in-use' => 'This email is already registered.',
        'invalid-email' => 'Please enter a valid email address.',
        'weak-password' => 'Password must be at least 8 characters.',
        'user-not-found' => 'No account found with this email.',
        'wrong-password' => 'Incorrect password.',
        'network-request-failed' => 'Network error. Check your connection.',
        _ => 'Authentication failed. Please try again.',
      };
}

final onboardingNotifierProvider =
    NotifierProvider<OnboardingNotifier, OnboardingState>(
  OnboardingNotifier.new,
);
