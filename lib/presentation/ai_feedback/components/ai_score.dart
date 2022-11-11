import 'package:climb_balance/presentation/ai_feedback/components/pentagon_radar_chart.dart';
import 'package:climb_balance/presentation/ai_feedback/models/ai_score_state.dart';
import 'package:flutter/material.dart';

class AiScore extends StatelessWidget {
  final AiScoreState aiScoreState;

  const AiScore({Key? key, required this.aiScoreState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: PentagonRadarChart(
        aiScoreState: aiScoreState,
      ),
    );
  }
}
