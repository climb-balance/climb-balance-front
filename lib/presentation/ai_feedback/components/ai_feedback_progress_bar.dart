import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../ai_feedback_view_model.dart';
import '../models/ai_feedback_state.dart';

class AiFeedbackProgressBar extends ConsumerStatefulWidget {
  final int storyId;
  final VideoPlayerController controller;

  const AiFeedbackProgressBar(
      {Key? key, required this.controller, required this.storyId})
      : super(key: key);

  @override
  ConsumerState<AiFeedbackProgressBar> createState() =>
      _AiFeedbackProgressBarState();
}

class _AiFeedbackProgressBarState extends ConsumerState<AiFeedbackProgressBar> {
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      final value = widget.controller.value;
      progress = value.position.inMilliseconds / value.duration.inMilliseconds;
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AiFeedbackState detail =
        ref.watch(aiFeedbackViewModelProvider(widget.storyId));
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 5),
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: detail.scores.map((score) {
                  if (score == null) {
                    return Colors.transparent;
                  }
                  return HSVColor.fromAHSV(0.5, 125 * (score * 0.5 + 0.5), 1, 1)
                      .toColor();
                }).toList(),
              ),
            ),
          ),
        ),
        AnimatedPositioned(
          left: size.width * progress,
          bottom: 5,
          duration: Duration(
            milliseconds: 500,
          ),
          child: Container(
            height: 5,
            width: 5,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
