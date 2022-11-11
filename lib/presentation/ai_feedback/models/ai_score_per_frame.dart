import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_score_per_frame.freezed.dart';

part 'ai_score_per_frame.g.dart';

@freezed
class AiScorePerFrame with _$AiScorePerFrame {
  const factory AiScorePerFrame({
    @Default([]) List<double?> balance,
    @Default([]) List<double?> accuracy,
    @Default([]) List<double?> angle,
    @Default([]) List<double?> moment,
    @Default([]) List<double?> inertia,
  }) = _AiScorePerFrame;

  factory AiScorePerFrame.fromJson(Map<String, dynamic> json) =>
      _$AiScorePerFrameFromJson(json);
}
