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
    @JsonKey(ignore: true) @Default(true) bool squareOverlay,
    @JsonKey(ignore: true) @Default(true) bool lineOverlay,
    @JsonKey(ignore: true) @Default(false) bool isInformOpen,
    @JsonKey(ignore: true) @Default(false) bool isStatusChanging,
  }) = _AiFeedbackDetail;

  factory AiFeedbackState.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackStateFromJson(json);
}
