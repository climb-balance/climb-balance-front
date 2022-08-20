import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result {
  const factory Result.success(T value) = Success;

  const factory Result.loading() = Loading;

  const factory Result.error(String message) = Error;
}
