// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$settingsStorageHash() => r'eabc3a85abaabfe4977119b834a13be5be7f9a58';

/// Global Hive settings box provider.
///
/// Copied from [settingsStorage].
@ProviderFor(settingsStorage)
final settingsStorageProvider = Provider<LocalStorageService>.internal(
  settingsStorage,
  name: r'settingsStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$settingsStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SettingsStorageRef = ProviderRef<LocalStorageService>;
String _$apiCacheStorageHash() => r'f0b00a06723c71e156ed558130724cbb4c2a1eda';

/// Global API cache storage provider.
///
/// Copied from [apiCacheStorage].
@ProviderFor(apiCacheStorage)
final apiCacheStorageProvider = Provider<LocalStorageService>.internal(
  apiCacheStorage,
  name: r'apiCacheStorageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$apiCacheStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiCacheStorageRef = ProviderRef<LocalStorageService>;
String _$networkInfoHash() => r'db8fc6bdbc572324c2188d1a6ad076831ac36996';

/// Network connectivity info provider.
///
/// Copied from [networkInfo].
@ProviderFor(networkInfo)
final networkInfoProvider = Provider<NetworkInfo>.internal(
  networkInfo,
  name: r'networkInfoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$networkInfoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef NetworkInfoRef = ProviderRef<NetworkInfo>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
