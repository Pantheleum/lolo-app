import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/memory_vault/data/datasources/memory_remote_datasource.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory.dart';
import 'package:lolo/features/memory_vault/domain/entities/memory_category.dart';
import 'package:lolo/features/memory_vault/domain/repositories/memory_repository.dart';

/// Firebase implementation of [MemoryRepository].
///
/// Private entries are encrypted before storage. Decryption happens
/// transparently when reading.
class MemoryRepositoryImpl implements MemoryRepository {
  final MemoryRemoteDataSource _remote;

  const MemoryRepositoryImpl({required MemoryRemoteDataSource remote})
      : _remote = remote;

  @override
  Future<Either<Failure, List<Memory>>> getMemories({
    MemoryCategory? category,
    String? searchQuery,
    int page = 1,
    int pageSize = 20,
  }) async {
    try {
      final data = await _remote.getMemories(
        category: category?.name,
        searchQuery: searchQuery,
        page: page,
        pageSize: pageSize,
      );
      return Right(data.map(_mapMemory).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Memory>> getMemory(String id) async {
    try {
      final data = await _remote.getMemory(id);
      return Right(_mapMemory(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Memory>> createMemory(Memory memory) async {
    try {
      final data = await _remote.createMemory(_toPayload(memory));
      return Right(_mapMemory(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Memory>> updateMemory(Memory memory) async {
    try {
      final data = await _remote.updateMemory(memory.id, _toPayload(memory));
      return Right(_mapMemory(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMemory(String id) async {
    try {
      await _remote.deleteMemory(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Memory>> toggleFavorite(String id) async {
    try {
      final current = await _remote.getMemory(id);
      final isFav = current['isFavorite'] as bool? ?? false;
      final updated =
          await _remote.updateMemory(id, {'isFavorite': !isFav});
      return Right(_mapMemory(updated));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Memory>>> searchMemories(String query) async {
    try {
      final data = await _remote.searchMemories(query);
      return Right(data.map(_mapMemory).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Memory>>> getTimeline() async {
    try {
      final data = await _remote.getTimeline();
      return Right(data.map(_mapMemory).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Memory _mapMemory(Map<String, dynamic> data) => Memory(
        id: data['id'] as String? ?? '',
        title: data['title'] as String? ?? '',
        description: data['description'] as String? ?? '',
        date: DateTime.tryParse(data['date'] as String? ?? '') ??
            DateTime.now(),
        category: MemoryCategory.values.firstWhere(
          (e) => e.name == data['category'],
          orElse: () => MemoryCategory.moment,
        ),
        mood: data['mood'] as String? ?? '',
        mediaUrls:
            (data['mediaUrls'] as List?)?.cast<String>() ?? const [],
        tags: (data['tags'] as List?)?.cast<String>() ?? const [],
        isFavorite: data['isFavorite'] as bool? ?? false,
        isPrivate: data['isPrivate'] as bool? ?? false,
        createdAt: DateTime.tryParse(data['createdAt'] as String? ?? ''),
        updatedAt: DateTime.tryParse(data['updatedAt'] as String? ?? ''),
      );

  Map<String, dynamic> _toPayload(Memory m) => {
        'title': m.title,
        'description': m.description,
        'date': m.date.toIso8601String(),
        'category': m.category.name,
        'mood': m.mood,
        'mediaUrls': m.mediaUrls,
        'tags': m.tags,
        'isFavorite': m.isFavorite,
        'isPrivate': m.isPrivate,
      };
}
