import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'revenue_cat_service.g.dart';

@riverpod
RevenueCatService revenueCatService(RevenueCatServiceRef ref) => RevenueCatService();

class RevenueCatService {
  static const _apiKey = String.fromEnvironment('REVENUECAT_API_KEY');

  Future<void> init(String userId) async {
    await Purchases.setLogLevel(LogLevel.debug);
    final config = PurchasesConfiguration(_apiKey)..appUserID = userId;
    await Purchases.configure(config);
  }

  Future<Offerings> getOfferings() async => Purchases.getOfferings();

  Future<CustomerInfo> purchase(Package package) async {
    final result = await Purchases.purchasePackage(package);
    return result;
  }

  Future<CustomerInfo> restore() async => Purchases.restorePurchases();

  Future<bool> checkEntitlement(String entitlementId) async {
    final info = await Purchases.getCustomerInfo();
    return info.entitlements.active.containsKey(entitlementId);
  }

  Future<CustomerInfo> getCustomerInfo() async => Purchases.getCustomerInfo();
}
