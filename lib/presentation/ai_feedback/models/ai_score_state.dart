import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_score_state.freezed.dart';

part 'ai_score_state.g.dart';

@freezed
class AiScoreState with _$AiScoreState {
  const factory AiScoreState({
    @Default(0.0) double balance,
    @Default(0.0) double accuracy,
    @Default(0.0) double angle,
    @Default(0.0) double moment,
    @Default(0.0) double inertia,
  }) = _AiScoreState;

  factory AiScoreState.fromJson(Map<String, dynamic> json) =>
      _$AiScoreStateFromJson(json);
}
