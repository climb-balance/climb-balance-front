import 'package:climb_balance/presentation/common/components/ai/pentagon_radar_chart.dart';
import 'package:climb_balance/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../ai_feedback/models/ai_score_state.dart';
import 'ai_background.dart';

class RecentAiStat extends ConsumerWidget {
  const RecentAiStat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stat =
        ref.watch(homeViewModelProvider.select((value) => value.aiStat))!;
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final currentAiState = AiScoreState(
      accuracy: stat.accuracy,
      angle: stat.angle,
      balance: stat.balance,
      moment: stat.moment,
      inertia: stat.inertia,
    );
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        children: [
          const AiBackground(),
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${currentAiState.getOverallScore()}점',
                  style: text.subtitle1?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: color.primary,
                  ),
                ),
                SizedBox(
                  width: 125,
                  height: 125,
                  child: PentagonRadarChart(
                    showText: false,
                    aiScoreState: currentAiState,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
