import 'package:freezed_annotation/freezed_annotation.dart';

part 'gamification_profile.freezed.dart';

@freezed
class GamificationProfile with _$GamificationProfile {
  const factory GamificationProfile({
    required int currentLevel,
    required String levelName,
    required int xpCurrent,
    required int xpForNextLevel,
    required double xpProgress,
    required int totalXpEarned,
    required int currentStreak,
    required int longestStreak,
    required int freezesAvailable,
    required int consistencyScore,
    required String consistencyLabel,
    required List<WeeklyXp> weeklyXp,
  }) = _GamificationProfile;
}

@freezed
class WeeklyXp with _$WeeklyXp {
  const factory WeeklyXp({
    required String day,
    required int xp,
  }) = _WeeklyXp;
}
