import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/domain/entities/streak_entity.dart';

final gamificationProfileProvider =
    FutureProvider<GamificationProfile>((ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getProfile();
  return result.fold((f) => throw Exception(f.message), (p) => p);
});

final badgesProvider = FutureProvider<
    ({List<BadgeEntity> earned, List<BadgeEntity> unearned})>((ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getBadges();
  return result.fold((f) => throw Exception(f.message), (b) => b);
});

final streakProvider = FutureProvider<StreakEntity>((ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getStreak();
  return result.fold((f) => throw Exception(f.message), (s) => s);
});
