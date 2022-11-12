import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'ai_feedback_painter.dart';

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
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                painter: AiFeedbackOverlayPainter(
                  animationValue: _animationController!.value,
                  perFrameScore: ref.watch(
                    aiFeedbackViewModelProvider(widget.storyId).select(
                      (value) => value.perFrameScore,
                    ),
                  ),
                  joints: ref.watch(aiFeedbackViewModelProvider(widget.storyId)
                      .select((value) => value.joints)),
                  frames: ref.watch(aiFeedbackViewModelProvider(widget.storyId)
                      .select((value) => value.frames)),
                  lineOverlay: ref.watch(
                      aiFeedbackViewModelProvider(widget.storyId)
                          .select((value) => value.lineOverlay)),
                  squareOverlay: ref.watch(
                      aiFeedbackViewModelProvider(widget.storyId)
                          .select((value) => value.squareOverlay)),
                ),
              ),
              CustomPaint(
                painter: AiFeedbackScorePainter(
                  animationValue: _animationController!.value,
                  perFrameScore: ref.watch(
                    aiFeedbackViewModelProvider(widget.storyId).select(
                      (value) => value.perFrameScore,
                    ),
                  ),
                  frames: ref.watch(aiFeedbackViewModelProvider(widget.storyId)
                      .select((value) => value.frames)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
