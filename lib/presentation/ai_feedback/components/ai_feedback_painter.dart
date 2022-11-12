import 'package:climb_balance/domain/util/ai_score_avg.dart';
import 'package:climb_balance/presentation/ai_feedback/models/ai_score_per_frame.dart';
import 'package:flutter/material.dart';

class AiFeedbackOverlayPainter extends CustomPainter {
  final double animationValue;
  final AiScorePerFrame perFrameScore;
  final List<double?> joints;
  final int frames;
  final bool lineOverlay;
  final bool squareOverlay;
  final List<int> rightIndexes = [14, 16, 18, 20, 22, 24];
  final List<int> leftIndexes = [2, 4, 6, 8, 10, 12];
  final List<int> rlPair1Indexes = [6, 18];
  final List<int> rlPair2Indexes = [8, 20];
  final List<int> drawQuadIndexes = [2, 12, 14, 24];
  final double squareOpacity;
  final int jointsLength = 26;

  AiFeedbackOverlayPainter({
    required this.animationValue,
    required this.perFrameScore,
    required this.joints,
    required this.frames,
    required this.lineOverlay,
    required this.squareOverlay,
    this.squareOpacity = 0.5,
  });

  final Paint linePaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;
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

  Offset? makeOffset(List<double?> vals) {
    if (vals[0] == null || vals[1] == null) return null;
    return Offset(vals[0]!, vals[1]!);
  }

  bool triangleCCW(Offset a, Offset b, Offset c) {
    double val = (a.dy - b.dy) * (c.dx - a.dx) + (b.dx - a.dx) * (c.dy - a.dy);
    if (val.abs() < 1e-7) throw Error;
    return val >= 0;
  }

  List<Offset>? hull(Offset a, Offset b, Offset c, Offset d) {
    late bool abc, abd, bcd, cad;
    try {
      abc = triangleCCW(a, b, c);
      abd = triangleCCW(a, b, d);
      bcd = triangleCCW(b, c, d);
      cad = triangleCCW(c, a, d);
    } catch (_) {
      return null;
    }

    int cntSamesign = 0;
    if (abc == abd) cntSamesign += 1;
    if (abc == bcd) cntSamesign += 1;
    if (abc == cad) cntSamesign += 1;

    if (cntSamesign == 3) {
      return [a, b, c];
    } else if (cntSamesign == 2) {
      if (abc != abd) {
        return [a, d, b, c];
      } else if (abc != bcd) {
        return [a, b, d, c];
      } else {
        return [a, b, c, d];
      }
    } else if (cntSamesign > 0) {
      if (abc == abd) {
        return [a, b, d];
      } else if (abc == bcd) {
        return [b, c, d];
      } else if (abc == cad) {
        return [c, a, d];
      }
    } else {
      return null;
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
      ..color = HSVColor.fromAHSV(1, 255 * (currentScore!), 1, 1)
          .toColor()
          .withOpacity(squareOpacity)
      ..style = PaintingStyle.fill;
    Offset a, b, c, d;
    try {
      a = makeOffset(values.sublist(lineIndexes[0], lineIndexes[0] + 2))!;
      b = makeOffset(values.sublist(lineIndexes[1], lineIndexes[1] + 2))!;
      c = makeOffset(values.sublist(lineIndexes[2], lineIndexes[2] + 2))!;
      d = makeOffset(values.sublist(lineIndexes[3], lineIndexes[3] + 2))!;
    } catch (_) {
      return;
    }
    List<Offset>? drawValues = hull(a, b, c, d);
    if (drawValues == null) return;
    if (drawValues.length == 3) {
      drawValues.add(drawValues[0]);
    }
    drawValues = drawValues
        .map((e) => Offset(e.dx * size.width, e.dy * size.height))
        .toList();

    canvas.drawPath(
      Path()..addPolygon(drawValues, true),
      quadPaint,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    int currentFrame = (animationValue * frames).toInt();
    int currentIdx = currentFrame * jointsLength;
    if (currentIdx + jointsLength >= joints.length) return;
    List<double?> currentJoints =
        joints.sublist(currentIdx, currentIdx + jointsLength + 1);

    if (lineOverlay) {
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
      for (int i = 0; i < currentJoints.length - 2; i += 2) {
        if (currentJoints[i] == null || currentJoints[i + 1] == null) continue;
        canvas.drawCircle(
          Offset(
            currentJoints[i]! * size.width,
            currentJoints[i + 1]! * size.height,
          ),
          3,
          circlePaint,
        );
      }
    }

    final score =
        perFrameScoreAvg(aiScorePerFrame: perFrameScore, idx: currentFrame);
    if (score == null || !squareOverlay) {
      return;
    }
    drawQuad(
      size: size,
      canvas: canvas,
      values: currentJoints,
      lineIndexes: drawQuadIndexes,
      currentScore: score,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class AiFeedbackScorePainter extends CustomPainter {
  final double animationValue;
  final AiScorePerFrame perFrameScore;
  final int frames;

  AiFeedbackScorePainter({
    required this.animationValue,
    required this.perFrameScore,
    required this.frames,
  });

  final Paint linePaint = Paint()
    ..color = Colors.green.withOpacity(0.5)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    int currentFrame = (animationValue * frames).toInt();
    final accuracy = perFrameScore.accuracy[currentFrame];
    final angle = perFrameScore.angle[currentFrame];
    final balance = perFrameScore.balance[currentFrame];
    final inertia = perFrameScore.inertia[currentFrame];
    final moment = perFrameScore.moment[currentFrame];
    if (accuracy != null) {
      canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(accuracy * 20, 20)),
        linePaint,
      );
    }
    if (angle != null) {
      canvas.drawRect(
        Rect.fromPoints(Offset(0, 30), Offset(angle * 20, 50)),
        linePaint,
      );
    }
    if (balance != null) {
      canvas.drawRect(
        Rect.fromPoints(Offset(0, 60), Offset(balance * 20, 80)),
        linePaint,
      );
    }
    if (inertia != null) {
      canvas.drawRect(
        Rect.fromPoints(Offset(0, 90), Offset(inertia * 20, 110)),
        linePaint,
      );
    }
    if (moment != null) {
      canvas.drawRect(
        Rect.fromPoints(Offset(0, 120), Offset(moment * 20, 140)),
        linePaint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
