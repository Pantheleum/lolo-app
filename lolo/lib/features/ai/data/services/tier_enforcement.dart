// FILE: lib/features/ai/data/services/tier_enforcement.dart

import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class TierEnforcement {
  const TierEnforcement._();

  static bool canAccessMode(SubscriptionTier tier, AiMessageMode mode) {
    // All modes accessible on Pro and Legend
    if (tier == SubscriptionTier.pro || tier == SubscriptionTier.legend) {
      return true;
    }
    // Free tier: first 3 modes (indices 0-2 in the enum) are accessible
    return mode.index <= 2;
  }

  static bool canIncludeAlternatives(SubscriptionTier tier) {
    return tier == SubscriptionTier.legend;
  }

  static bool canForceRefreshCards(SubscriptionTier tier) {
    return tier == SubscriptionTier.legend;
  }

  static bool canGetReplacementCard(SubscriptionTier tier) {
    return tier != SubscriptionTier.free;
  }

  static int maxGiftsPerRequest(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 3,
        SubscriptionTier.pro => 5,
        SubscriptionTier.legend => 10,
      };

  static int maxCardsPerDay(SubscriptionTier tier) => switch (tier) {
        SubscriptionTier.free => 3,
        SubscriptionTier.pro => 10,
        SubscriptionTier.legend => -1, // unlimited
      };

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
