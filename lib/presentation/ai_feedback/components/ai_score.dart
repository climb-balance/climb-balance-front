import 'package:flutter/material.dart';

import '../../common/components/stars.dart';

class AiScore extends StatelessWidget {
  final int precision;
  final int balance;

  const AiScore({Key? key, required this.precision, required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(
              '밸런스',
              style: theme.textTheme.headline6,
            ),
            Stars(
              numOfStar: precision ~/ 5,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '유연성',
              style: theme.textTheme.headline6,
            ),
            const Stars(
              numOfStar: 5,
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '정확도',
              style: theme.textTheme.headline6,
            ),
            Stars(
              numOfStar: balance ~/ 5,
            ),
          ],
        ),
      ],
    );
  }
}
