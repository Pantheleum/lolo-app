import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

part 'onboarding_state.freezed.dart';

/// All possible states for the onboarding flow.
@freezed
class OnboardingState with _$OnboardingState {
  /// Initial state before any data is loaded.
  const factory OnboardingState.initial() = _Initial;

  /// Loading a saved draft or submitting data.
  const factory OnboardingState.loading() = _Loading;

  /// Active onboarding flow with current data and step.
  const factory OnboardingState.active({
    required OnboardingDataEntity data,
    required int currentStep,
    @Default(8) int totalSteps,
  }) = _Active;

  /// Authentication in progress (step 3).
  const factory OnboardingState.authenticating() = _Authenticating;

  /// Generating the first action card (step 8).
  const factory OnboardingState.generatingFirstCard({
    required String partnerName,
    String? cardContent,
  }) = _GeneratingFirstCard;

  /// Onboarding completed successfully.
  const factory OnboardingState.completed() = _Completed;

  /// An error occurred.
  const factory OnboardingState.error({
    required String message,
    OnboardingDataEntity? lastData,
  }) = _Error;
}
