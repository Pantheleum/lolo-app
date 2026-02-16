import 'package:hive_flutter/hive_flutter.dart';
import 'package:lolo/core/constants/hive_box_names.dart';

/// Initializes all Hive boxes used by the app.
///
/// Called once during [bootstrap()].
abstract final class HiveSetup {
  static Future<void> init() async {
    // Settings (locale, theme, notification preferences)
    await Hive.openBox<dynamic>(HiveBoxNames.settings);

    // Onboarding draft (partial progress persistence)
    await Hive.openBox<dynamic>(HiveBoxNames.onboardingDraft);

    // Message history cache
    await Hive.openBox<dynamic>(HiveBoxNames.messageCache);

    // Action cards cache (today's cards for offline)
    await Hive.openBox<dynamic>(HiveBoxNames.actionCardsCache);

    // General API response cache
    await Hive.openBox<dynamic>(HiveBoxNames.apiCache);
  }
}
