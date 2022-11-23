import 'dart:math';

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

  MinAiScore getMinAiScoreByFrame(int frame) {
    List<double> values = [0, 0, 0, 0, 0];
    List<int> lengths = [0, 0, 0, 0, 0];

    for (int i = frame; i < min(frame + 30, accuracy.length); i += 1) {
      final tmp = getValuesByIdx(i);

      for (int j = 0; j < 5; j += 1) {
        if (tmp[j] == null) continue;
        values[j] += tmp[j]!;
        lengths[j] += 1;
      }
    }

    int min_idx = -1;
    double min_val = 1;

    for (int i = 0; i < 5; i += 1) {
      double val = 0;
      if (lengths[i] != 0) {
        val = values[i] / lengths[i];
      }

      if (min_val > val) {
        min_idx = i;
        min_val = val;
      }
    }

    return MinAiScore(
      name: getValuesName[min_idx],
      score: min_val,
      type: getTypes[min_idx],
    );
  }

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

  List<AiScoreType> get getTypes => [
        AiScoreType.accuracy,
        AiScoreType.angle,
        AiScoreType.balance,
        AiScoreType.inertia,
        AiScoreType.moment,
      ];
}

@freezed
class MinAiScore with _$MinAiScore {
  const factory MinAiScore({
    required String name,
    required double score,
    required AiScoreType type,
  }) = _MinAiScore;
}
