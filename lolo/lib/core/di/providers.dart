import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/constants/hive_box_names.dart';
import 'package:lolo/core/storage/local_storage_service.dart';
import 'package:lolo/core/network/network_info.dart';

part 'providers.g.dart';

/// Global Hive settings box provider.
@Riverpod(keepAlive: true)
LocalStorageService settingsStorage(Ref ref) {
  return LocalStorageService(Hive.box(HiveBoxNames.settings));
}

/// Global API cache storage provider.
@Riverpod(keepAlive: true)
LocalStorageService apiCacheStorage(Ref ref) {
  return LocalStorageService(Hive.box(HiveBoxNames.apiCache));
}

/// Network connectivity info provider.
@Riverpod(keepAlive: true)
NetworkInfo networkInfo(Ref ref) {
  return NetworkInfoImpl();
}
