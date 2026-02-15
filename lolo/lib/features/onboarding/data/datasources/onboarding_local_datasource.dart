import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/features/onboarding/data/models/onboarding_data_model.dart';

/// Hive-backed local storage for onboarding drafts.
///
/// Stores the draft as a JSON string in the 'onboarding' box under
/// the key 'draft'. This allows the user to close the app mid-flow
/// and resume from the exact step they left off.
class OnboardingLocalDataSource {
  static const String _boxName = 'onboarding';
  static const String _draftKey = 'draft';

  /// Save the current onboarding draft.
  Future<void> saveDraft(OnboardingDataModel model) async {
    final box = await Hive.openBox<String>(_boxName);
    final jsonStr = jsonEncode(model.toJson());
    await box.put(_draftKey, jsonStr);
  }

  /// Load a previously saved draft, or null if none exists.
  Future<OnboardingDataModel?> loadDraft() async {
    final box = await Hive.openBox<String>(_boxName);
    final jsonStr = box.get(_draftKey);
    if (jsonStr == null) return null;

    final jsonMap = jsonDecode(jsonStr) as Map<String, dynamic>;
    return OnboardingDataModel.fromJson(jsonMap);
  }

  /// Clear the draft after successful completion.
  Future<void> clearDraft() async {
    final box = await Hive.openBox<String>(_boxName);
    await box.delete(_draftKey);
  }
}
