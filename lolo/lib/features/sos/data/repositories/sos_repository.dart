import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lolo/core/errors/failures.dart';
import 'package:lolo/core/network/dio_client.dart';
import 'package:lolo/features/sos/domain/entities/sos_session.dart';
import 'package:lolo/features/sos/domain/entities/sos_assessment.dart';
import 'package:lolo/features/sos/domain/entities/coaching_step.dart';

abstract class SosRepository {
  Future<Either<Failure, SosSession>> activate({
    required String scenario,
    required String urgency,
    String? briefContext,
  });
  Future<Either<Failure, SosAssessment>> assess({
    required String sessionId,
    required Map<String, dynamic> answers,
  });
  Stream<CoachingStep> coachStream({
    required String sessionId,
    required int stepNumber,
    String? userUpdate,
  });
  Future<Either<Failure, void>> resolve({
    required String sessionId,
    required String outcome,
    int? rating,
  });
}

final sosRepositoryProvider = Provider<SosRepository>((ref) =>
    SosRepositoryImpl(ref.watch(dioProvider)));

class SosRepositoryImpl implements SosRepository {
  SosRepositoryImpl(this._dio);
  final Dio _dio;

  @override
  Future<Either<Failure, SosSession>> activate({
    required String scenario,
    required String urgency,
    String? briefContext,
  }) async {
    try {
      final res = await _dio.post<dynamic>('/sos/activate', data: {
        'scenario': scenario,
        'urgency': urgency,
        if (briefContext != null) 'briefContext': briefContext,
      });
      final d = res.data['data'] as Map<String, dynamic>;
      final adv = d['immediateAdvice'] as Map<String, dynamic>;
      return Right(SosSession(
        sessionId: d['sessionId'] as String,
        scenario: SosScenario.values.firstWhere(
          (s) => s.name == _camelCase(d['scenario'] as String),
          orElse: () => SosScenario.other,
        ),
        urgency: SosUrgency.values.firstWhere(
          (u) => u.name == _camelCase(d['urgency'] as String),
          orElse: () => SosUrgency.happeningNow,
        ),
        immediateAdvice: SosImmediateAdvice(
          doNow: adv['doNow'] as String,
          doNotDo: adv['doNotDo'] as String,
          bodyLanguage: adv['bodyLanguage'] as String,
        ),
        severityAssessmentRequired: d['severityAssessmentRequired'] as bool,
        estimatedResolutionSteps: d['estimatedResolutionSteps'] as int,
        createdAt: DateTime.parse(d['createdAt'] as String),
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, SosAssessment>> assess({
    required String sessionId,
    required Map<String, dynamic> answers,
  }) async {
    try {
      final res = await _dio.post<dynamic>('/sos/assess', data: {
        'sessionId': sessionId,
        'answers': answers,
      });
      final d = res.data['data'] as Map<String, dynamic>;
      final plan = d['coachingPlan'] as Map<String, dynamic>;
      return Right(SosAssessment(
        sessionId: d['sessionId'] as String,
        severityScore: d['severityScore'] as int,
        severityLabel: d['severityLabel'] as String,
        coachingPlan: SosCoachingPlan(
          totalSteps: plan['totalSteps'] as int,
          estimatedMinutes: plan['estimatedMinutes'] as int,
          approach: plan['approach'] as String,
          keyInsight: plan['keyInsight'] as String,
        ),
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<CoachingStep> coachStream({
    required String sessionId,
    required int stepNumber,
    String? userUpdate,
  }) async* {
    final res = await _dio.post<dynamic>(
      '/sos/coach',
      data: {
        'sessionId': sessionId,
        'stepNumber': stepNumber,
        'stream': true,
        if (userUpdate != null) 'userUpdate': userUpdate,
      },
      options: Options(
        headers: {'Accept': 'text/event-stream'},
        responseType: ResponseType.stream,
      ),
    );

    String sayThis = '';
    String bodyLang = '';
    List<String> doNotSay = [];
    bool isLast = false;
    String? nextPrompt;
    int totalSteps = stepNumber;

    await for (final chunk in (res.data as ResponseBody).stream) {
      final lines = utf8.decode(chunk).split('\n');
      for (final line in lines) {
        if (line.startsWith('data: ')) {
          final json = jsonDecode(line.substring(6)) as Map<String, dynamic>;
          if (json.containsKey('text')) sayThis += json['text'] as String;
          if (json.containsKey('phrases')) {
            doNotSay = (json['phrases'] as List).cast<String>();
          }
          if (json.containsKey('isLastStep')) {
            isLast = json['isLastStep'] as bool;
            nextPrompt = json['nextStepPrompt'] as String?;
          }
        }
      }
    }

    yield CoachingStep(
      sessionId: sessionId,
      stepNumber: stepNumber,
      totalSteps: totalSteps,
      sayThis: sayThis,
      whyItWorks: '',
      doNotSay: doNotSay,
      bodyLanguageTip: bodyLang,
      toneAdvice: 'calm',
      isLastStep: isLast,
      nextStepPrompt: nextPrompt,
    );
  }

  @override
  Future<Either<Failure, void>> resolve({
    required String sessionId,
    required String outcome,
    int? rating,
  }) async {
    try {
      await _dio.post<dynamic>('/sos/resolve', data: {
        'sessionId': sessionId,
        'outcome': outcome,
        if (rating != null) 'rating': rating,
      });
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  String _camelCase(String s) {
    final parts = s.split('_');
    return parts.first +
        parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
  }
}
