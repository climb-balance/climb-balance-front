import 'package:climb_balance/presentation/ai_feedback/models/ai_score_state.dart';
import 'package:climb_balance/presentation/common/components/ai/pentagon_radar_chart.dart';
import 'package:flutter/material.dart';

class AiScoreTab extends StatelessWidget {
  final AiScoreState aiScoreState;

  const AiScoreTab({Key? key, required this.aiScoreState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          '${aiScoreState.getOverallScore()}점',
          style: text.headline5?.copyWith(
            color: color.primary,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: PentagonRadarChart(
            aiScoreState: aiScoreState,
          ),
        ),
      ],
    );
  }
}
