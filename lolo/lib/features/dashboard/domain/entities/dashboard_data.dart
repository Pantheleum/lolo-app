import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_data.freezed.dart';

/// Dashboard overview data for the home screen.
@freezed
class DashboardData with _$DashboardData {
  const factory DashboardData({
    required String userName,
    required String partnerName,
    @Default(0) int streak,
    @Default(1) int level,
    @Default(0) int xp,
    @Default(100) int xpToNextLevel,
    @Default([]) List<bool> activeDays,
    @Default([]) List<DashboardReminder> upcomingReminders,
    @Default([]) List<DashboardActionCard> dailyCards,
  }) = _DashboardData;

  const DashboardData._();

  double get xpProgress => xpToNextLevel > 0 ? xp / xpToNextLevel : 0;
}

/// Lightweight reminder for dashboard display.
@freezed
class DashboardReminder with _$DashboardReminder {
  const factory DashboardReminder({
    required String id,
    required String title,
    required DateTime date,
    required String category,
  }) = _DashboardReminder;
}

/// Lightweight action card for dashboard preview.
@freezed
class DashboardActionCard with _$DashboardActionCard {
  const factory DashboardActionCard({
    required String id,
    required String type,
    required String title,
    required String body,
    @Default(1) int difficulty,
    @Default(10) int xpValue,
  }) = _DashboardActionCard;
}
