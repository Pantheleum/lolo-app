import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Submits the completed onboarding data to the backend and clears
/// the local draft.
///
/// Precondition: [OnboardingDataEntity.canComplete] must be true.
/// The use case validates this before attempting the network call.
class CompleteOnboardingUseCase {
  final OnboardingRepository _repository;

  const CompleteOnboardingUseCase(this._repository);

  Future<Either<Failure, void>> call(OnboardingDataEntity data) async {
    if (!data.canComplete) {
      return const Left(
        ValidationFailure(message: 'Onboarding data is incomplete'),
      );
    }

    final result = await _repository.completeOnboarding(data);

    // Clear local draft only on success
    return result.fold(
      Left.new,
      (_) async {
        await _repository.clearDraft();
        return const Right(null);
      },
    );
  }
}
