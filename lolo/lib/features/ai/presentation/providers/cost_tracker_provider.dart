// FILE: lib/features/ai/presentation/providers/cost_tracker_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/presentation/providers/ai_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsageSnapshot {
  final int used;
  final int limit;
  final int remaining;
  final DateTime resetsAt;
  final AiRequestType type;

  const UsageSnapshot({
    required this.used,
    required this.limit,
    required this.remaining,
    required this.resetsAt,
    required this.type,
  });

  double get usagePercentage => limit <= 0 ? 0 : (used / limit).clamp(0.0, 1.0);
  bool get isExhausted => limit > 0 && used >= limit;
  bool get isUnlimited => limit == -1;
}

class CostTracker extends Notifier<Map<AiRequestType, UsageSnapshot>> {
  final Map<AiRequestType, AiUsageInfo> _usageCache = {};
  AiUsageInfo? _lastQueried;

  @override
  Map<AiRequestType, UsageSnapshot> build() => {};

  AiUsageInfo? get currentUsage => _lastQueried;

  // TODO: Re-enable usage limit checks before production launch
  Future<bool> checkLimit(AiRequestType type) async {
    // All features unlocked during development — skip limit checks
    return true;
  }

  void recordUsage(AiRequestType type, AiUsageInfo usage) {
    _usageCache[type] = usage;
    _lastQueried = usage;
    _updateState(type, usage);
    _persistUsage(type, usage);
  }

  void _updateState(AiRequestType type, AiUsageInfo usage) {
    state = {
      ...state,
      type: UsageSnapshot(
        used: usage.used,
        limit: usage.limit,
        remaining: usage.remaining,
        resetsAt: usage.resetsAt,
        type: type,
      ),
    };
  }

  Future<void> _persistUsage(AiRequestType type, AiUsageInfo usage) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('ai_usage_${type.apiValue}_used', usage.used);
      await prefs.setInt('ai_usage_${type.apiValue}_limit', usage.limit);
      await prefs.setString(
          'ai_usage_${type.apiValue}_resets', usage.resetsAt.toIso8601String());
    } catch (_) {}
  }

  Future<void> loadCachedUsage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final type in AiRequestType.values) {
        final used = prefs.getInt('ai_usage_${type.apiValue}_used');
        final limit = prefs.getInt('ai_usage_${type.apiValue}_limit');
        final resets = prefs.getString('ai_usage_${type.apiValue}_resets');

        if (used != null && limit != null && resets != null) {
          final resetsAt = DateTime.tryParse(resets);
          if (resetsAt != null && resetsAt.isAfter(DateTime.now())) {
            final usage = AiUsageInfo(
              used: used,
              limit: limit,
              remaining: (limit == -1) ? -1 : (limit - used).clamp(0, limit),
              resetsAt: resetsAt,
            );
            _usageCache[type] = usage;
            _updateState(type, usage);
          }
        }
      }
    } catch (_) {}
  }

  void clearCache() {
    _usageCache.clear();
    state = {};
  }

  UsageSnapshot? snapshotFor(AiRequestType type) => state[type];
}

final costTrackerProvider =
    NotifierProvider<CostTracker, Map<AiRequestType, UsageSnapshot>>(
  CostTracker.new,
);

final messageUsageSnapshotProvider = Provider<UsageSnapshot?>((ref) {
  final tracker = ref.watch(costTrackerProvider);
  return tracker[AiRequestType.message];
});

final giftUsageProvider = Provider<UsageSnapshot?>((ref) {
  final tracker = ref.watch(costTrackerProvider);
  return tracker[AiRequestType.gift];
});

final sosUsageProvider = Provider<UsageSnapshot?>((ref) {
  final tracker = ref.watch(costTrackerProvider);
  return tracker[AiRequestType.sosAssessment];
});
