import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/memory_vault/data/datasources/memory_remote_datasource.dart';
import 'package:lolo/features/memory_vault/data/repositories/memory_repository_impl.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';
import 'package:lolo/features/memory_vault/domain/repositories/memory_repository.dart';

/// State for the memories list screen.
class MemoriesState {
  final List<Memory> memories;
  final MemoryCategory? selectedCategory;
  final String searchQuery;
  final bool isGridView;
  final bool isLoading;
  final String? error;

  const MemoriesState({
    this.memories = const [],
    this.selectedCategory,
    this.searchQuery = '',
    this.isGridView = true,
    this.isLoading = false,
    this.error,
  });

  MemoriesState copyWith({
    List<Memory>? memories,
    MemoryCategory? selectedCategory,
    bool clearCategory = false,
    String? searchQuery,
    bool? isGridView,
    bool? isLoading,
    String? error,
  }) =>
      MemoriesState(
        memories: memories ?? this.memories,
        selectedCategory:
            clearCategory ? null : (selectedCategory ?? this.selectedCategory),
        searchQuery: searchQuery ?? this.searchQuery,
        isGridView: isGridView ?? this.isGridView,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

/// Manages Memory Vault list state, filtering, and CRUD.
class MemoriesNotifier extends Notifier<MemoriesState> {
  @override
  MemoriesState build() {
    _loadMemories();
    return const MemoriesState(isLoading: true);
  }

  MemoryRepository get _repository => ref.read(memoryRepositoryProvider);

  Future<void> _loadMemories() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _repository.getMemories(
      category: state.selectedCategory,
      searchQuery:
          state.searchQuery.isNotEmpty ? state.searchQuery : null,
      page: 1,
      pageSize: 50,
    );
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        error: failure.message,
      ),
      (memories) => state = state.copyWith(
        isLoading: false,
        memories: memories,
      ),
    );
  }

  /// Filter by category (null = all).
  void setCategory(MemoryCategory? category) {
    if (category == state.selectedCategory) {
      state = state.copyWith(clearCategory: true);
    } else {
      state = state.copyWith(selectedCategory: category);
    }
    _loadMemories();
  }

  /// Update search query and reload.
  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
    _loadMemories();
  }

  /// Toggle grid/list view.
  void toggleViewMode() {
    state = state.copyWith(isGridView: !state.isGridView);
  }

  /// Delete a memory and refresh.
  Future<void> deleteMemory(String id) async {
    final result = await _repository.deleteMemory(id);
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (_) {
        state = state.copyWith(
          memories: state.memories.where((m) => m.id != id).toList(),
        );
      },
    );
  }

  /// Toggle favorite and update in list.
  Future<void> toggleFavorite(String id) async {
    final result = await _repository.toggleFavorite(id);
    result.fold(
      (failure) => state = state.copyWith(error: failure.message),
      (updated) {
        state = state.copyWith(
          memories: state.memories
              .map((m) => m.id == id ? updated : m)
              .toList(),
        );
      },
    );
  }

  /// Refresh the list.
  Future<void> refresh() => _loadMemories();
}

final memoriesNotifierProvider =
    NotifierProvider<MemoriesNotifier, MemoriesState>(
  MemoriesNotifier.new,
);

/// Provides a single memory by ID.
final memoryDetailProvider =
    FutureProvider.family<Memory, String>((ref, memoryId) async {
  final repository = ref.watch(memoryRepositoryProvider);
  final result = await repository.getMemory(memoryId);
  return result.fold(
    (failure) => throw Exception(failure.message),
    (memory) => memory,
  );
});

// ---------------------------------------------------------------------------
// Data source & repository providers
// ---------------------------------------------------------------------------

final memoryRemoteDataSourceProvider =
    Provider<MemoryRemoteDataSource>((ref) {
  return MemoryRemoteDataSource(ref.watch(dioProvider));
});

final memoryRepositoryProvider = Provider<MemoryRepository>((ref) {
  return MemoryRepositoryImpl(
    remote: ref.watch(memoryRemoteDataSourceProvider),
  );
});
