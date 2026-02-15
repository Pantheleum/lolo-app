import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/repositories/her_profile_repository.dart';

/// Retrieves the partner profile with offline-first strategy.
class GetPartnerProfileUseCase {
  final HerProfileRepository _repository;
  const GetPartnerProfileUseCase(this._repository);

  Future<Either<Failure, PartnerProfileEntity>> call(String profileId) =>
      _repository.getProfile(profileId);
}
