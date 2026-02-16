import 'package:dio/dio.dart';
import 'package:lolo/core/constants/api_endpoints.dart';
import 'package:lolo/features/reminders/data/models/reminder_model.dart';

/// Remote data source for reminders API.
class RemindersRemoteDataSource {
  final Dio _dio;
  const RemindersRemoteDataSource(this._dio);

  /// GET /reminders
  Future<List<ReminderModel>> getReminders({
    String? type,
    String status = 'active',
    int limit = 20,
    String? lastDocId,
  }) async {
    final response = await _dio.get<dynamic>(
      ApiEndpoints.reminders,
      queryParameters: {
        if (type != null) 'type': type,
        'status': status,
        'limit': limit,
        if (lastDocId != null) 'lastDocId': lastDocId,
      },
    );
    final dataList = response.data['data'] as List;
    return dataList
        .map((e) => ReminderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// GET /reminders/upcoming
  Future<List<ReminderModel>> getUpcomingReminders({int days = 7}) async {
    final response = await _dio.get<dynamic>(
      '${ApiEndpoints.reminders}/upcoming',
      queryParameters: {'days': days},
    );
    final dataList = response.data['data'] as List;
    return dataList
        .map((e) => ReminderModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// POST /reminders
  Future<ReminderModel> createReminder(ReminderModel model) async {
    final response = await _dio.post<dynamic>(
      ApiEndpoints.reminders,
      data: model.toCreatePayload(),
    );
    return ReminderModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  /// PUT /reminders/:id
  Future<ReminderModel> updateReminder(
    String id,
    Map<String, dynamic> updates,
  ) async {
    final response = await _dio.put<dynamic>(
      '${ApiEndpoints.reminders}/$id',
      data: updates,
    );
    return ReminderModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  /// DELETE /reminders/:id
  Future<void> deleteReminder(String id) async {
    await _dio.delete<dynamic>('${ApiEndpoints.reminders}/$id');
  }

  /// POST /reminders/:id/complete
  Future<ReminderModel> completeReminder(String id, {String? notes}) async {
    final response = await _dio.post<dynamic>(
      '${ApiEndpoints.reminders}/$id/complete',
      data: {if (notes != null) 'notes': notes},
    );
    return ReminderModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }

  /// POST /reminders/:id/snooze
  Future<ReminderModel> snoozeReminder(String id, String duration) async {
    final response = await _dio.post<dynamic>(
      '${ApiEndpoints.reminders}/$id/snooze',
      data: {'duration': duration},
    );
    return ReminderModel.fromJson(
      response.data['data'] as Map<String, dynamic>,
    );
  }
}
