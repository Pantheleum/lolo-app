// FILE: lib/features/ai/data/services/tier_enforcement.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

// TODO: Re-enable tier restrictions before production launch
class TierEnforcement {
  const TierEnforcement._();

  static bool canAccessMode(SubscriptionTier tier, AiMessageMode mode) {
    return true; // All modes open during development
  }

  static bool canIncludeAlternatives(SubscriptionTier tier) {
    return true;
  }

  static bool canForceRefreshCards(SubscriptionTier tier) {
    return true;
  }

  static bool canGetReplacementCard(SubscriptionTier tier) {
    return true;
  }

  static int maxGiftsPerRequest(SubscriptionTier tier) {
    return 10; // Max for all during development
  }

  static int maxCardsPerDay(SubscriptionTier tier) {
    return -1; // Unlimited during development
  }

  static String tierLimitMessage(SubscriptionTier tier, AiRequestType type) {
    final featureName = switch (type) {
      AiRequestType.message => 'AI messages',
      AiRequestType.gift => 'gift recommendations',
      AiRequestType.sosAssessment || AiRequestType.sosCoaching => 'SOS sessions',
      AiRequestType.actionCard => 'action cards',
      _ => 'AI features',
    };

    return switch (tier) {
      SubscriptionTier.free =>
        'You\'ve reached your free tier limit for $featureName. '
            'Upgrade to Pro for more.',
      SubscriptionTier.pro =>
        'You\'ve reached your Pro tier limit for $featureName. '
            'Upgrade to Legend for unlimited access.',
      SubscriptionTier.legend =>
        'Something went wrong. Legend tier should have unlimited access.',
    };
  }
}
