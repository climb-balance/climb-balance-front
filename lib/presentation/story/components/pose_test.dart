import 'dart:math';

import 'package:flutter/material.dart';

class PoseTest extends StatefulWidget {
  final AnimationController? animationController;
  final double aspectRatio;

  const PoseTest(
      {Key? key, required this.animationController, required this.aspectRatio})
      : super(key: key);

  @override
  State<PoseTest> createState() => _PoseTestState();
}

class _PoseTestState extends State<PoseTest> {
  @override
  Widget build(BuildContext context) {
    debugPrint(widget.aspectRatio.toString());
    final size = MediaQuery.of(context).size;
    if (widget.animationController == null) {
      return Container();
    }
    return AnimatedBuilder(
      animation: widget.animationController!,
      builder: (BuildContext context, Widget? child) {
        return Center(
          child: Container(
            width: size.width,
            height: size.width * (1 / widget.aspectRatio),
            child: CustomPaint(
              painter:
                  _Painter(animationValue: widget.animationController!.value),
            ),
          ),
        );
      },
    );
  }
}

class _Painter extends CustomPainter {
  final double animationValue;

  _Painter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    double heightParameter = 30;
    double periodParameter = 0.5;

    Paint linePaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    Paint circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    final random = Random();
    for (int i = 0; i < 17; i++) {
      Path path = Path();

      double fromX = random.nextDouble() * 500;
      double fromY = 10.0 * i;
      double toX = random.nextDouble() * 500;
      double toY = 20.0 * i;
      path.moveTo(fromX, fromY);
      path.lineTo(toX, toY);
      path.close();
      canvas.drawPath(path, linePaint);
      canvas.drawCircle(Offset(fromX, fromY), 5, circlePaint);
      canvas.drawCircle(Offset(toX, toY), 5, circlePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
