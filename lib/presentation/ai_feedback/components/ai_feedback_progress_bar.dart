import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/util/duration_time.dart';
import '../models/ai_feedback_state.dart';

class AiFeedbackProgressBar extends StatefulWidget {
  final AiFeedbackState detail;
  final VideoPlayerController controller;

  const AiFeedbackProgressBar(
      {Key? key, required this.controller, required this.detail})
      : super(key: key);

  @override
  State<AiFeedbackProgressBar> createState() => _AiFeedbackProgressBarState();
}

class _AiFeedbackProgressBarState extends State<AiFeedbackProgressBar> {
  double progress = 0.0;
  String progressText = "00:00";
  late final List<Color> colors;

  @override
  void initState() {
    super.initState();
    colors = widget.detail.scores.map((val) {
      if (val == 0) {
        return Colors.grey;
      } else if (val == 1) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }).toList();
    setState(() {});
    widget.controller.addListener(() {
      final value = widget.controller.value;
      progress = value.position.inMilliseconds / value.duration.inMilliseconds;
      progressText = formatDuration(value.position).substring(3);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 5),
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: colors),
            ),
          ),
        ),
        AnimatedPositioned(
          left: size.width * progress,
          duration: Duration(
            seconds: 1,
          ),
          child: Column(
            children: [
              Text(
                progressText,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 12,
                  width: 3,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
