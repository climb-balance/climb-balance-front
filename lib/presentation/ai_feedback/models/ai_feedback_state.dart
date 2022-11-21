import 'package:climb_balance/presentation/ai_feedback/models/ai_score_per_frame.dart';
import 'package:climb_balance/presentation/ai_feedback/models/ai_score_state.dart';
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
    @Default([]) List<double> badPoints,
    @Default(AiScoreState()) AiScoreState totalScore,
    @Default(AiScorePerFrame()) AiScorePerFrame perFrameScore,
    @JsonKey(ignore: true) @Default(true) bool squareOverlay,
    @JsonKey(ignore: true) @Default(true) bool lineOverlay,
    @JsonKey(ignore: true) @Default(true) bool scoreOverlay,
    @JsonKey(ignore: true) @Default(false) bool isInformOpen,
    @JsonKey(ignore: true) @Default(false) bool isStatusChanging,
    @JsonKey(ignore: true) @Default(false) bool actionsOpen,
    @JsonKey(ignore: true) @Default(false) bool isInitialized,
    @JsonKey(ignore: true) @Default(true) bool isPlaying,
  }) = _AiFeedbackState;

  factory AiFeedbackState.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackStateFromJson(json);
}
