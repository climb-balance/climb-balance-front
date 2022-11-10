import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

class AiFeedbackOverlay extends ConsumerStatefulWidget {
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
  ConsumerState<AiFeedbackOverlay> createState() => _AiFeedbackOverlayState();
}

class _AiFeedbackOverlayState extends ConsumerState<AiFeedbackOverlay> {
  late final AnimationController? _animationController;
  late final void Function() _listener;

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
    ref
        .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
        .initAnimationController(_animationController!);
    _listener = () {
      final value = widget.videoPlayerController.value;
      final videoValue = value.position.inMicroseconds.toDouble() /
          value.duration.inMicroseconds;
      if (value.isPlaying) {
        _animationController?.forward(from: videoValue);
      } else {
        _animationController?.stop();
      }
    };
    widget.videoPlayerController.addListener(_listener);
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(() {});
    _animationController?.removeListener(_listener);
    ref
        .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
        .initAnimationController(null);
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
        return AspectRatio(
          aspectRatio: value.aspectRatio,
          child: CustomPaint(
            painter: AiFeedbackOverlayPainter(
              animationValue: _animationController!.value,
              scores: ref.watch(
                aiFeedbackViewModelProvider(widget.storyId)
                    .select((value) => value.scores),
              ),
              joints: ref.watch(aiFeedbackViewModelProvider(widget.storyId)
                  .select((value) => value.joints)),
              frames: ref.watch(aiFeedbackViewModelProvider(widget.storyId)
                  .select((value) => value.frames)),
              lineOverlay: ref.watch(aiFeedbackViewModelProvider(widget.storyId)
                  .select((value) => value.lineOverlay)),
              squareOverlay: ref.watch(
                  aiFeedbackViewModelProvider(widget.storyId)
                      .select((value) => value.squareOverlay)),
            ),
          ),
        );
      },
    );
  }
}

class AiFeedbackOverlayPainter extends CustomPainter {
  final double animationValue;
  final List<double?> scores;
  final List<double?> joints;
  final int frames;
  final bool lineOverlay;
  final bool squareOverlay;
  final List<int> rightIndexes = [20, 16, 12, 24, 28, 32];
  final List<int> leftIndexes = [18, 14, 10, 22, 26, 30];
  final List<int> rlPair1Indexes = [10, 12];
  final List<int> rlPair2Indexes = [22, 24];
  final List<int> drawQuadIndexes = [18, 20, 30, 32];
  final double squareOpacity;

  AiFeedbackOverlayPainter({
    required this.animationValue,
    required this.scores,
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
      ..color = HSVColor.fromAHSV(1, 125 * (currentScore! * 0.5 + 0.5), 1, 1)
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
    int currentIdx = (animationValue * frames).toInt() * 34;
    if (currentIdx + 34 >= joints.length) return;
    List<double?> currentJoints = joints.sublist(currentIdx, currentIdx + 35);

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
      for (int i = 10; i < currentJoints.length - 2; i += 2) {
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

    if (scores[currentIdx ~/ 34] == null || !squareOverlay) {
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
