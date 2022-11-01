import 'package:flutter/material.dart';

class TrainglePainter extends StatelessWidget {
  final List<Color> colors;

  const TrainglePainter({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(
        35,
        35,
      ),
      painter: DrawTriangleShape(
        colors: colors,
      ),
    );
  }
}

class DrawTriangleShape extends CustomPainter {
  late final Paint painter;
  final List<Color> colors;

  DrawTriangleShape({required this.colors}) {
    painter = Paint()
      ..shader = LinearGradient(
        colors: colors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & Size(35, 35))
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);

    path.lineTo(0, 0);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
