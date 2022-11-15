import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'ai_analysis.dart';
import 'ai_information_tab_bar.dart';
import 'ai_parameter_detail_tab.dart';
import 'ai_score.dart';

class AiFeedbackInformation extends ConsumerWidget {
  final int storyId;
  final VideoPlayerController videoPlayerController;

  const AiFeedbackInformation({
    Key? key,
    required this.storyId,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    final totalScore = ref.watch(
      aiFeedbackViewModelProvider(storyId).select((value) => value.totalScore),
    );
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
            const AiInformationTabBar(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    AiScoreTab(
                      aiScoreState: totalScore,
                    ),
                    AnalysisTab(
                      videoPlayerController: videoPlayerController,
                      storyId: storyId,
                      timestamps: [1230, 10000, 15000],
                    ),
                    AiParameterDetailTab(),
                  ],
                ),
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
