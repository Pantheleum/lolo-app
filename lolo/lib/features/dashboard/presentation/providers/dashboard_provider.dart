import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:lolo/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:lolo/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:lolo/features/dashboard/data/repositories/dashboard_repository_impl.dart';

part 'dashboard_provider.g.dart';

@riverpod
DashboardRepository dashboardRepository(DashboardRepositoryRef ref) {
  return DashboardRepositoryImpl(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
}

/// Provides dashboard data with caching and refresh support.
@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  Future<DashboardData> build() async {
    final repository = ref.watch(dashboardRepositoryProvider);
    final result = await repository.getDashboardData();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (data) => data,
    );
  }

  /// Refresh dashboard data from remote.
  Future<void> refresh() async {
    final repository = ref.read(dashboardRepositoryProvider);
    state = const AsyncLoading();
    final result = await repository.refreshDashboardData();
    state = result.fold(
      (failure) => AsyncError(failure, StackTrace.current),
      AsyncData.new,
    );
  }
}
