import 'package:flutter/material.dart';

class ContinuousStatistics extends StatelessWidget {
  const ContinuousStatistics({Key? key}) : super(key: key);

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
