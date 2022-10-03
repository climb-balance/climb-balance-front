import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_feedback_state.freezed.dart';

part 'ai_feedback_state.g.dart';

@freezed
class AiFeedbackState with _$AiFeedbackState {
  const factory AiFeedbackState({
    @Default(-1) int version,
    @Default(30) int fps,
    @Default(0) int frames,
    @Default([]) List<double?> joints,
    @Default([]) List<double?> scores,
    @JsonKey(ignore: true) @Default(false) bool overlay,
  }) = _AiFeedbackDetail;

  factory AiFeedbackState.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackStateFromJson(json);
}
