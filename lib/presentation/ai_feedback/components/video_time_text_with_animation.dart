import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/util/duration_time.dart';
import '../../common/components/videos/video_time_text.dart';
import '../ai_feedback_view_model.dart';

class VideoTimeTextWithAnimation extends ConsumerWidget {
  final int timestamp;

  const VideoTimeTextWithAnimation({
    Key? key,
    required this.videoPlayerController,
    required this.storyId,
    required this.timestamp,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;
  final int storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VideoTimeText(
      timeText: formatTimestampToMMSS(timestamp),
      onTap: () {
        videoPlayerController.seekTo(Duration(seconds: timestamp! ~/ 1000));
        ref
            .read(aiFeedbackViewModelProvider(storyId).notifier)
            .seekAnimation(Duration(seconds: timestamp! ~/ 1000));
      },
    );
  }
}
