import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/repositories/her_profile_repository.dart';

/// Updates partner profile fields with partial update support.
class UpdatePartnerProfileUseCase {
  final HerProfileRepository _repository;
  const UpdatePartnerProfileUseCase(this._repository);

  Future<Either<Failure, PartnerProfileEntity>> call({
    required String profileId,
    required Map<String, dynamic> updates,
  }) =>
      _repository.updateProfile(profileId, updates);
}
