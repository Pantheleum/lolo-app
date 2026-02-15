// FILE: lib/features/ai/data/datasources/ai_cache_manager.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

class AiCacheEntry {
  late String key;
  late String jsonValue;
  late DateTime expiresAt;
  late DateTime createdAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class AiCacheManager {
  final Map<String, AiCacheEntry> _store = {};

  Future<void> init() async {
    // No-op: in-memory cache needs no initialisation.
  }

  // --- Cache Keys ---

  String messageKey({
    required String mode,
    required String tone,
    String? context,
  }) {
    final hash = _contextHash(context ?? '');
    return 'msg:$mode:$tone:$hash';
  }

  String giftKey({
    required String occasion,
    required double budgetMin,
    required double budgetMax,
  }) {
    return 'gift:$occasion:${budgetMin.toInt()}-${budgetMax.toInt()}';
  }

  String _contextHash(String input) {
    if (input.isEmpty) return 'empty';
    final bytes = utf8.encode(input);
    return sha256.convert(bytes).toString().substring(0, 8);
  }

  // --- TTL Rules from AI Strategy Section 8.2 ---

  Duration ttlForMode(AiMessageMode mode) => switch (mode) {
        AiMessageMode.goodMorning => Duration.zero,
        AiMessageMode.checkingIn => Duration.zero,
        AiMessageMode.appreciation => Duration.zero,
        AiMessageMode.apology => Duration.zero,
        AiMessageMode.afterArgument => Duration.zero,
        AiMessageMode.flirting => Duration.zero,
        AiMessageMode.reassurance => const Duration(hours: 1),
        AiMessageMode.motivation => const Duration(hours: 2),
        AiMessageMode.celebration => const Duration(hours: 1),
        AiMessageMode.longDistance => const Duration(hours: 1),
      };

  // --- CRUD ---

  Future<T?> get<T>(String key) async {
    final entry = _store[key];
    if (entry == null || entry.isExpired) {
      if (entry != null) {
        _store.remove(key);
      }
      return null;
    }

    try {
      final json = jsonDecode(entry.jsonValue);
      return json as T;
    } catch (_) {
      return null;
    }
  }

  Future<void> put<T>(String key, T value, {required Duration ttl}) async {
    if (ttl == Duration.zero) return;

    final entry = AiCacheEntry()
      ..key = key
      ..jsonValue = jsonEncode(value)
      ..expiresAt = DateTime.now().add(ttl)
      ..createdAt = DateTime.now();

    _store[key] = entry;
  }

  Future<void> invalidatePattern(String prefix) async {
    _store.removeWhere((key, _) => key.startsWith(prefix));
  }

  Future<void> invalidateAll() async {
    _store.clear();
  }

  Future<void> purgeExpired() async {
    _store.removeWhere((_, entry) => entry.isExpired);
  }

  Future<int> cacheSize() async {
    return _store.length;
  }
}
