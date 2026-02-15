import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Persists the current onboarding state locally after each step.
///
/// This ensures the user can kill the app and resume exactly where
/// they left off. The draft is stored in Hive as a JSON map.
class SaveOnboardingStepUseCase {
  final OnboardingRepository _repository;

  const SaveOnboardingStepUseCase(this._repository);

  Future<Either<Failure, void>> call(OnboardingDataEntity data) =>
      _repository.saveDraft(data);
}
