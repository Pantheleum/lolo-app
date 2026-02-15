import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/partner_preferences_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/cultural_context_entity.dart';
import 'package:lolo/features/her_profile/domain/entities/zodiac_profile_entity.dart';
import 'package:lolo/features/her_profile/domain/usecases/get_partner_profile_usecase.dart';
import 'package:lolo/features/her_profile/domain/usecases/update_partner_profile_usecase.dart';
import 'package:lolo/features/her_profile/domain/usecases/get_zodiac_defaults_usecase.dart';

part 'her_profile_provider.g.dart';

/// Provides the partner profile with caching and refresh support.
@riverpod
class HerProfileNotifier extends _$HerProfileNotifier {
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

/// Provides zodiac defaults for a given sign.
@riverpod
Future<ZodiacProfileEntity> zodiacDefaults(
  ZodiacDefaultsRef ref,
  String sign,
) async {
  final useCase = ref.watch(getZodiacDefaultsUseCaseProvider);
  final result = await useCase(sign);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (defaults) => defaults,
  );
}
