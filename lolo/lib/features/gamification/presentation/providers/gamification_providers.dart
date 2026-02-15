import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/gamification/data/repositories/gamification_repository.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/domain/entities/streak_entity.dart';

part 'gamification_providers.g.dart';

@riverpod
Future<GamificationProfile> gamificationProfile(GamificationProfileRef ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getProfile();
  return result.fold((f) => throw Exception(f.message), (p) => p);
}

@riverpod
Future<({List<BadgeEntity> earned, List<BadgeEntity> unearned})> badges(BadgesRef ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getBadges();
  return result.fold((f) => throw Exception(f.message), (b) => b);
}

@riverpod
Future<StreakEntity> streak(StreakRef ref) async {
  final repo = ref.watch(gamificationRepositoryProvider);
  final result = await repo.getStreak();
  return result.fold((f) => throw Exception(f.message), (s) => s);
}
