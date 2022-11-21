import 'package:climb_balance/presentation/ai_feedback/components/pentagon_radar_chart.dart';
import 'package:climb_balance/presentation/ai_feedback/components/video_time_text_with_animation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../ai_feedback_view_model.dart';
import '../models/ai_score_state.dart';
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
        Flexible(
          flex: 1,
          child: BadAnalysisTitle(
            num: num,
            text: text,
            storyId: storyId,
            badPoint: badPoint,
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: AspectRatio(
              aspectRatio: videoPlayerController!.value!.aspectRatio!,
              child: CustomPaint(
                painter: AiFeedbackOverlayPainter(
                  animationValue: badPoint,
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
    final videoPlayerController = ref
        .read(aiFeedbackViewModelProvider(storyId).notifier)
        .betterPlayerController
        ?.videoPlayerController;
    int timestamp =
        (badPoint * videoPlayerController!.value!.duration!.inMilliseconds)
            .toInt();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num.toString(),
              style: text.headline4,
            ),
            VideoTimeTextWithAnimation(
              storyId: storyId,
              timestamp: timestamp,
            ),
          ],
        ),
        PentagonRadarChart(
          aiScoreState: AiScoreState.fromPerFrame(
            perFrameScore,
            timestamp,
          ),
          showText: false,
        ),
      ],
    );
  }
}
