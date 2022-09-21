import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T> with _$Result {
  const factory Result.success(T value) = Success;

  const factory Result.error(String message) = Error;
}
//TODO waiting 추가 https://omasuaku.medium.com/riverpod-flutter-hooks-the-best-duo-for-state-management-9429728d632b
