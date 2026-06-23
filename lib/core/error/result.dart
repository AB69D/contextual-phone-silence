import 'failures.dart';

sealed class Result<T> {
  const Result();

  factory Result.success(T value) = Success<T>;
  factory Result.failure(AppFailure failure) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get valueOrNull => switch (this) {
    Success(:final value) => value,
    Failure() => null,
  };

  AppFailure? get failureOrNull => switch (this) {
    Success() => null,
    Failure(:final failure) => failure,
  };

  T getOrElse(T Function(AppFailure) orElse) => switch (this) {
    Success(:final value) => value,
    Failure(:final failure) => orElse(failure),
  };

  Result<R> map<R>(R Function(T) transform) => switch (this) {
    Success(:final value) => Result.success(transform(value)),
    Failure(:final failure) => Result.failure(failure),
  };

  static Result<T> guard<T>(T Function() fn) {
    try {
      return Result.success(fn());
    } catch (e) {
      return Result.failure(AppFailure.unexpected(e.toString()));
    }
  }

  static Future<Result<T>> guardAsync<T>(Future<T> Function() fn) async {
    try {
      return Result.success(await fn());
    } catch (e) {
      return Result.failure(AppFailure.unexpected(e.toString()));
    }
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class Failure<T> extends Result<T> {
  const Failure(this.failure);
  final AppFailure failure;
}
