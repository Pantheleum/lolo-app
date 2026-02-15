import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/gamification/domain/entities/gamification_profile.dart';
import 'package:lolo/features/gamification/domain/entities/badge_entity.dart';
import 'package:lolo/features/gamification/domain/entities/streak_entity.dart';

abstract class GamificationRepository {
  Future<Either<Failure, GamificationProfile>> getProfile();
  Future<Either<Failure, ({List<BadgeEntity> earned, List<BadgeEntity> unearned})>> getBadges();
  Future<Either<Failure, StreakEntity>> getStreak();
}

final gamificationRepositoryProvider = Provider<GamificationRepository>((ref) =>
    GamificationRepositoryImpl(ref.watch(dioProvider)));

class GamificationRepositoryImpl implements GamificationRepository {
  GamificationRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<Either<Failure, GamificationProfile>> getProfile() async {
    try {
      final res = await _dio.get('/gamification/profile');
      final d = res.data['data'] as Map<String, dynamic>;
      final level = d['level'] as Map<String, dynamic>;
      final streak = d['streak'] as Map<String, dynamic>;
      final cs = d['consistencyScore'] as Map<String, dynamic>;
      final weekly = (d['weeklyXp'] as List)
          .map((w) => WeeklyXp(day: w['day'] as String, xp: w['xp'] as int))
          .toList();
      return Right(GamificationProfile(
        currentLevel: level['current'] as int,
        levelName: level['name'] as String,
        xpCurrent: level['xpCurrent'] as int,
        xpForNextLevel: level['xpForNextLevel'] as int,
        xpProgress: (level['xpProgress'] as num).toDouble(),
        totalXpEarned: level['totalXpEarned'] as int,
        currentStreak: streak['currentDays'] as int,
        longestStreak: streak['longestDays'] as int,
        freezesAvailable: streak['freezesAvailable'] as int,
        consistencyScore: cs['score'] as int,
        consistencyLabel: cs['label'] as String,
        weeklyXp: weekly,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ({List<BadgeEntity> earned, List<BadgeEntity> unearned})>> getBadges() async {
    try {
      final res = await _dio.get('/gamification/badges');
      final d = res.data['data'] as Map<String, dynamic>;
      final earned = (d['earned'] as List).map((b) => _mapBadge(b)).toList();
      final unearned = (d['unearned'] as List).map((b) => _mapBadge(b)).toList();
      return Right((earned: earned, unearned: unearned));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StreakEntity>> getStreak() async {
    try {
      final res = await _dio.get('/gamification/streak');
      final d = res.data['data'] as Map<String, dynamic>;
      final f = d['freezes'] as Map<String, dynamic>;
      final milestones = (d['milestones'] as List).map((m) => StreakMilestone(
        days: m['days'] as int,
        reached: m['reached'] as bool,
        reachedAt: m['reachedAt'] != null ? DateTime.parse(m['reachedAt'] as String) : null,
      )).toList();
      return Right(StreakEntity(
        currentStreak: d['currentStreak'] as int,
        longestStreak: d['longestStreak'] as int,
        isActiveToday: d['isActiveToday'] as bool,
        freezesAvailable: f['available'] as int,
        freezesUsedThisMonth: f['usedThisMonth'] as int,
        milestones: milestones,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  BadgeEntity _mapBadge(Map<String, dynamic> m) => BadgeEntity(
        id: m['id'] as String,
        name: m['nameLocalized'] as String? ?? m['name'] as String,
        icon: m['icon'] as String,
        description: m['descriptionLocalized'] as String? ?? m['description'] as String,
        category: m['category'] as String,
        rarity: m['rarity'] as String,
        earnedAt: m['earnedAt'] != null ? DateTime.parse(m['earnedAt'] as String) : null,
        progress: (m['progress'] as num?)?.toDouble(),
        progressDescription: m['progressDescription'] as String?,
      );
}
