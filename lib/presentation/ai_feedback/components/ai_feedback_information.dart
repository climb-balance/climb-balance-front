import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'ai_score.dart';

class AiFeedbackInformation extends ConsumerWidget {
  final int storyId;

  const AiFeedbackInformation({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final precision = ref
        .read(aiFeedbackViewModelProvider(storyId).notifier)
        .longestGoodLength();
    final balance =
        ref.read(aiFeedbackViewModelProvider(storyId).notifier).goodCount();
    return Container(
      color: theme.colorScheme.surface,
      height: size.height * 0.6,
      width: size.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              IconButton(
                onPressed: () {
                  ref
                      .read(aiFeedbackViewModelProvider(storyId).notifier)
                      .toggleInformation();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AiScore(
                  precision: precision,
                  balance: balance,
                ),
                const Text('00:43~00:58 구간에서 특히 자세가 나빴습니다.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
