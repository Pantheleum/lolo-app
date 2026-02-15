import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';

/// Contract for partner profile data access.
///
/// Implements offline-first strategy: read from local cache (Isar),
/// sync to Firestore on write, and refresh cache on network availability.
abstract class HerProfileRepository {
  /// Get the partner profile. Reads from Isar first, falls back to remote.
  Future<Either<Failure, PartnerProfileEntity>> getProfile(String profileId);

  /// Update profile fields. Writes to both Isar and Firestore.
  Future<Either<Failure, PartnerProfileEntity>> updateProfile(
    String profileId,
    Map<String, dynamic> updates,
  );

  /// Update preferences sub-document.
  Future<Either<Failure, PartnerPreferencesEntity>> updatePreferences(
    String profileId,
    PartnerPreferencesEntity preferences,
  );

  /// Update cultural context sub-document.
  Future<Either<Failure, CulturalContextEntity>> updateCulturalContext(
    String profileId,
    CulturalContextEntity context,
  );

  /// Get zodiac defaults for a given sign.
  Future<Either<Failure, ZodiacProfileEntity>> getZodiacDefaults(String sign);

  /// Get profile completion percentage.
  Future<Either<Failure, int>> getProfileCompletion(String profileId);
}
