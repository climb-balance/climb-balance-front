import 'dart:math';

import 'package:climb_balance/services/server_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../../../utils/durations.dart';
import '../../../theme/specific_theme.dart';
import '../../../widgets/commons/stars.dart';

class AiFeedback extends StatefulWidget {
  const AiFeedback({Key? key}) : super(key: key);

  @override
  State<AiFeedback> createState() => _AiFeedbackState();
}

class _AiFeedbackState extends State<AiFeedback> {
  late final VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ServerService.tmpStoryVideo(1, isAi: true)
      ..initialize().then((value) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
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
            Container(
              width: size.width,
              height: size.width,
              child: _controller.value.isInitialized
                  ? Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
            if (_controller.value.isInitialized)
              AiFeedbackProgressBar(
                controller: _controller,
              ),
            const AiFeedbackInformation(),
          ],
        ),
      ),
    );
  }
}

class AiFeedbackInformation extends StatelessWidget {
  const AiFeedbackInformation({Key? key}) : super(key: key);

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
          children: const [
            AiFeedbackScore(),
            Text('00:43~00:58 구간에서 특히 자세가 나빴습니다.')
          ],
        ),
      ),
    );
  }
}

class AiFeedbackProgressBar extends StatefulWidget {
  VideoPlayerController controller;

  AiFeedbackProgressBar({Key? key, required this.controller}) : super(key: key);

  @override
  State<AiFeedbackProgressBar> createState() => _AiFeedbackProgressBarState();
}

class _AiFeedbackProgressBarState extends State<AiFeedbackProgressBar> {
  double progress = 0.0;
  String progressText = "00:00";
  final List<Color> colors = [
    Colors.grey,
    Colors.red,
    Colors.green,
    Colors.green,
    Colors.green,
    Colors.grey,
    Colors.red,
    Colors.red,
    Colors.red,
    Colors.grey,
  ];

  @override
  void initState() {
    super.initState();
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
    final Random random = Random();

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
  const AiFeedbackScore({Key? key}) : super(key: key);

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
              numOfStar: 4,
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
              numOfStar: 7,
            ),
          ],
        ),
      ],
    );
  }
}
