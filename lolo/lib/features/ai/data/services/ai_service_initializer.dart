// FILE: lib/features/ai/data/services/ai_service_initializer.dart

import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';

class AiServiceInitializer {
  static Future<AiCacheManager> initCache() async {
    final manager = AiCacheManager();
    await manager.init();

    // Purge expired entries on startup
    await manager.purgeExpired();

    return manager;
  }
}
