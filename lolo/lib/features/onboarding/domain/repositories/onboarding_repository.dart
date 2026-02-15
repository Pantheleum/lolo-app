import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';

/// Contract for onboarding data persistence and submission.
///
/// The implementation saves drafts locally (Hive) so the user can
/// resume if they close the app mid-flow, then syncs everything
/// to the backend on [completeOnboarding].
abstract class OnboardingRepository {
  /// Persist the current onboarding draft locally.
  ///
  /// Called after every step so progress is never lost.
  Future<Either<Failure, void>> saveDraft(OnboardingDataEntity data);

  /// Load a previously saved draft, if any.
  ///
  /// Returns null (wrapped in Right) if no draft exists.
  Future<Either<Failure, OnboardingDataEntity?>> loadDraft();

  /// Clear the local draft after successful completion.
  Future<Either<Failure, void>> clearDraft();

  /// Submit completed onboarding data to the backend.
  ///
  /// This calls POST /auth/register (or /auth/social) if not yet
  /// authenticated, then POST /profiles to create the partner profile,
  /// then PATCH /auth/profile to mark onboarding complete.
  Future<Either<Failure, void>> completeOnboarding(
    OnboardingDataEntity data,
  );
}
