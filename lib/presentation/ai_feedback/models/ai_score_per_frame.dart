import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../enums/ai_score_type.dart';

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

  List<double> getAllAvg() {
    List<double> result = [];
    for (int i = 0; i < accuracy.length; i += 1) {
      double tmp = 0;
      int tmpLength = 0;

      for (final value in getValuesByIdx(i)) {
        if (value != null) {
          tmp += value;
          tmpLength += 1;
        }
      }

      if (tmpLength == 0) {
        result.add(0);
      } else {
        result.add(tmp / tmpLength);
      }
    }
    return result;
  }

  List<double?> getValueByType(AiScoreType? aiScoreType) {
    switch (aiScoreType) {
      case null:
        {
          return getAllAvg();
        }
      case AiScoreType.accuracy:
        {
          return accuracy;
        }
      case AiScoreType.angle:
        {
          return angle;
        }
      case AiScoreType.balance:
        {
          return balance;
        }
      case AiScoreType.inertia:
        {
          return inertia;
        }
      case AiScoreType.moment:
        {
          return moment;
        }
    }
  }

  List<String> get getValuesName => ['정확도', '각도', '밸런스', '관성', '모멘트'];
}
