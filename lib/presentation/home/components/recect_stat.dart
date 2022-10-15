import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RecentStat extends ConsumerWidget {
  final datas = const [12, 12, 3, 25, 5];

  const RecentStat({Key? key}) : super(key: key);

  BarChartGroupData makeBar(ColorScheme color, int x) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          color: color.primary.withOpacity(
            (datas[x] + 1) / (datas.reduce(max) + 1),
          ),
          width: 16,
          toY: datas[x].toDouble(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color.surface,
        ),
        padding: EdgeInsets.only(
          left: 18,
          right: 18,
          top: 20,
          bottom: 12,
        ),
        child: BarChart(
          BarChartData(
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              drawHorizontalLine: false,
              drawVerticalLine: false,
            ),
            titlesData: FlTitlesData(
              show: true,
              leftTitles: AxisTitles(),
              rightTitles: AxisTitles(),
              topTitles: AxisTitles(),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) => Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Text(
                      '${datas[value.toInt()]}',
                      style: text.subtitle2?.copyWith(
                        color: color.onBackground.withOpacity(0.7),
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            barGroups: [for (int i = 0; i < 5; i += 1) makeBar(color, i)],
            alignment: BarChartAlignment.spaceBetween,
          ),
        ),
      ),
    );
  }
}
