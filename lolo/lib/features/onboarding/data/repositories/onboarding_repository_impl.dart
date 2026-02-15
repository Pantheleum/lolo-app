import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:lolo/features/onboarding/data/datasources/onboarding_remote_datasource.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';
import 'package:lolo/features/onboarding/domain/entities/onboarding_data_entity.dart';
import 'package:lolo/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Concrete implementation of [OnboardingRepository].
///
/// Strategy: save locally after every step, sync to backend on complete.
/// Local draft uses Hive (fast, no schema needed).
/// Backend sync uses Dio via [OnboardingRemoteDataSource].
class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource _localDataSource;
  final OnboardingRemoteDataSource _remoteDataSource;

  const OnboardingRepositoryImpl({
    required OnboardingLocalDataSource localDataSource,
    required OnboardingRemoteDataSource remoteDataSource,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, void>> saveDraft(OnboardingDataEntity data) async {
    try {
      final model = OnboardingDataModel.fromEntity(data);
      await _localDataSource.saveDraft(model);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, OnboardingDataEntity?>> loadDraft() async {
    try {
      final model = await _localDataSource.loadDraft();
      return Right(model?.toEntity());
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> clearDraft() async {
    try {
      await _localDataSource.clearDraft();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding(
    OnboardingDataEntity data,
  ) async {
    try {
      // Step 1: Create partner profile (auth already done in step 3)
      final model = OnboardingDataModel.fromEntity(data);
      await _remoteDataSource.createProfile(model);

      // Step 2: Mark onboarding as complete
      await _remoteDataSource.markOnboardingComplete();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(
        NetworkFailure('No internet connection. Please try again.'),
      );
    }
  }
}
