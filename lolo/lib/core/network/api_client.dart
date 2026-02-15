import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/network/dio_client.dart';

/// Thin wrapper around [Dio] that provides a cleaner API for
/// repository implementations. Delegates all HTTP calls to the
/// underlying Dio instance.
class ApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.get(path, queryParameters: queryParameters, options: options);

  Future<Response<dynamic>> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) =>
      _dio.post(path, data: data, queryParameters: queryParameters, options: options);

  Future<Response<dynamic>> put(
    String path, {
    dynamic data,
    Options? options,
  }) =>
      _dio.put(path, data: data, options: options);

  Future<Response<dynamic>> patch(
    String path, {
    dynamic data,
    Options? options,
  }) =>
      _dio.patch(path, data: data, options: options);

  Future<Response<dynamic>> delete(
    String path, {
    dynamic data,
    Options? options,
  }) =>
      _dio.delete(path, data: data, options: options);
}

/// Global provider for [ApiClient], backed by the singleton [Dio] instance.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.watch(dioProvider));
});
