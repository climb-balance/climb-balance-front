import 'package:flutter/material.dart';

import 'continuous_statistics.dart';
import 'heat_map.dart';

class MainStatistics extends StatelessWidget {
  const MainStatistics({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2 - 30,
      child: Row(
        children: const [
          HeatMap(),
          ContinuousStatistics(),
        ],
      ),
    );
  }
}
