import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';

/// Remote data source for SOS Mode.
///
/// Communicates with /sos API endpoints and supports SSE streaming
/// for real-time coaching step delivery.
class SosRemoteDataSource {
  final Dio _dio;
  const SosRemoteDataSource(this._dio);

  /// POST /sos/activate
  Future<Map<String, dynamic>> activateSession({
    required String scenario,
    required String urgency,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.sosActivate,
      data: {'scenario': scenario, 'urgency': urgency},
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// POST /sos/assess
  Future<Map<String, dynamic>> submitAssessment({
    required String sessionId,
    required Map<String, dynamic> answers,
  }) async {
    final response = await _dio.post(
      ApiEndpoints.sosAssess,
      data: {'sessionId': sessionId, ...answers},
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// GET /sos/coach (SSE streaming)
  Stream<Map<String, dynamic>> streamCoachingSteps({
    required String sessionId,
  }) async* {
    final response = await _dio.get<ResponseBody>(
      ApiEndpoints.sosCoach,
      queryParameters: {'sessionId': sessionId},
      options: Options(
        responseType: ResponseType.stream,
        headers: {'Accept': 'text/event-stream'},
      ),
    );

    final stream = response.data?.stream;
    if (stream == null) return;

    String buffer = '';
    await for (final chunk in stream) {
      buffer += utf8.decode(chunk);
      final lines = buffer.split('\n');
      buffer = lines.removeLast();

      for (final line in lines) {
        if (line.startsWith('data: ')) {
          final jsonStr = line.substring(6).trim();
          if (jsonStr == '[DONE]') return;
          if (jsonStr.isNotEmpty) {
            yield json.decode(jsonStr) as Map<String, dynamic>;
          }
        }
      }
    }
  }

  /// PUT /sos/:id
  Future<void> completeSession({
    required String sessionId,
    required int rating,
    String? resolution,
    bool saveToMemoryVault = false,
  }) async {
    await _dio.put(
      ApiEndpoints.sosSession(sessionId),
      data: {
        'rating': rating,
        if (resolution != null) 'resolution': resolution,
        'saveToMemoryVault': saveToMemoryVault,
      },
    );
  }

  /// GET /sos/:id
  Future<Map<String, dynamic>> getSession(String sessionId) async {
    final response = await _dio.get(ApiEndpoints.sosSession(sessionId));
    return response.data['data'] as Map<String, dynamic>;
  }
}
