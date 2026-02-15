import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/network/network_info.dart';
import 'package:lolo/features/her_profile/data/datasources/her_profile_remote_datasource.dart';
import 'package:lolo/features/her_profile/data/datasources/her_profile_local_datasource.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/repositories/her_profile_repository.dart';

/// Offline-first implementation of [HerProfileRepository].
///
/// Read strategy:
///   1. Try local cache (Hive) first for instant UI rendering
///   2. Fetch from remote (Firestore via API) in background
///   3. Update local cache with fresh data
///   4. If offline, serve cached data with offline indicator
///
/// Write strategy:
///   1. Write to remote (Firestore via API)
///   2. On success, update local cache
///   3. If offline, queue for sync (future sprint)
class HerProfileRepositoryImpl implements HerProfileRepository {
  final HerProfileRemoteDataSource _remote;
  final HerProfileLocalDataSource _local;
  final NetworkInfo _networkInfo;

  const HerProfileRepositoryImpl({
    required HerProfileRemoteDataSource remote,
    required HerProfileLocalDataSource local,
    required NetworkInfo networkInfo,
  })  : _remote = remote,
        _local = local,
        _networkInfo = networkInfo;

  @override
  Future<Either<Failure, PartnerProfileEntity>> getProfile(
    String profileId,
  ) async {
    try {
      if (await _networkInfo.isConnected) {
        final model = await _remote.getProfile(profileId);
        await _local.cacheProfile(model);
        return Right(model.toEntity());
      } else {
        final cached = await _local.getCachedProfile(profileId);
        if (cached != null) {
          return Right(cached.toEntity());
        }
        return const Left(
          NetworkFailure('No internet and no cached profile available.'),
        );
      }
    } on ServerException catch (e) {
      // Fall back to cache on server error
      final cached = await _local.getCachedProfile(profileId);
      if (cached != null) return Right(cached.toEntity());
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, PartnerProfileEntity>> updateProfile(
    String profileId,
    Map<String, dynamic> updates,
  ) async {
    try {
      final model = await _remote.updateProfile(profileId, updates);
      await _local.cacheProfile(model);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } on NetworkException {
      return const Left(NetworkFailure('No internet connection.'));
    }
  }

  @override
  Future<Either<Failure, PartnerPreferencesEntity>> updatePreferences(
    String profileId,
    PartnerPreferencesEntity preferences,
  ) async {
    try {
      final payload = {
        'favorites': preferences.favorites,
        'dislikes': preferences.dislikes,
        'hobbies': preferences.hobbies,
        if (preferences.stressCoping != null)
          'stressCoping': preferences.stressCoping,
        if (preferences.notes != null) 'notes': preferences.notes,
      };
      await _remote.updatePreferences(profileId, payload);
      return Right(preferences);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, CulturalContextEntity>> updateCulturalContext(
    String profileId,
    CulturalContextEntity context,
  ) async {
    try {
      final payload = {
        if (context.background != null) 'background': context.background,
        if (context.religiousObservance != null)
          'religiousObservance': context.religiousObservance,
        if (context.dialect != null) 'dialect': context.dialect,
      };
      await _remote.updateCulturalContext(profileId, payload);
      return Right(context);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, ZodiacProfileEntity>> getZodiacDefaults(
    String sign,
  ) async {
    try {
      // Check local cache first (24h TTL)
      final cached = await _local.getCachedZodiacDefaults(sign);
      if (cached != null) {
        return Right(_mapZodiacDefaults(cached));
      }

      final data = await _remote.getZodiacDefaults(sign);
      await _local.cacheZodiacDefaults(sign, data);
      return Right(_mapZodiacDefaults(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, int>> getProfileCompletion(String profileId) async {
    final result = await getProfile(profileId);
    return result.map((p) => p.profileCompletionPercent);
  }

  ZodiacProfileEntity _mapZodiacDefaults(Map<String, dynamic> data) =>
      ZodiacProfileEntity(
        sign: data['sign'] as String? ?? '',
        element: data['element'] as String? ?? '',
        modality: data['modality'] as String? ?? '',
        rulingPlanet: data['rulingPlanet'] as String? ?? '',
        personality: (data['personality'] as List?)?.cast<String>() ?? [],
        communicationTips:
            (data['communicationTips'] as List?)?.cast<String>() ?? [],
        emotionalNeeds:
            (data['emotionalNeeds'] as List?)?.cast<String>() ?? [],
        conflictStyle: data['conflictStyle'] as String?,
        giftPreferences:
            (data['giftPreferences'] as List?)?.cast<String>() ?? [],
        loveLanguageAffinity: data['loveLanguageAffinity'] as String?,
        bestApproachDuring:
            (data['bestApproachDuring'] as Map?)?.cast<String, String>(),
      );
}
