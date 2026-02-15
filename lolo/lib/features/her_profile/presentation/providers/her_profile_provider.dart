import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/di/providers.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/her_profile/data/datasources/her_profile_remote_datasource.dart';
import 'package:lolo/features/her_profile/data/datasources/her_profile_local_datasource.dart';
import 'package:lolo/features/her_profile/data/repositories/her_profile_repository_impl.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/repositories/her_profile_repository.dart';
import 'package:lolo/features/her_profile/domain/usecases/get_partner_profile_usecase.dart';
import 'package:lolo/features/her_profile/domain/usecases/update_partner_profile_usecase.dart';
import 'package:lolo/features/her_profile/domain/usecases/get_zodiac_defaults_usecase.dart';

// ---------------------------------------------------------------------------
// Data source, repository, and use case providers
// ---------------------------------------------------------------------------

final herProfileRemoteDataSourceProvider =
    Provider<HerProfileRemoteDataSource>((ref) {
  return HerProfileRemoteDataSource(ref.watch(dioProvider));
});

final herProfileLocalDataSourceProvider =
    Provider<HerProfileLocalDataSource>((ref) {
  return HerProfileLocalDataSource();
});

final herProfileRepositoryProvider = Provider<HerProfileRepository>((ref) {
  return HerProfileRepositoryImpl(
    remote: ref.watch(herProfileRemoteDataSourceProvider),
    local: ref.watch(herProfileLocalDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
});

final getPartnerProfileUseCaseProvider =
    Provider<GetPartnerProfileUseCase>((ref) {
  return GetPartnerProfileUseCase(ref.watch(herProfileRepositoryProvider));
});

final updatePartnerProfileUseCaseProvider =
    Provider<UpdatePartnerProfileUseCase>((ref) {
  return UpdatePartnerProfileUseCase(ref.watch(herProfileRepositoryProvider));
});

final getZodiacDefaultsUseCaseProvider =
    Provider<GetZodiacDefaultsUseCase>((ref) {
  return GetZodiacDefaultsUseCase(ref.watch(herProfileRepositoryProvider));
});

// ---------------------------------------------------------------------------
// Presentation providers
// ---------------------------------------------------------------------------

/// Provides the partner profile with caching and refresh support.
class HerProfileNotifier
    extends FamilyAsyncNotifier<PartnerProfileEntity, String> {
  @override
  Future<PartnerProfileEntity> build(String profileId) async {
    final getProfile = ref.watch(getPartnerProfileUseCaseProvider);
    final result = await getProfile(profileId);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (profile) => profile,
    );
  }

  /// Update profile fields and refresh state.
  Future<void> updateProfile(Map<String, dynamic> updates) async {
    final updateUseCase = ref.read(updatePartnerProfileUseCaseProvider);
    state = const AsyncLoading();
    final result = await updateUseCase(
      profileId: state.value!.id,
      updates: updates,
    );
    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      AsyncData.new,
    );
  }

  /// Update love language.
  Future<void> setLoveLanguage(String loveLanguage) =>
      updateProfile({'loveLanguage': loveLanguage});

  /// Update communication style.
  Future<void> setCommunicationStyle(String style) =>
      updateProfile({'communicationStyle': style});

  /// Update zodiac sign and fetch defaults.
  Future<void> setZodiacSign(String sign) async {
    await updateProfile({'zodiacSign': sign});
    // Zodiac defaults are fetched automatically when profile reloads
  }
}

final herProfileNotifierProvider = AsyncNotifierProvider.family<
    HerProfileNotifier, PartnerProfileEntity, String>(
  HerProfileNotifier.new,
);

/// Provides zodiac defaults for a given sign.
final zodiacDefaultsProvider =
    FutureProvider.family<ZodiacProfileEntity, String>((ref, sign) async {
  final useCase = ref.watch(getZodiacDefaultsUseCaseProvider);
  final result = await useCase(sign);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (defaults) => defaults,
  );
});
