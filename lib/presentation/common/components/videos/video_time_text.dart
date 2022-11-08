import 'package:flutter/material.dart';

import '../../../../domain/util/duration_time.dart';

class VideoTimeText extends StatelessWidget {
  final void Function() onTap;
  final String timeText;

  const VideoTimeText({Key? key, required this.onTap, required this.timeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int timeSecond = formatTimeTextToSecond(timeText);
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Text(
        timeText,
        style: TextStyle(color: color.primary),
      ),
    );
  }
}
