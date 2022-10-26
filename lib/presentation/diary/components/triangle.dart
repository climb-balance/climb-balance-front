import 'package:flutter/material.dart';

class TrainglePainter extends StatelessWidget {
  final Color color;

  const TrainglePainter({Key? key, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        35,
        35,
      ),
      painter: DrawTriangleShape(
        color: color,
      ),
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  late final Paint painter;
  final Color color;

  DrawTriangleShape({required this.color}) {
    painter = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
