import 'package:dartz/dartz.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/features/gift_engine/data/datasources/gift_remote_datasource.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_category.dart';
import 'package:lolo/features/gift_engine/domain/entities/gift_recommendation_entity.dart';
import 'package:lolo/features/gift_engine/domain/repositories/gift_repository.dart';

/// Firebase/API implementation of [GiftRepository].
///
/// Delegates network calls to [GiftRemoteDataSource] and maps
/// exceptions to domain [Failure] types.
class GiftRepositoryImpl implements GiftRepository {
  final GiftRemoteDataSource _remote;

  const GiftRepositoryImpl({required GiftRemoteDataSource remote})
      : _remote = remote;

  @override
  Future<Either<Failure, List<GiftRecommendationEntity>>> browseGifts({
    int page = 1,
    int pageSize = 20,
    GiftCategory? category,
    String? searchQuery,
    bool? lowBudgetOnly,
  }) async {
    try {
      final models = await _remote.browseGifts(
        page: page,
        pageSize: pageSize,
        category: category?.name,
        searchQuery: searchQuery,
        lowBudgetOnly: lowBudgetOnly,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, GiftRecommendationEntity>> getGiftById(
    String id,
  ) async {
    try {
      final model = await _remote.getGiftById(id);
      return Right(model.toEntity());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GiftRecommendationEntity>>>
      getAiRecommendations({String? occasion, String? city, String? country}) async {
    try {
      final models = await _remote.getAiRecommendations(
        occasion: occasion,
        city: city,
        country: country,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleSave(String giftId) async {
    try {
      await _remote.toggleSave(giftId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitFeedback({
    required String giftId,
    required bool liked,
  }) async {
    try {
      await _remote.submitFeedback(giftId: giftId, liked: liked);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GiftRecommendationEntity>>> getRelatedGifts(
    String giftId,
  ) async {
    try {
      final models = await _remote.getRelatedGifts(giftId);
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<GiftRecommendationEntity>>> getGiftHistory({
    int page = 1,
    int pageSize = 20,
    bool? likedOnly,
    bool? dislikedOnly,
  }) async {
    try {
      final models = await _remote.getGiftHistory(
        page: page,
        pageSize: pageSize,
        likedOnly: likedOnly,
        dislikedOnly: dislikedOnly,
      );
      return Right(models.map((m) => m.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
