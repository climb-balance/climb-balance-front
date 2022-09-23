import 'dart:math';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PoseTest extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final TickerProviderStateMixin ticker;
  final double aspectRatio;

  const PoseTest(
      {Key? key,
      required this.videoPlayerController,
      required this.aspectRatio,
      required this.ticker})
      : super(key: key);

  @override
  State<PoseTest> createState() => _PoseTestState();
}

class _PoseTestState extends State<PoseTest> {
  late final AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
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
        return Center(
          child: Container(
            width: size.width,
            height: size.width * (1 / widget.aspectRatio),
            child: CustomPaint(
              painter: _Painter(
                animationValue: _animationController!.value,
                context: context,
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
  final BuildContext context;

  _Painter({required this.animationValue, required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    final size = MediaQuery.of(context);
    Paint linePaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    Path path = Path();
    final radian = 20 * pi * animationValue;
    debugPrint('${cos(radian)}, ${sin(radian)}');
    double fromX = 200;
    double fromY = 110;
    double toX = cos(radian) * 100 + 200;
    double toY = sin(radian) * 100 + 110;
    path.moveTo(fromX, fromY);
    path.lineTo(toX, toY);
    path.close();
    canvas.drawPath(path, linePaint);
    canvas.drawCircle(Offset(fromX, fromY), 5, circlePaint);
    canvas.drawCircle(Offset(toX, toY), 5, circlePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
