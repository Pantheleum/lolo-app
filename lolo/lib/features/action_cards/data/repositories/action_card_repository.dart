import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/action_cards/domain/entities/action_card_entity.dart';

abstract class ActionCardRepository {
  Future<Either<Failure, DailyCardsSummary>> getDailyCards({String? date});
  Future<Either<Failure, ActionCardEntity>> completeCard(String id, {String? notes});
  Future<Either<Failure, ActionCardEntity>> skipCard(String id, {String? reason});
  Future<Either<Failure, void>> saveCard(String id);
  Future<Either<Failure, List<ActionCardEntity>>> getSavedCards();
  Future<Either<Failure, List<ActionCardEntity>>> getHistory({String? status, int limit = 20});
}

final actionCardRepositoryProvider = Provider<ActionCardRepository>((ref) =>
    ActionCardRepositoryImpl(ref.watch(dioProvider)));

class ActionCardRepositoryImpl implements ActionCardRepository {
  ActionCardRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<Either<Failure, DailyCardsSummary>> getDailyCards({String? date}) async {
    try {
      final query = date != null ? {'date': date} : null;
      final res = await _dio.get<dynamic>('/action-cards/daily', queryParameters: query);
      final data = (res.data is Map && res.data['data'] != null)
          ? res.data['data'] as Map<String, dynamic>
          : res.data as Map<String, dynamic>;
      final rawCards = (data['cards'] as List?) ?? [];
      final cards = rawCards.map((c) => _mapCard(c as Map<String, dynamic>)).toList();
      final totalXp = cards.fold<int>(0, (sum, c) => sum + c.xpReward);
      return Right(DailyCardsSummary(
        cards: cards,
        totalCards: data['maxCards'] as int? ?? cards.length,
        completedToday: 0,
        totalXpAvailable: totalXp,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionCardEntity>> completeCard(String id, {String? notes}) async {
    try {
      final res = await _dio.post<dynamic>('/action-cards/$id/complete', data: {'notes': notes});
      final data = res.data as Map<String, dynamic>;
      return Right(ActionCardEntity(
        id: data['cardId'] as String? ?? id,
        type: ActionCardType.say,
        title: '',
        description: '',
        difficulty: ActionCardDifficulty.easy,
        estimatedMinutes: 0,
        xpReward: data['xpAwarded'] as int? ?? 0,
        status: ActionCardStatus.completed,
        contextTags: const [],
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ActionCardEntity>> skipCard(String id, {String? reason}) async {
    try {
      await _dio.post<dynamic>('/action-cards/$id/skip', data: {'reason': reason});
      return Right(ActionCardEntity(
        id: id,
        type: ActionCardType.say,
        title: '',
        description: '',
        difficulty: ActionCardDifficulty.easy,
        estimatedMinutes: 0,
        xpReward: 0,
        status: ActionCardStatus.skipped,
        contextTags: const [],
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveCard(String id) async {
    try {
      await _dio.post<dynamic>('/action-cards/$id/save');
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActionCardEntity>>> getSavedCards() async {
    try {
      final res = await _dio.get<dynamic>('/action-cards/history', queryParameters: {
        'status': 'saved',
      });
      final data = res.data as Map<String, dynamic>;
      final rawCards = (data['cards'] as List?) ?? [];
      final list = rawCards.map((c) => _mapCard(c as Map<String, dynamic>)).toList();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ActionCardEntity>>> getHistory({
    String? status,
    int limit = 20,
  }) async {
    try {
      final res = await _dio.get<dynamic>('/action-cards/history', queryParameters: {
        if (status != null) 'status': status,
        'limit': limit,
      });
      final data = res.data as Map<String, dynamic>;
      final rawCards = (data['cards'] as List?) ?? [];
      final list = rawCards.map((c) => _mapCard(c as Map<String, dynamic>)).toList();
      return Right(list);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  ActionCardEntity _mapCard(Map<String, dynamic> m) => ActionCardEntity(
        id: m['id'] as String,
        type: ActionCardType.values.firstWhere(
          (t) => t.name == (m['type'] as String).replaceAll('do', 'do_'),
          orElse: () => ActionCardType.say,
        ),
        title: m['titleLocalized'] as String? ?? m['title'] as String,
        description: m['descriptionLocalized'] as String? ?? m['description'] as String,
        difficulty: ActionCardDifficulty.values.firstWhere(
          (d) => d.name == m['difficulty'],
          orElse: () => ActionCardDifficulty.easy,
        ),
        estimatedMinutes: int.tryParse('${m['estimatedTime']}'.replaceAll(RegExp(r'[^0-9]'), '')) ?? 5,
        xpReward: m['xpReward'] as int? ?? 0,
        status: ActionCardStatus.values.firstWhere(
          (s) => s.name == m['status'],
          orElse: () => ActionCardStatus.pending,
        ),
        contextTags: (m['contextTags'] as List?)?.cast<String>() ?? [],
        personalizedDetail: m['personalizedDetail'] as String?,
      );
}
