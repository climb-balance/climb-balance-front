import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../ai_feedback/models/ai_feedback_state.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/ai/sample.mp4');
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _videoPlayerController.value.isInitialized
            ? Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(
                          _videoPlayerController,
                        ),
                        AiFeedbackOverlay(
                          videoPlayerController: _videoPlayerController,
                          ticker: this,
                          storyId: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}

class AiFeedbackOverlay extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final TickerProviderStateMixin ticker;
  final int storyId;

  const AiFeedbackOverlay({
    Key? key,
    required this.videoPlayerController,
    required this.ticker,
    required this.storyId,
  }) : super(key: key);

  @override
  State<AiFeedbackOverlay> createState() => _AiFeedbackOverlayState();
}

class _AiFeedbackOverlayState extends State<AiFeedbackOverlay> {
  late final AnimationController? _animationController;
  AiFeedbackState _state = const AiFeedbackState();

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString("assets/ai/ai_overlay.json")
        .then((value) {
      _state = AiFeedbackState.fromJson(jsonDecode(value));
      setState(() {});
    });

    final value = widget.videoPlayerController.value;
    _animationController = AnimationController(
      vsync: widget.ticker,
      duration: value.duration,
    )
      ..forward()
      ..repeat();
    widget.videoPlayerController.addListener(() {
      final value = widget.videoPlayerController.value;
      final videoValue = value.position.inMicroseconds.toDouble() /
          value.duration.inMicroseconds;
      if (value.isPlaying) {
        _animationController?.forward(from: videoValue);
      } else {
        _animationController?.stop();
      }
    });
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(() {});
    _animationController?.removeListener(() {});
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final value = widget.videoPlayerController.value;
    if (_animationController == null) return Container();
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return InkWell(
          onTap: () {
            if (value.isPlaying) {
              widget.videoPlayerController
                  .pause()
                  .then((value) => _animationController?.stop());
            } else {
              _animationController?.forward();
              widget.videoPlayerController.play();
            }

            setState(() {});
          },
          child: Center(
            child: Container(
              width: size.width,
              height: size.width * (1 / value.aspectRatio),
              child: CustomPaint(
                painter: _Painter(
                  animationValue: _animationController!.value,
                  scores: _state.scores,
                  joints: _state.joints,
                  frames: _state.frames,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Painter extends CustomPainter {
  final double animationValue;
  final List<double?> scores;
  final List<double?> joints;
  final int frames;
  final List<int> rightIndexes = [20, 16, 12, 24, 28, 32];
  final List<int> leftIndexes = [18, 14, 10, 22, 26, 30];
  final List<int> rlPair1Indexes = [10, 12];
  final List<int> rlPair2Indexes = [22, 24];
  final List<int> drawQuadIndexes = [18, 20, 30, 32];

  _Painter({
    required this.animationValue,
    required this.scores,
    required this.joints,
    required this.frames,
  });

  final Paint linePaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  final Paint circlePaint = Paint()
    ..color = Colors.blue
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..style = PaintingStyle.fill;

  void drawNearLine({
    required Size size,
    required Canvas canvas,
    required List<double?> values,
    required List<int> lineIndexes,
  }) {
    for (int i = 0; i < lineIndexes.length - 1; i += 1) {
      if (values[lineIndexes[i]] == null ||
          values[lineIndexes[i + 1]] == null) {
        continue;
      }
      double x1 = values[lineIndexes[i]]! * size.width;
      double y1 = values[lineIndexes[i] + 1]! * size.height;
      double x2 = values[lineIndexes[i + 1]]! * size.width;
      double y2 = values[lineIndexes[i + 1] + 1]! * size.height;

      final Path path = Path()
        ..moveTo(x1, y1)
        ..lineTo(x2, y2);
      canvas.drawPath(path, linePaint);
    }
  }

  void drawQuad({
    required Size size,
    required Canvas canvas,
    required List<double?> values,
    required List<int> lineIndexes,
    required double? currentScore,
  }) {
    final Paint quadPaint = Paint()
      ..color = HSVColor.fromAHSV(0.5, 125 * (currentScore! * 0.5 + 0.5), 1, 1)
          .toColor()
      ..style = PaintingStyle.fill;
    double x1 = values[lineIndexes[0]]! * size.width;
    double y1 = values[lineIndexes[0] + 1]! * size.height;
    double x2 = values[lineIndexes[1]]! * size.width;
    double y2 = values[lineIndexes[1] + 1]! * size.height;
    double x3 = values[lineIndexes[2]]! * size.width;
    double y3 = values[lineIndexes[2] + 1]! * size.height;
    double x4 = values[lineIndexes[3]]! * size.width;
    double y4 = values[lineIndexes[3] + 1]! * size.height;
    canvas.drawPath(
      Path()
        ..addPolygon([
          Offset(x1, y1),
          Offset(x2, y2),
          Offset(x4, y4),
          Offset(x3, y3),
        ], true),
      quadPaint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    int currentIdx = (animationValue * frames).toInt() * 34;
    List<double?> currentJoints = joints.sublist(currentIdx, currentIdx + 35);

    /// draw lines
    drawNearLine(
      size: size,
      canvas: canvas,
      values: currentJoints,
      lineIndexes: rightIndexes,
    );
    drawNearLine(
      size: size,
      canvas: canvas,
      values: currentJoints,
      lineIndexes: leftIndexes,
    );
    drawNearLine(
      size: size,
      canvas: canvas,
      values: currentJoints,
      lineIndexes: rlPair1Indexes,
    );
    drawNearLine(
      size: size,
      canvas: canvas,
      values: currentJoints,
      lineIndexes: rlPair2Indexes,
    );

    /// draw circles
    /// 0~9는 머리이므로 제외
    for (int i = 10; i < currentJoints.length - 2; i += 2) {
      if (currentJoints[i] == null) continue;
      canvas.drawCircle(
        Offset(
          currentJoints[i]! * size.width,
          currentJoints[i + 1]! * size.height,
        ),
        5,
        circlePaint,
      );
    }
    if (scores[currentIdx ~/ 34] == null) {
      return;
    }
    drawQuad(
      size: size,
      canvas: canvas,
      values: currentJoints,
      lineIndexes: drawQuadIndexes,
      currentScore: scores[currentIdx ~/ 34],
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
