import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/presentation/ai_feedback/components/pentagon_radar_chart.dart';
import 'package:climb_balance/presentation/ai_feedback/components/video_time_text_with_animation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../ai_feedback_view_model.dart';
import '../models/ai_score_state.dart';
import 'ai_feedback_overlay.dart';

class AnalysisTab extends StatelessWidget {
  const AnalysisTab({
    Key? key,
    required this.videoPlayerController,
    required this.storyId,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;
  final int storyId;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        BadAnalysis(
          videoPlayerController: videoPlayerController,
          storyId: storyId,
          timestamp: 15000,
          num: 1,
        ),
        BadAnalysis(
          videoPlayerController: videoPlayerController,
          storyId: storyId,
          timestamp: 15000,
          num: 2,
        ),
      ],
      options: CarouselOptions(
        aspectRatio: 1,
        viewportFraction: 1,
      ),
    );
  }
}

class BadAnalysis extends ConsumerWidget {
  const BadAnalysis({
    Key? key,
    required this.videoPlayerController,
    required this.storyId,
    required this.timestamp,
    required this.num,
  }) : super(key: key);
  final int timestamp;
  final VideoPlayerController videoPlayerController;
  final int storyId;
  final int num;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final value = videoPlayerController.value;
    final perFrameScore = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.perFrameScore));
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              num.toString(),
              style: text.headline4,
            ),
            VideoTimeTextWithAnimation(
              videoPlayerController: videoPlayerController,
              storyId: storyId,
              timestamp: timestamp,
            ),
            Container(
              width: 100,
              height: 100,
              child: PentagonRadarChart(
                aiScoreState: AiScoreState.fromPerFrame(
                  perFrameScore,
                  timestamp ~/ value.duration.inMilliseconds,
                ),
                showText: false,
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: color.surface,
            borderRadius: BorderRadius.circular(8),
          ),
          child: AspectRatio(
            aspectRatio: value.aspectRatio,
            child: CustomPaint(
              painter: AiFeedbackOverlayPainter(
                animationValue: timestamp / value.duration.inMilliseconds,
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
      ],
    );
  }
}
