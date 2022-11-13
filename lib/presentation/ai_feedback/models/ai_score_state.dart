import 'package:climb_balance/presentation/ai_feedback/models/ai_score_per_frame.dart';
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

  factory AiScoreState.fromPerFrame(AiScorePerFrame perFrameScore, int idx) {
    return AiScoreState(
      balance: perFrameScore.balance[idx] ?? 0,
      accuracy: perFrameScore.accuracy[idx] ?? 0,
      angle: perFrameScore.angle[idx] ?? 0,
      moment: perFrameScore.moment[idx] ?? 0,
      inertia: perFrameScore.inertia[idx] ?? 0,
    );
  }

  factory AiScoreState.fromJson(Map<String, dynamic> json) =>
      _$AiScoreStateFromJson(json);

  const AiScoreState._();

  int getOverallScore() {
    return ((angle + balance + accuracy + moment + inertia) / 5 * 100).toInt();
  }

  List<String> get getValuesName => ['정확도', '각도', '밸런스', '관성', '모멘트'];
}
