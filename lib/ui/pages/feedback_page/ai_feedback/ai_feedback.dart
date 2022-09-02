import 'dart:math';

import 'package:climb_balance/models/ai_feedback_detail.dart';
import 'package:climb_balance/services/server_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../domain/model/story.dart';
import '../../../../utils/durations.dart';
import '../../../theme/specific_theme.dart';
import '../../../widgets/commons/stars.dart';

class AiFeedback extends StatefulWidget {
  final Story story;

  const AiFeedback({Key? key, required this.story}) : super(key: key);

  @override
  State<AiFeedback> createState() => _AiFeedbackState();
}

class _AiFeedbackState extends State<AiFeedback> {
  late final VideoPlayerController _controller;
  AiFeedbackDetail detail = const AiFeedbackDetail(value: [0]);

  @override
  void initState() {
    super.initState();

    final path =
        ServerService.getStoryVideoPath(widget.story.storyId!, isAi: true);
    debugPrint(path);
    _controller = VideoPlayerController.network(
      path,
      formatHint: VideoFormat.hls,
    )..initialize().then((value) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
    ServerService.getStoryAiDetail(widget.story.storyId!).then(
      (result) => result.when(
        success: (value) {
          detail = value;
          setState(() {});
        },
        error: (_) {},
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return StoryViewTheme(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _controller.value.isInitialized
                ? Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            if (_controller.value.isInitialized)
              Align(
                alignment: Alignment.bottomCenter,
                child: AiFeedbackProgressBar(
                  detail: detail,
                  controller: _controller,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class AiFeedbackInformation extends StatelessWidget {
  final AiFeedbackDetail detail;

  const AiFeedbackInformation({Key? key, required this.detail})
      : super(key: key);

  int longestGoodLength() {
    int maxLength = 0;
    int curLength = 0;
    for (int i = 0; i < detail.value.length; i++) {
      if (detail.value[i] == 1) {
        curLength += 1;
        maxLength = max(maxLength, curLength);
      } else {
        curLength = 0;
      }
    }

    return maxLength;
  }

  int goodCount() {
    int curLength = 0;
    for (int i = 0; i < detail.value.length; i++) {
      if (detail.value[i] == 1) {
        curLength += 1;
      }
    }
    return curLength;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      height: 150,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AiFeedbackScore(
                precision: longestGoodLength(), balance: goodCount()),
            Text('00:43~00:58 구간에서 특히 자세가 나빴습니다.')
          ],
        ),
      ),
    );
  }
}

class AiFeedbackProgressBar extends StatefulWidget {
  final AiFeedbackDetail detail;
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
    colors = widget.detail.value.map((val) {
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
          padding: EdgeInsets.only(top: 20, bottom: 10),
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

class AiFeedbackScore extends StatelessWidget {
  final int precision;
  final int balance;

  const AiFeedbackScore(
      {Key? key, required this.precision, required this.balance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          children: [
            Text(
              '밸런스',
              style: theme.textTheme.headline6,
            ),
            Stars(
              numOfStar: (precision / 5).toInt(),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              '유연성',
              style: theme.textTheme.headline6,
            ),
            Stars(
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
              numOfStar: (balance / 5).toInt(),
            ),
          ],
        ),
      ],
    );
  }
}
