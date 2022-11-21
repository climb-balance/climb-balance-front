import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/ai_feedback/enums/ai_score_type.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/buttons.dart';

class AiScoreGraphTab extends ConsumerStatefulWidget {
  final int storyId;

  const AiScoreGraphTab({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  @override
  ConsumerState createState() => _AiScoreGraphTabState();
}

class _AiScoreGraphTabState extends ConsumerState<AiScoreGraphTab> {
  AiScoreType? currentGraphType;

  double getAvgData(List<double?> datas) {
    double result = 0;
    int resultLength = 0;
    for (int i = 0; i < datas.length; i += 1) {
      if (datas[i] == null) continue;
      result += datas[i]!;
      resultLength += 1;
    }
    if (resultLength == 0) return 0;
    return double.parse((result / resultLength).toStringAsFixed(3));
  }

  void updateCurrentGraphType(AiScoreType? newGraphType) {
    currentGraphType = newGraphType;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> spots = [];
    final perFrameScore = ref.watch(aiFeedbackViewModelProvider(widget.storyId)
        .select((value) => value.perFrameScore));
    final frames = ref.watch(aiFeedbackViewModelProvider(widget.storyId)
        .select((value) => value.frames));
    for (int i = 0; i < frames - 30; i += 30) {
      spots.add(
        FlSpot(
          i.toDouble(),
          getAvgData(
            perFrameScore.getValueByType(currentGraphType).sublist(i, i + 30),
          ),
        ),
      );
    }
    final color = Theme.of(context).colorScheme;
    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              AiGraphBtn(
                updateCurrentGraphType: updateCurrentGraphType,
                graphType: null,
                currentGraphType: currentGraphType,
                title: '전체',
              ),
              AiGraphBtn(
                updateCurrentGraphType: updateCurrentGraphType,
                graphType: AiScoreType.accuracy,
                currentGraphType: currentGraphType,
                title: '정확도',
              ),
              AiGraphBtn(
                updateCurrentGraphType: updateCurrentGraphType,
                graphType: AiScoreType.angle,
                currentGraphType: currentGraphType,
                title: '각도',
              ),
              AiGraphBtn(
                updateCurrentGraphType: updateCurrentGraphType,
                graphType: AiScoreType.balance,
                currentGraphType: currentGraphType,
                title: '밸런스',
              ),
              AiGraphBtn(
                  updateCurrentGraphType: updateCurrentGraphType,
                  graphType: AiScoreType.inertia,
                  currentGraphType: currentGraphType,
                  title: '관성'),
              AiGraphBtn(
                updateCurrentGraphType: updateCurrentGraphType,
                graphType: AiScoreType.moment,
                currentGraphType: currentGraphType,
                title: '모멘트',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              padding: const EdgeInsets.all(10),
              width: frames * 0.5,
              height: 300,
              child: LineChart(
                LineChartData(
                  maxY: 1,
                  minY: 0,
                  titlesData: FlTitlesData(
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: false,
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) =>
                            Text('${value ~/ 30}s'),
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      color: color.primary,
                      spots: spots,
                      dotData: FlDotData(
                        show: false,
                      ),
                    ),
                  ],
                  lineTouchData: LineTouchData(
                    touchTooltipData: LineTouchTooltipData(
                      fitInsideVertically: true,
                      fitInsideHorizontally: true,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class AiGraphBtn extends StatelessWidget {
  final AiScoreType? graphType;
  final AiScoreType? currentGraphType;
  final void Function(AiScoreType?) updateCurrentGraphType;
  final String title;

  const AiGraphBtn({
    Key? key,
    required this.updateCurrentGraphType,
    required this.graphType,
    required this.currentGraphType,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isActive = currentGraphType == graphType;
    final color = Theme.of(context).colorScheme;
    return CustomBtnNoPadding(
      onPressed: () {
        updateCurrentGraphType(graphType);
      },
      type: isActive ? BtnType.primary : BtnType.secondary,
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? color.onPrimary : color.onSurface,
        ),
      ),
    );
  }
}
