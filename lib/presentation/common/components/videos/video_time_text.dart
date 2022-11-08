import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../domain/util/duration_time.dart';

class VideoTimeText extends StatelessWidget {
  final VideoPlayerController videoPlayerController;
  final String timeText;

  const VideoTimeText(
      {Key? key, required this.videoPlayerController, required this.timeText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int timeSecond = formatTimeTextToSecond(timeText);
    final color = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        videoPlayerController.seekTo(Duration(seconds: timeSecond));
      },
      child: Text(
        timeText,
        style: TextStyle(color: color.primary),
      ),
    );
  }
}
