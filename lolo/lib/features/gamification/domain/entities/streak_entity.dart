import 'package:freezed_annotation/freezed_annotation.dart';

part 'streak_entity.freezed.dart';

@freezed
class StreakEntity with _$StreakEntity {
  const factory StreakEntity({
    required int currentStreak,
    required int longestStreak,
    required bool isActiveToday,
    required int freezesAvailable,
    required int freezesUsedThisMonth,
    required List<StreakMilestone> milestones,
  }) = _StreakEntity;
}

@freezed
class StreakMilestone with _$StreakMilestone {
  const factory StreakMilestone({
    required int days,
    required bool reached,
    DateTime? reachedAt,
  }) = _StreakMilestone;
}
