import 'dart:math';

import 'package:climb_balance/presentation/home/home_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeatMap extends ConsumerWidget {
  const HeatMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datas =
        ref.watch(homeViewModelProvider.select((value) => value.climbingDatas));
    final List<FlSpot> spotDatas = [];
    for (int i = 0; i < datas.length; i++) {
      spotDatas.add(FlSpot(i.toDouble(), datas[i].toDouble()));
    }
    final theme = Theme.of(context);
    return Flexible(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: false,
                drawVerticalLine: true,
                horizontalInterval: 3,
                verticalInterval: 3,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: const Color(0xff919191),
                    strokeWidth: 1,
                  );
                },
                getDrawingVerticalLine: (value) {
                  return FlLine(
                    color: const Color(0xff838383),
                    strokeWidth: 1,
                  );
                },
              ),
              titlesData: FlTitlesData(
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: false,
                    interval: 3,
                    reservedSize: 42,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: spotDatas,
                  isStrokeCapRound: true,
                  gradient: LinearGradient(
                    colors: [
                      ColorTween(
                              begin: theme.colorScheme.primary,
                              end: theme.colorScheme.tertiary)
                          .lerp(0.2)!,
                      ColorTween(
                              begin: theme.colorScheme.primary,
                              end: theme.colorScheme.tertiary)
                          .lerp(0.2)!,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeatMapSquare extends StatefulWidget {
  final int data;
  static const maxValue = 13;

  const HeatMapSquare({Key? key, required this.data}) : super(key: key);

  @override
  State<HeatMapSquare> createState() => _HeatMapSquareState();
}

class _HeatMapSquareState extends State<HeatMapSquare> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        setState(() {
          _show = true;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: theme.colorScheme.primary.withOpacity(
            min(((widget.data + 1) / HeatMapSquare.maxValue), 1),
          ),
        ),
        child: AnimatedOpacity(
          opacity: _show ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 1000),
          child: Center(
            child: Text(
              widget.data.toString(),
            ),
          ),
          onEnd: () {
            setState(() {
              _show = false;
            });
          },
        ),
      ),
    );
  }
}
