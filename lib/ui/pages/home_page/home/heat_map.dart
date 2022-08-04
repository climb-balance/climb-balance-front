import 'dart:math';

import 'package:flutter/material.dart';

class HeatMap extends StatelessWidget {
  final List<int> datas;

  const HeatMap({Key? key, required this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GridView.count(
        padding: const EdgeInsets.all(5),
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        crossAxisCount: 6,
        children: datas.map((data) => HeatMapSquare(data: data)).toList(),
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
