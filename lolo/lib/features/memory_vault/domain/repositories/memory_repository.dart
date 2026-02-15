import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';

/// Contract for Memory Vault data access.
///
/// Supports CRUD operations, search, filtering, and encrypted private entries.
abstract class MemoryRepository {
  /// Get all memories with optional category filter.
  Future<Either<Failure, List<Memory>>> getMemories({
    MemoryCategory? category,
    String? searchQuery,
    int page,
    int pageSize,
  });

  /// Get a single memory by ID.
  Future<Either<Failure, Memory>> getMemory(String id);

  /// Create a new memory entry.
  Future<Either<Failure, Memory>> createMemory(Memory memory);

  /// Update an existing memory.
  Future<Either<Failure, Memory>> updateMemory(Memory memory);

  /// Delete a memory by ID.
  Future<Either<Failure, void>> deleteMemory(String id);

  /// Toggle favorite status.
  Future<Either<Failure, Memory>> toggleFavorite(String id);

  /// Search memories by query string.
  Future<Either<Failure, List<Memory>>> searchMemories(String query);

  /// Get timeline view of memories.
  Future<Either<Failure, List<Memory>>> getTimeline();
}
