import 'package:climb_balance/presentation/ai_feedback/models/ai_score_state.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AiScore extends StatelessWidget {
  const AiScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: PentagonRadarChart(
        aiScoreState: AiScoreState(
            balance: 0.5, inertia: 0.3, accuracy: 0.1, angle: 0.2, moment: 0.5),
      ),
    );
  }
}

class PentagonRadarChart extends StatelessWidget {
  final AiScoreState aiScoreState;

  const PentagonRadarChart({
    Key? key,
    required this.aiScoreState,
  }) : super(key: key);

  static const List<String> titles = ['정확도', '각도', '밸런스', '관성', '모멘트'];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: Padding(
        padding: EdgeInsets.all(40),
        child: RadarChart(
          RadarChartData(
            titlePositionPercentageOffset: 0.15,
            tickCount: 10,
            ticksTextStyle: TextStyle(color: Colors.transparent),
            gridBorderData: BorderSide(
              color: color.onSurface,
            ),
            radarBorderData: BorderSide(
              color: Colors.transparent,
            ),
            tickBorderData: BorderSide(
              color: Colors.transparent,
            ),
            getTitle: (int idx, double value) {
              return RadarChartTitle(text: titles[idx]);
            },
            radarShape: RadarShape.polygon,
            dataSets: [
              RadarDataSet(
                entryRadius: 4,
                fillColor: color.primary.withOpacity(0.5),
                borderColor: color.primary,
                dataEntries: [
                  RadarEntry(value: aiScoreState.accuracy),
                  RadarEntry(value: aiScoreState.angle),
                  RadarEntry(value: aiScoreState.balance),
                  RadarEntry(value: aiScoreState.inertia),
                  RadarEntry(value: aiScoreState.moment),
                ],
              ),
            ],
          ),
          swapAnimationDuration: Duration(milliseconds: 150), // Optional
          swapAnimationCurve: Curves.linear, // Optional
        ),
      ),
    );
  }
}
