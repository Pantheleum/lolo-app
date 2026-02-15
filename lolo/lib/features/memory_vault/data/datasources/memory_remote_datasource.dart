import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';

/// Remote data source for Memory Vault.
///
/// Communicates with /memories API endpoints.
class MemoryRemoteDataSource {
  final Dio _dio;
  const MemoryRemoteDataSource(this._dio);

  /// GET /memories
  Future<List<Map<String, dynamic>>> getMemories({
    String? category,
    String? searchQuery,
    int page = 1,
    int pageSize = 20,
  }) async {
    final response = await _dio.get(
      ApiEndpoints.memories,
      queryParameters: {
        'page': page,
        'pageSize': pageSize,
        if (category != null) 'category': category,
        if (searchQuery != null && searchQuery.isNotEmpty) 'q': searchQuery,
      },
    );
    return (response.data['data'] as List)
        .cast<Map<String, dynamic>>();
  }

  /// GET /memories/:id
  Future<Map<String, dynamic>> getMemory(String id) async {
    final response = await _dio.get(ApiEndpoints.memoryById(id));
    return response.data['data'] as Map<String, dynamic>;
  }

  /// POST /memories
  Future<Map<String, dynamic>> createMemory(
    Map<String, dynamic> memoryData,
  ) async {
    final response = await _dio.post(
      ApiEndpoints.memories,
      data: memoryData,
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// PUT /memories/:id
  Future<Map<String, dynamic>> updateMemory(
    String id,
    Map<String, dynamic> memoryData,
  ) async {
    final response = await _dio.put(
      ApiEndpoints.memoryById(id),
      data: memoryData,
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  /// DELETE /memories/:id
  Future<void> deleteMemory(String id) async {
    await _dio.delete(ApiEndpoints.memoryById(id));
  }

  /// GET /memories/search
  Future<List<Map<String, dynamic>>> searchMemories(String query) async {
    final response = await _dio.get(
      ApiEndpoints.memoriesSearch,
      queryParameters: {'q': query},
    );
    return (response.data['data'] as List)
        .cast<Map<String, dynamic>>();
  }

  /// GET /memories/timeline
  Future<List<Map<String, dynamic>>> getTimeline() async {
    final response = await _dio.get(ApiEndpoints.memoriesTimeline);
    return (response.data['data'] as List)
        .cast<Map<String, dynamic>>();
  }
}
