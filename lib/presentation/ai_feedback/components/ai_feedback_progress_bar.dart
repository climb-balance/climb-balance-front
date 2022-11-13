import 'package:climb_balance/domain/util/ai_score_avg.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../ai_feedback_view_model.dart';
import '../models/ai_feedback_state.dart';

class AiFeedbackProgressBar extends ConsumerStatefulWidget {
  final int storyId;
  final VideoPlayerController videoPlayerController;

  const AiFeedbackProgressBar(
      {Key? key, required this.videoPlayerController, required this.storyId})
      : super(key: key);

  @override
  ConsumerState<AiFeedbackProgressBar> createState() =>
      _AiFeedbackProgressBarState();
}

class _AiFeedbackProgressBarState extends ConsumerState<AiFeedbackProgressBar> {
  double progress = 0.0;
  late final void Function() _listener;

  @override
  void initState() {
    super.initState();
    final value = widget.videoPlayerController.value;
    progress = value.position.inMilliseconds / value.duration.inMilliseconds;
    _listener = () {
      final value = widget.videoPlayerController.value;
      progress = value.position.inMilliseconds / value.duration.inMilliseconds;
      setState(() {});
    };
    widget.videoPlayerController.addListener(_listener);
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AiFeedbackState detail =
        ref.watch(aiFeedbackViewModelProvider(widget.storyId));
    final gradientColors = <Color>[];
    for (int i = 0; i < detail.frames; i += 1) {
      final score =
          perFrameScoreAvg(aiScorePerFrame: detail.perFrameScore, idx: i);
      if (score == null) {
        gradientColors.add(Colors.transparent);
      } else {
        gradientColors
            .add(HSVColor.fromAHSV(0.5, 125 * (score!), 1, 1).toColor());
      }
    }
    if (gradientColors.isEmpty) {
      gradientColors.add(Colors.transparent);
      gradientColors.add(Colors.transparent);
    }
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 5),
          child: Container(
            height: 5,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          left: size.width * (progress.isNaN ? 0 : progress),
          bottom: 3,
          duration: const Duration(
            milliseconds: 500,
          ),
          height: 10,
          width: 3,
          child: Container(
            decoration: BoxDecoration(
              boxShadow: kElevationToShadow[3],
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
