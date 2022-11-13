import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_score_per_frame.freezed.dart';

part 'ai_score_per_frame.g.dart';

@freezed
class AiScorePerFrame with _$AiScorePerFrame {
  const factory AiScorePerFrame({
    @Default([]) List<double?> accuracy,
    @Default([]) List<double?> angle,
    @Default([]) List<double?> balance,
    @Default([]) List<double?> inertia,
    @Default([]) List<double?> moment,
  }) = _AiScorePerFrame;

  factory AiScorePerFrame.fromJson(Map<String, dynamic> json) =>
      _$AiScorePerFrameFromJson(json);

  const AiScorePerFrame._();

  List<double?> getValuesByIdx(int idx) {
    return [accuracy[idx], angle[idx], balance[idx], inertia[idx], moment[idx]];
  }

  List<String> get getValuesName => ['정확도', '각도', '밸런스', '관성', '모멘트'];
}
