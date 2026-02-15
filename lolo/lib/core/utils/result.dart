import 'package:lolo/core/errors/failures.dart';

/// Either type for use case return values.
///
/// Convention: Left = Failure, Right = Success value.
///
/// Usage:
/// ```dart
/// final result = await useCase.call(params);
/// result.fold(
///   (failure) => state = ErrorState(failure.message),
///   (data) => state = LoadedState(data),
/// );
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(Failure failure) = Err<T>;

  /// Fold the result into a single value.
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess);
}

class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) =>
      onSuccess(data);
}

class Err<T> extends Result<T> {
  final Failure failure;
  const Err(this.failure);

  @override
  R fold<R>(R Function(Failure failure) onFailure, R Function(T data) onSuccess) =>
      onFailure(failure);
}
