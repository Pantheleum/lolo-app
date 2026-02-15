import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/dashboard/domain/entities/dashboard_data.dart';

/// Contract for dashboard data access.
abstract class DashboardRepository {
  /// Get the dashboard overview data for the authenticated user.
  Future<Either<Failure, DashboardData>> getDashboardData();

  /// Refresh dashboard data from remote source.
  Future<Either<Failure, DashboardData>> refreshDashboardData();
}
