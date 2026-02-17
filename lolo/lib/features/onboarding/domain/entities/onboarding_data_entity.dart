import 'package:freezed_annotation/freezed_annotation.dart';

part 'onboarding_data_entity.freezed.dart';

/// Immutable entity representing the full onboarding data collected
/// across all 8 steps of the onboarding flow.
///
/// Fields are nullable because they are populated incrementally --
/// each step fills in its portion. Only [language] is required from step 1.
@freezed
class OnboardingDataEntity with _$OnboardingDataEntity {
  const factory OnboardingDataEntity({
    /// User's preferred language, set on the very first screen.
    @Default('en') String language,

    /// The user's display name (step 4).
    String? userName,

    /// Partner's name (step 5).
    String? partnerName,

    /// Partner's nickname for casual/flirty messages, e.g. 'Habibi', 'Babe'.
    String? partnerNickname,

    /// Partner's zodiac sign key, e.g. 'scorpio' (step 5).
    String? partnerZodiac,

    /// Relationship status enum: dating, engaged, married (step 6).
    String? relationshipStatus,

    /// The key date value -- anniversary or wedding date (step 7).
    DateTime? keyDate,

    /// What [keyDate] represents: 'dating_anniversary' or 'wedding_date'.
    String? keyDateType,

    /// Email for email/password sign-up (step 3).
    String? email,

    /// Auth provider used: 'email', 'google', 'apple' (step 3).
    String? authProvider,

    /// Firebase UID assigned after successful authentication (step 3).
    String? firebaseUid,

    /// Current step index (0-7) for resume support.
    @Default(0) int currentStep,

    /// Whether the entire flow has been submitted to the backend.
    @Default(false) bool isComplete,
  }) = _OnboardingDataEntity;

  const OnboardingDataEntity._();

  /// Checks whether the minimum required fields for backend submission
  /// are present: authenticated + name + partner name + status.
  bool get canComplete =>
      firebaseUid != null &&
      userName != null &&
      userName!.isNotEmpty &&
      partnerName != null &&
      partnerName!.isNotEmpty &&
      relationshipStatus != null;

  /// Profile completion percentage for the progress indicator.
  double get completionPercent {
    var filled = 0;
    const total = 7;
    if (userName != null && userName!.isNotEmpty) filled++;
    if (partnerName != null && partnerName!.isNotEmpty) filled++;
    if (partnerZodiac != null) filled++;
    if (relationshipStatus != null) filled++;
    if (keyDate != null) filled++;
    if (keyDateType != null) filled++;
    if (firebaseUid != null) filled++;
    return filled / total;
  }
}
