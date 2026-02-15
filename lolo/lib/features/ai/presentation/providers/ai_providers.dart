// FILE: lib/features/ai/presentation/providers/ai_providers.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/network/api_client.dart';
import 'package:lolo/features/ai/data/repositories/ai_repository_impl.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';
import 'package:lolo/features/ai/data/services/content_safety_filter.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';

final aiCacheManagerProvider = Provider<AiCacheManager>((ref) {
  return AiCacheManager();
});

final contentSafetyFilterProvider = Provider<ContentSafetyFilter>((ref) {
  return ContentSafetyFilter();
});

final aiRepositoryProvider = Provider<AiRepository>((ref) {
  return AiRepositoryImpl(
    api: ref.watch(apiClientProvider),
    cache: ref.watch(aiCacheManagerProvider),
    safety: ref.watch(contentSafetyFilterProvider),
  );
});
