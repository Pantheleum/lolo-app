// FILE: lib/features/ai/presentation/providers/ai_providers.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/core/network/api_client.dart';
import 'package:lolo/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';
import 'package:lolo/features/ai/data/services/content_safety_filter.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';

part 'ai_providers.g.dart';

@Riverpod(keepAlive: true)
AiCacheManager aiCacheManager(AiCacheManagerRef ref) {
  return AiCacheManager();
}

@Riverpod(keepAlive: true)
ContentSafetyFilter contentSafetyFilter(ContentSafetyFilterRef ref) {
  return ContentSafetyFilter();
}

@Riverpod(keepAlive: true)
AiRepository aiRepository(AiRepositoryRef ref) {
  return AiRepositoryImpl(
    api: ref.watch(apiClientProvider),
    cache: ref.watch(aiCacheManagerProvider),
    safety: ref.watch(contentSafetyFilterProvider),
  );
}
