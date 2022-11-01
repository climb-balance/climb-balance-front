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
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    final precision = ref
        .read(aiFeedbackViewModelProvider(storyId).notifier)
        .longestGoodLength();
    final balance =
        ref.read(aiFeedbackViewModelProvider(storyId).notifier).goodCount();
    return Container(
      height: size.height * 0.6,
      width: size.width,
      color: color.background,
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AiInformationActionBar(storyId: storyId),
            AiInformationTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  AiScore(
                    precision: precision,
                    balance: balance,
                  ),
                  Text('sdsd'),
                  Text('sd'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AiInformationActionBar extends ConsumerWidget {
  const AiInformationActionBar({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  final int storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
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
    );
  }
}

class AiInformationTabBar extends StatelessWidget {
  const AiInformationTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.surface,
      child: TabBar(
        labelPadding: EdgeInsets.all(10),
        tabs: [Text('점수'), Text('분석'), Text('통계')],
      ),
    );
  }
}
