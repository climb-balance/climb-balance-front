import 'package:flutter/material.dart';

class ContinuousStatistics extends StatelessWidget {
  final List<int> datas;

  const ContinuousStatistics({Key? key, required this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('연속 5회 클라이밍'),
            Text(
              '🔥',
              style: theme.textTheme.headline2,
            ),
          ],
        ),
      ),
    );
  }
}
