import 'package:better_player/better_player.dart';
import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'ai_feedback_painter.dart';

class AiFeedbackOverlay extends ConsumerStatefulWidget {
  final BetterPlayerController betterPlayerController;
  final int storyId;

  const AiFeedbackOverlay({
    Key? key,
    required this.betterPlayerController,
    required this.storyId,
  }) : super(key: key);

  @override
  ConsumerState<AiFeedbackOverlay> createState() => _AiFeedbackOverlayState();
}

class _AiFeedbackOverlayState extends ConsumerState<AiFeedbackOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController? _animationController;
  late final void Function() _listener;

  @override
  void initState() {
    super.initState();
    final value = widget.betterPlayerController.videoPlayerController!.value;
    _animationController = AnimationController(
      vsync: this,
      duration: value.duration,
    )
      ..forward()
      ..repeat();
    ref
        .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
        .initAnimationController(_animationController!);
    _listener = () {
      final value = widget.betterPlayerController.videoPlayerController!.value;
      final videoValue = value.position.inMicroseconds.toDouble() /
          value.duration!.inMicroseconds;
      if (value.isPlaying) {
        _animationController?.forward(from: videoValue);
      } else {
        _animationController?.stop();
      }
    };
    widget.betterPlayerController.videoPlayerController!.addListener(_listener);
    setState(() {});
  }

  @override
  void dispose() {
    widget.betterPlayerController.videoPlayerController!
        .removeListener(_listener);
    _animationController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final value = widget.betterPlayerController.videoPlayerController!.value;
    final scoreOverlay = ref.watch(aiFeedbackViewModelProvider(widget.storyId)
        .select((value) => value.scoreOverlay));
    final color = Theme.of(context).colorScheme;
    final perFrameScore = ref.watch(
      aiFeedbackViewModelProvider(widget.storyId).select(
        (value) => value.perFrameScore,
      ),
    );
    final frames = ref.watch(
      aiFeedbackViewModelProvider(widget.storyId).select(
        (value) => value.frames,
      ),
    );
    if (_animationController == null || frames == 0) {
      return AspectRatio(
        aspectRatio: value.aspectRatio,
        child: const SizedBox(),
      );
    }
    return AnimatedBuilder(
      animation: _animationController!,
      builder: (BuildContext context, Widget? child) {
        return ClipRect(
          child: AspectRatio(
            aspectRatio: value.aspectRatio,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(
                  painter: AiFeedbackOverlayPainter(
                    animationValue: _animationController!.value,
                    perFrameScore: perFrameScore,
                    joints: ref.watch(
                        aiFeedbackViewModelProvider(widget.storyId)
                            .select((value) => value.joints)),
                    frames: frames,
                    lineOverlay: ref.watch(
                        aiFeedbackViewModelProvider(widget.storyId)
                            .select((value) => value.lineOverlay)),
                    squareOverlay: ref.watch(
                        aiFeedbackViewModelProvider(widget.storyId)
                            .select((value) => value.squareOverlay)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
