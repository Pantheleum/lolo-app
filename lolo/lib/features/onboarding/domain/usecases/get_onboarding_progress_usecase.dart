import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Loads any previously saved onboarding draft for resume support.
class GetOnboardingProgressUseCase {
  final OnboardingRepository _repository;

  const GetOnboardingProgressUseCase(this._repository);

  Future<Either<Failure, OnboardingDataEntity?>> call() =>
      _repository.loadDraft();
}
