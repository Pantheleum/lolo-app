import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_entity.freezed.dart';

enum SubscriptionTier { free, pro, legend }

@freezed
class SubscriptionEntity with _$SubscriptionEntity {
  const factory SubscriptionEntity({
    required SubscriptionTier tier,
    required String status,
    DateTime? currentPeriodEnd,
    DateTime? trialEndsAt,
    required bool autoRenew,
    required SubscriptionUsage usage,
  }) = _SubscriptionEntity;

  const SubscriptionEntity._();
  bool get isPremium => tier != SubscriptionTier.free;
  bool get isTrial => status == 'trial';
}

@freezed
class SubscriptionUsage with _$SubscriptionUsage {
  const factory SubscriptionUsage({
    required ({int used, int limit}) aiMessages,
    required ({int used, int limit}) sosSessions,
    required ({int used, int limit}) actionCardsPerDay,
    required ({int used, int limit}) memories,
  }) = _SubscriptionUsage;
}
