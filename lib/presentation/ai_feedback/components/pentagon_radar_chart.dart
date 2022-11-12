import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/ai_score_state.dart';

class PentagonRadarChart extends StatelessWidget {
  final AiScoreState aiScoreState;
  final bool showText;

  const PentagonRadarChart({
    Key? key,
    required this.aiScoreState,
    this.showText = true,
  }) : super(key: key);

  static const List<String> titles = ['정확도', '각도', '밸런스', '관성', '모멘트'];

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1,
      child: RadarChart(
        RadarChartData(
          titlePositionPercentageOffset: 0.15,
          tickCount: 10,
          ticksTextStyle: const TextStyle(
            color: Colors.transparent,
            shadows: [],
          ),
          gridBorderData: BorderSide(
            color: color.onSurface,
          ),
          radarBorderData: const BorderSide(
            color: Colors.transparent,
          ),
          tickBorderData: const BorderSide(
            color: Colors.transparent,
          ),
          getTitle: (int idx, double value) {
            return RadarChartTitle(text: showText ? titles[idx] : '');
          },
          radarShape: RadarShape.polygon,
          dataSets: [
            RadarDataSet(
              entryRadius: 1,
              fillColor: color.secondary.withOpacity(0.1),
              borderColor: color.secondary,
              dataEntries: [
                RadarEntry(value: 1),
                RadarEntry(value: 1),
                RadarEntry(value: 1),
                RadarEntry(value: 1),
                RadarEntry(value: 1),
              ],
            ),
            RadarDataSet(
              entryRadius: showText ? 4 : 2.5,
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
        swapAnimationDuration: const Duration(milliseconds: 150), // Optional
        swapAnimationCurve: Curves.linear, // Optional
      ),
    );
  }
}
