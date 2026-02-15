// FILE: lib/features/ai/data/repositories/ai_repository_impl.dart

import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/errors/exceptions.dart';
import 'package:lolo/core/network/api_client.dart';
import 'package:lolo/features/ai/data/datasources/ai_cache_manager.dart';
import 'package:lolo/features/ai/data/services/content_safety_filter.dart';
import 'package:lolo/features/ai/domain/failures/ai_failures.dart';
import 'package:lolo/features/ai/domain/entities/ai_request.dart';
import 'package:lolo/features/ai/domain/entities/ai_response.dart';
import 'package:lolo/features/ai/domain/enums/ai_enums.dart';
import 'package:lolo/features/ai/domain/repositories/ai_repository.dart';

class AiRepositoryImpl implements AiRepository {
  final ApiClient _api;
  final AiCacheManager _cache;
  final ContentSafetyFilter _safety;

  AiRepositoryImpl({
    required ApiClient api,
    required AiCacheManager cache,
    required ContentSafetyFilter safety,
  })  : _api = api,
        _cache = cache,
        _safety = safety;

  // --- Messages ---

  @override
  Future<Either<Failure, AiMessageResponse>> generateMessage(
      AiMessageRequest request) async {
    try {
      final validation = _safety.validateInput(request.additionalContext);
      if (!validation.isValid) {
        return Left(ContentSafetyFailure(message: validation.reason ?? 'Content blocked'));
      }

      final cacheKey = _cache.messageKey(
        mode: request.mode.apiValue,
        tone: request.tone.apiValue,
        context: request.additionalContext,
      );
      final cached = await _cache.get<AiMessageResponse>(cacheKey);
      if (cached != null) return Right(cached);

      final response = await _api.post('/ai/messages/generate', data: {
        'mode': request.mode.apiValue,
        'tone': request.tone.apiValue,
        'length': request.length.apiValue,
        'profileId': request.profileId,
        if (request.additionalContext != null)
          'additionalContext': request.additionalContext,
        if (request.emotionalState != null)
          'emotionalState': request.emotionalState!.name,
        if (request.situationSeverity != null)
          'situationSeverity': request.situationSeverity,
        'includeAlternatives': request.includeAlternatives,
      });

      final result = AiMessageResponse.fromJson(response.data['data']);

      final postValidation = _safety.validateOutput(result.content);
      if (!postValidation.isValid) {
        return Left(ContentSafetyFailure(message: postValidation.reason ?? 'Response blocked'));
      }

      final ttl = _cache.ttlForMode(request.mode);
      if (ttl > Duration.zero) {
        await _cache.put(cacheKey, result, ttl: ttl);
      }

      return Right(result);
    } on TierLimitException catch (e) {
      return Left(AiTierLimitFailure(message: e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<AiMessageResponse>>> getMessageHistory({
    AiMessageMode? mode,
    bool? favoritesOnly,
    int limit = 20,
    String? lastDocId,
  }) async {
    try {
      final response = await _api.get('/ai/messages/history', queryParameters: {
        if (mode != null) 'mode': mode.apiValue,
        if (favoritesOnly != null) 'favorited': favoritesOnly,
        'limit': limit,
        if (lastDocId != null) 'lastDocId': lastDocId,
      });
      final list = (response.data['data'] as List)
          .map((e) => AiMessageResponse.fromJson(e as Map<String, dynamic>))
          .toList();
      return Right(list);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> toggleFavorite(String messageId, bool isFavorited) async {
    try {
      await _api.post('/ai/messages/$messageId/favorite', data: {
        'isFavorited': isFavorited,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> submitFeedback(String messageId, String feedback) async {
    try {
      await _api.post('/ai/messages/$messageId/feedback', data: {
        'feedback': feedback,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- Gifts ---

  @override
  Future<Either<Failure, GiftRecommendationResponse>> getGiftRecommendations(
      GiftRecommendationRequest request) async {
    try {
      final cacheKey = _cache.giftKey(
        occasion: request.occasion.apiValue,
        budgetMin: request.budgetMin,
        budgetMax: request.budgetMax,
      );
      final cached = await _cache.get<GiftRecommendationResponse>(cacheKey);
      if (cached != null) return Right(cached);

      final response = await _api.post('/gifts/recommend', data: {
        'profileId': request.profileId,
        'occasion': request.occasion.apiValue,
        if (request.occasionDetails != null) 'occasionDetails': request.occasionDetails,
        'budgetMin': request.budgetMin,
        'budgetMax': request.budgetMax,
        'currency': request.currency,
        'giftType': request.giftType.apiValue,
        if (request.excludeCategories.isNotEmpty)
          'excludeCategories': request.excludeCategories,
        'count': request.count,
      });

      final result = GiftRecommendationResponse.fromJson(response.data['data']);
      await _cache.put(cacheKey, result, ttl: const Duration(hours: 24));
      return Right(result);
    } on TierLimitException catch (e) {
      return Left(AiTierLimitFailure(message: e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> submitGiftFeedback(
      String giftId, String outcome, {String? comment}) async {
    try {
      await _api.post('/gifts/$giftId/feedback', data: {
        'outcome': outcome,
        if (comment != null) 'comment': comment,
      });
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- SOS ---

  @override
  Future<Either<Failure, SosActivateResponse>> activateSos(
      SosActivateRequest request) async {
    try {
      final response = await _api.post('/sos/activate', data: {
        'scenario': request.scenario.apiValue,
        'urgency': request.urgency.apiValue,
        if (request.briefContext != null) 'briefContext': request.briefContext,
        if (request.profileId != null) 'profileId': request.profileId,
      });
      return Right(SosActivateResponse.fromJson(response.data['data']));
    } on TierLimitException catch (e) {
      return Left(AiTierLimitFailure(message: e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, SosAssessResponse>> assessSos(SosAssessRequest request) async {
    try {
      final response = await _api.post('/sos/assess', data: {
        'sessionId': request.sessionId,
        'answers': request.answers.toJson(),
      });
      return Right(SosAssessResponse.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, SosCoachResponse>> getCoaching(SosCoachRequest request) async {
    try {
      final response = await _api.post('/sos/coach', data: {
        'sessionId': request.sessionId,
        'stepNumber': request.stepNumber,
        if (request.userUpdate != null) 'userUpdate': request.userUpdate,
        if (request.herResponse != null) 'herResponse': request.herResponse,
        'stream': false,
      });
      return Right(SosCoachResponse.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Stream<SosCoachingEvent> streamCoaching(SosCoachRequest request) async* {
    try {
      final response = await _api.post(
        '/sos/coach',
        data: {
          'sessionId': request.sessionId,
          'stepNumber': request.stepNumber,
          if (request.userUpdate != null) 'userUpdate': request.userUpdate,
          if (request.herResponse != null) 'herResponse': request.herResponse,
          'stream': true,
        },
        options: Options(
          headers: {'Accept': 'text/event-stream'},
          responseType: ResponseType.stream,
        ),
      );

      final stream = response.data.stream as Stream<List<int>>;
      String buffer = '';

      await for (final chunk in stream) {
        buffer += utf8.decode(chunk);
        final lines = buffer.split('\n');
        buffer = lines.removeLast();

        String? currentEvent;
        for (final line in lines) {
          if (line.startsWith('event: ')) {
            currentEvent = line.substring(7).trim();
          } else if (line.startsWith('data: ') && currentEvent != null) {
            final jsonStr = line.substring(6).trim();
            if (jsonStr.isNotEmpty) {
              try {
                final data = jsonDecode(jsonStr) as Map<String, dynamic>;
                yield SosCoachingEvent(eventType: currentEvent, data: data);
              } catch (_) {}
            }
            currentEvent = null;
          }
        }
      }
    } catch (e) {
      yield SosCoachingEvent(eventType: 'error', data: {'message': e.toString()});
    }
  }

  // --- Action Cards ---

  @override
  Future<Either<Failure, ActionCardsResponse>> getDailyCards({
    String? date,
    bool forceRefresh = false,
  }) async {
    try {
      final effectiveDate = date ?? DateTime.now().toIso8601String().substring(0, 10);

      if (!forceRefresh) {
        final cacheKey = 'cards:$effectiveDate';
        final cached = await _cache.get<ActionCardsResponse>(cacheKey);
        if (cached != null) return Right(cached);
      }

      final response = await _api.get('/action-cards', queryParameters: {
        'date': date,
        if (forceRefresh) 'forceRefresh': true,
      });

      final result = ActionCardsResponse.fromJson(response.data['data']);
      await _cache.put('cards:$effectiveDate', result,
          ttl: const Duration(hours: 12));
      return Right(result);
    } on TierLimitException catch (e) {
      return Left(AiTierLimitFailure(message: e.message));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, CardCompleteResponse>> completeCard(
      String cardId, {String? notes}) async {
    try {
      final response = await _api.post('/action-cards/$cardId/complete', data: {
        if (notes != null) 'notes': notes,
      });
      _cache.invalidatePattern('cards:');
      return Right(CardCompleteResponse.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, ActionCard?>> skipCard(
      String cardId, {String? reason}) async {
    try {
      final response = await _api.post('/action-cards/$cardId/skip', data: {
        if (reason != null) 'reason': reason,
      });
      _cache.invalidatePattern('cards:');
      final replacement = response.data['data']['replacementCard'];
      if (replacement != null) {
        return Right(ActionCard.fromJson(replacement));
      }
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  @override
  Future<Either<Failure, void>> saveCard(String cardId) async {
    try {
      await _api.post('/action-cards/$cardId/save');
      return const Right(null);
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- Usage ---

  @override
  Future<Either<Failure, AiUsageInfo>> getUsage(AiRequestType type) async {
    try {
      final response = await _api.get('/ai/usage', queryParameters: {
        'type': type.apiValue,
      });
      return Right(AiUsageInfo.fromJson(response.data['data']));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    }
  }

  // --- Error Mapping ---

  Failure _mapDioError(DioException e) {
    final statusCode = e.response?.statusCode;
    final errorCode = e.response?.data?['error']?['code'] as String?;
    final errorMsg =
        e.response?.data?['error']?['message'] as String? ?? e.message ?? 'Unknown error';

    return switch (statusCode) {
      400 => AiValidationFailure(message: errorMsg),
      401 => AiAuthFailure(message: errorMsg),
      403 when errorCode == 'TIER_LIMIT_EXCEEDED' => AiTierLimitFailure(message: errorMsg),
      403 => PermissionFailure(message: errorMsg),
      404 => NotFoundFailure(message: errorMsg),
      429 => RateLimitFailure(message: errorMsg,
          retryAfter: int.tryParse(
              e.response?.headers.value('retry-after') ?? '')),
      503 => AiServiceUnavailableFailure(message: errorMsg),
      _ => ServerFailure(message: errorMsg),
    };
  }
}
