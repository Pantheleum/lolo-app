import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/subscription/data/services/revenue_cat_service.dart';
import 'package:lolo/features/subscription/domain/entities/subscription_entity.dart';

part 'subscription_providers.g.dart';

@riverpod
Future<SubscriptionTier> currentTier(CurrentTierRef ref) async {
  final svc = ref.watch(revenueCatServiceProvider);
  final isPro = await svc.checkEntitlement('pro');
  if (isPro) return SubscriptionTier.pro;
  final isLegend = await svc.checkEntitlement('legend');
  if (isLegend) return SubscriptionTier.legend;
  return SubscriptionTier.free;
}

@riverpod
Future<bool> isPremium(IsPremiumRef ref) async {
  final tier = await ref.watch(currentTierProvider.future);
  return tier != SubscriptionTier.free;
}

@riverpod
Future<Offerings> offerings(OfferingsRef ref) async {
  final svc = ref.watch(revenueCatServiceProvider);
  return svc.getOfferings();
}

@riverpod
class PurchaseNotifier extends _$PurchaseNotifier {
  @override
  AsyncValue<void> build() => const AsyncData(null);

  Future<void> purchase(Package package) async {
    state = const AsyncLoading();
    try {
      final svc = ref.read(revenueCatServiceProvider);
      await svc.purchase(package);
      ref.invalidate(currentTierProvider);
      ref.invalidate(isPremiumProvider);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  Future<void> restore() async {
    state = const AsyncLoading();
    try {
      final svc = ref.read(revenueCatServiceProvider);
      await svc.restore();
      ref.invalidate(currentTierProvider);
      ref.invalidate(isPremiumProvider);
      state = const AsyncData(null);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
}
