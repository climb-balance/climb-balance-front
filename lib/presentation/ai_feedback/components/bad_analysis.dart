import 'package:climb_balance/presentation/ai_feedback/components/video_time_text_with_animation.dart';
import 'package:climb_balance/presentation/ai_feedback/components/worst_score.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ai_feedback_view_model.dart';
import 'ai_feedback_painter.dart';

class BadAnalysis extends ConsumerWidget {
  const BadAnalysis({
    Key? key,
    required this.storyId,
    required this.badPoint,
    required this.num,
  }) : super(key: key);
  final double badPoint;
  final int storyId;
  final int num;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final videoPlayerController = ref
        .read(aiFeedbackViewModelProvider(storyId).notifier)
        .betterPlayerController
        ?.videoPlayerController;
    final perFrameScore = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.perFrameScore));
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        BadAnalysisTitle(
          num: num,
          text: text,
          storyId: storyId,
          badPoint: badPoint,
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            clipBehavior: Clip.hardEdge,
            child: AspectRatio(
              aspectRatio: videoPlayerController!.value!.aspectRatio!,
              child: CustomPaint(
                painter: AiFeedbackOverlayPainter(
                  animationValue: (badPoint *
                      1000 /
                      videoPlayerController.value.duration!.inMilliseconds),
                  perFrameScore: ref.watch(
                    aiFeedbackViewModelProvider(storyId)
                        .select((value) => value.perFrameScore),
                  ),
                  joints: ref.watch(aiFeedbackViewModelProvider(storyId)
                      .select((value) => value.joints)),
                  frames: ref.watch(aiFeedbackViewModelProvider(storyId)
                      .select((value) => value.frames)),
                  lineOverlay: true,
                  squareOverlay: true,
                  squareOpacity: 0.2,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BadAnalysisTitle extends ConsumerWidget {
  const BadAnalysisTitle({
    Key? key,
    required this.num,
    required this.text,
    required this.storyId,
    required this.badPoint,
  }) : super(key: key);

  final int num;
  final TextTheme text;
  final int storyId;
  final double badPoint;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final perFrameScore = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.perFrameScore));
    int timestamp = (badPoint * 1000).toInt();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            VideoTimeTextWithAnimation(
              storyId: storyId,
              timestamp: timestamp,
              primary: true,
            ),
          ],
        ),
        WorstScore(storyId: storyId, badPoint: badPoint),
      ],
    );
  }
}
