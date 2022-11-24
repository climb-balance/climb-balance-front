import 'package:flutter/material.dart';

class VideoTimeText extends StatelessWidget {
  final void Function() onTap;
  final String timeText;
  final bool primary;

  const VideoTimeText({
    Key? key,
    required this.onTap,
    required this.timeText,
    required this.primary,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Text(
        timeText,
        style: primary
            ? text.headline5?.copyWith(color: color.primary)
            : TextStyle(color: color.primary),
      ),
    );
  }
}
