// FILE: lib/features/ai/data/services/ai_service_initializer.dart

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';

class AiServiceInitializer {
  static Future<AiCacheManager> initCache() async {
    final dir = await getApplicationDocumentsDirectory();
    final isar = await Isar.open(
      [AiCacheEntrySchema],
      directory: dir.path,
      name: 'ai_cache',
    );

    final manager = AiCacheManager();
    await manager.init(isar);

    // Purge expired entries on startup
    await manager.purgeExpired();

    return manager;
  }
}
