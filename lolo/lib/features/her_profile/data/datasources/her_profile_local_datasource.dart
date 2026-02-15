import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/features/her_profile/data/models/partner_profile_model.dart';

/// Local cache for partner profile using Hive.
///
/// Provides offline-first reads: the profile is cached locally on every
/// successful fetch/update, and served from cache when offline.
class HerProfileLocalDataSource {
  static const String _boxName = 'her_profile_cache';

  Future<Box<String>> get _box => Hive.openBox<String>(_boxName);

  /// Cache the profile locally.
  Future<void> cacheProfile(PartnerProfileModel model) async {
    final box = await _box;
    await box.put(model.id, jsonEncode(model.toJson()));
  }

  /// Read cached profile, or null if not cached.
  Future<PartnerProfileModel?> getCachedProfile(String profileId) async {
    final box = await _box;
    final jsonStr = box.get(profileId);
    if (jsonStr == null) return null;
    return PartnerProfileModel.fromJson(
      jsonDecode(jsonStr) as Map<String, dynamic>,
    );
  }

  /// Clear cached profile.
  Future<void> clearCache(String profileId) async {
    final box = await _box;
    await box.delete(profileId);
  }

  /// Cache zodiac defaults keyed by sign.
  Future<void> cacheZodiacDefaults(
    String sign,
    Map<String, dynamic> data,
  ) async {
    final box = await _box;
    await box.put('zodiac_$sign', jsonEncode(data));
  }

  /// Get cached zodiac defaults.
  Future<Map<String, dynamic>?> getCachedZodiacDefaults(String sign) async {
    final box = await _box;
    final jsonStr = box.get('zodiac_$sign');
    if (jsonStr == null) return null;
    return jsonDecode(jsonStr) as Map<String, dynamic>;
  }
}
