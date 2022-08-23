import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

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
    _controller = VideoPlayerController.network(
        'http://15.164.163.153:3000/story/1/video?type=ai')
      ..initialize().then((value) {
        _controller.setLooping(true);
        _controller.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoryViewTheme(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(
                    _controller,
                  ),
                ),
              ),
            ),
            AiFeedbackProgressBar(),
            AiFeedbackInformation(),
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
          children: const [
            AiFeedbackScore(),
            Text('00:43~00:58 구간에서 특히 자세가 나빴습니다.')
          ],
        ),
      ),
    );
  }
}

class AiFeedbackProgressBar extends StatelessWidget {
  const AiFeedbackProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Random random = Random();
    final List<Color> colors = [];
    for (int i = 0; i < 10; i++) {
      int num = random.nextInt(6);
      if (num < 3) {
        colors.add(Colors.red);
      } else if (num < 5) {
        colors.add(Colors.green);
      } else {
        colors.add(Colors.black);
      }
    }
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
        Column(
          children: [
            Text('00:22'),
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
