import 'package:climb_balance/presentation/ai_feedback/components/score_advice.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ai_feedback_view_model.dart';

class WorstScore extends ConsumerWidget {
  const WorstScore({
    Key? key,
    required this.storyId,
    required this.badPoint,
  }) : super(key: key);
  final int storyId;
  final double badPoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final perFrameScore = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.perFrameScore));
    final frame = (badPoint * 30).toInt();
    final minScore = perFrameScore.getMinAiScoreByFrame(frame);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${minScore.name}을(를) 개선 해보세요!'),
            const SizedBox(
              width: 5,
            ),
            Text('(${(minScore.score * 100).toInt()}점)'),
          ],
        ),
        Divider(),
        ScoreAdvice(aiScoreType: minScore.type),
        Divider(),
      ],
    );
  }
}
