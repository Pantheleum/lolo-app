import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:lolo/features/auth/presentation/providers/auth_provider.dart';
import 'package:lolo/features/subscription/data/services/revenue_cat_service.dart';
import 'package:lolo/features/subscription/domain/entities/subscription_entity.dart';

/// Checks if the current user has a free pass granted in Firestore.
/// Re-subscribes automatically on auth state changes.
///
/// To grant a user full access, set `freePass: true` on their
/// `users/{uid}` document in Firebase Console.
final freePassProvider = FutureProvider<bool>((ref) async {
  final uid = ref.watch(authStateProvider).valueOrNull?.uid;
  if (uid == null) return false;
  try {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return doc.data()?['freePass'] == true;
  } catch (_) {
    return false;
  }
});

final currentTierProvider = FutureProvider<SubscriptionTier>((ref) async {
  // Check Firestore free pass first
  final hasFreePass = await ref.watch(freePassProvider.future);
  if (hasFreePass) return SubscriptionTier.legend;

  // Fall back to RevenueCat entitlements
  final svc = ref.watch(revenueCatServiceProvider);
  final isPro = await svc.checkEntitlement('pro');
  if (isPro) return SubscriptionTier.pro;
  final isLegend = await svc.checkEntitlement('legend');
  if (isLegend) return SubscriptionTier.legend;
  return SubscriptionTier.free;
});

final isPremiumProvider = FutureProvider<bool>((ref) async {
  final tier = await ref.watch(currentTierProvider.future);
  return tier != SubscriptionTier.free;
});

final offeringsProvider = FutureProvider<Offerings>((ref) async {
  final svc = ref.watch(revenueCatServiceProvider);
  return svc.getOfferings();
});

class PurchaseNotifier extends Notifier<AsyncValue<void>> {
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

final purchaseNotifierProvider =
    NotifierProvider<PurchaseNotifier, AsyncValue<void>>(
  PurchaseNotifier.new,
);
