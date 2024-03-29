import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/util/duration_time.dart';
import '../../common/components/videos/video_time_text.dart';
import '../ai_feedback_view_model.dart';

class VideoTimeTextWithAnimation extends ConsumerWidget {
  const VideoTimeTextWithAnimation({
    Key? key,
    required this.storyId,
    required this.timestamp,
    required this.primary,
  }) : super(key: key);

  final int timestamp;
  final int storyId;
  final bool primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final betterPlayerController = ref
        .read(aiFeedbackViewModelProvider(storyId).notifier)
        .betterPlayerController;
    return VideoTimeText(
      timeText: primary
          ? formatTimestampToMMSS(timestamp)
          : formatTimestampToSS(timestamp),
      onTap: () {
        betterPlayerController?.seekTo(Duration(seconds: timestamp! ~/ 1000));
        ref
            .read(aiFeedbackViewModelProvider(storyId).notifier)
            .seekAnimation(Duration(seconds: timestamp! ~/ 1000));
      },
      primary: primary,
    );
  }
}
