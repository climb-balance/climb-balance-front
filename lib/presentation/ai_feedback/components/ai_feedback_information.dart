import 'dart:math';

import 'package:flutter/material.dart';

import '../models/ai_feedback_state.dart';
import 'ai_score.dart';

class AiFeedbackInformation extends StatelessWidget {
  final AiFeedbackState detail;

  const AiFeedbackInformation({Key? key, required this.detail})
      : super(key: key);

  int longestGoodLength() {
    int maxLength = 0;
    int curLength = 0;
    for (int i = 0; i < detail.scores.length; i++) {
      if (detail.scores[i] == 1) {
        curLength += 1;
        maxLength = max(maxLength, curLength);
      } else {
        curLength = 0;
      }
    }

    return maxLength;
  }

  int goodCount() {
    int curLength = 0;
    for (int i = 0; i < detail.scores.length; i++) {
      if (detail.scores[i] == 1) {
        curLength += 1;
      }
    }
    return curLength;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AiScore(precision: longestGoodLength(), balance: goodCount()),
            const Text('00:43~00:58 구간에서 특히 자세가 나빴습니다.')
          ],
        ),
      ),
    );
  }
}
