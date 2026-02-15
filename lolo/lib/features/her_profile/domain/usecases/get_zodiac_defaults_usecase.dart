import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/repositories/her_profile_repository.dart';

/// Fetches default zodiac personality traits for a given sign.
///
/// Used to pre-populate the profile when the user selects or changes
/// the zodiac sign. Cached for 24h per sign per locale.
class GetZodiacDefaultsUseCase {
  final HerProfileRepository _repository;
  const GetZodiacDefaultsUseCase(this._repository);

  Future<Either<Failure, ZodiacProfileEntity>> call(String sign) =>
      _repository.getZodiacDefaults(sign);
}
