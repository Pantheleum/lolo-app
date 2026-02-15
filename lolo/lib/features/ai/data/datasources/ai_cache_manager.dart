// FILE: lib/features/ai/data/datasources/ai_cache_manager.dart

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:isar/isar.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';

part 'ai_cache_manager.g.dart';

@collection
class AiCacheEntry {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String key;

  late String jsonValue;
  late DateTime expiresAt;
  late DateTime createdAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class AiCacheManager {
  Isar? _isar;

  Future<void> init(Isar isar) async {
    _isar = isar;
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
    if (_isar == null) return null;

    final entry = await _isar!.aiCacheEntrys.where().keyEqualTo(key).findFirst();
    if (entry == null || entry.isExpired) {
      if (entry != null) {
        await _isar!.writeTxn(() => _isar!.aiCacheEntrys.delete(entry.id));
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
    if (_isar == null || ttl == Duration.zero) return;

    final entry = AiCacheEntry()
      ..key = key
      ..jsonValue = jsonEncode(value)
      ..expiresAt = DateTime.now().add(ttl)
      ..createdAt = DateTime.now();

    await _isar!.writeTxn(() => _isar!.aiCacheEntrys.put(entry));
  }

  Future<void> invalidatePattern(String prefix) async {
    if (_isar == null) return;

    final entries = await _isar!.aiCacheEntrys
        .where()
        .filter()
        .keyStartsWith(prefix)
        .findAll();

    if (entries.isNotEmpty) {
      final ids = entries.map((e) => e.id).toList();
      await _isar!.writeTxn(() => _isar!.aiCacheEntrys.deleteAll(ids));
    }
  }

  Future<void> invalidateAll() async {
    if (_isar == null) return;
    await _isar!.writeTxn(() => _isar!.aiCacheEntrys.clear());
  }

  Future<void> purgeExpired() async {
    if (_isar == null) return;

    final now = DateTime.now();
    final expired = await _isar!.aiCacheEntrys
        .where()
        .filter()
        .expiresAtLessThan(now)
        .findAll();

    if (expired.isNotEmpty) {
      final ids = expired.map((e) => e.id).toList();
      await _isar!.writeTxn(() => _isar!.aiCacheEntrys.deleteAll(ids));
    }
  }

  Future<int> cacheSize() async {
    if (_isar == null) return 0;
    return _isar!.aiCacheEntrys.count();
  }
}
