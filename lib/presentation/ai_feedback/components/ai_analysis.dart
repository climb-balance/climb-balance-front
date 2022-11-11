import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/presentation/ai_feedback/components/pentagon_radar_chart.dart';
import 'package:climb_balance/presentation/ai_feedback/components/video_time_text_with_animation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../ai_feedback_view_model.dart';
import '../models/ai_score_state.dart';
import 'ai_feedback_overlay.dart';

class AnalysisTab extends StatefulWidget {
  const AnalysisTab({
    Key? key,
    required this.videoPlayerController,
    required this.storyId,
    required this.timestamps,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;
  final int storyId;
  final List<int> timestamps;

  @override
  State<AnalysisTab> createState() => _AnalysisTabState();
}

class _AnalysisTabState extends State<AnalysisTab> {
  CarouselController carouselController = CarouselController();
  int curPage = 0;

  void _nextPage() {
    if (curPage < widget.timestamps.length - 1) {
      curPage += 1;
      carouselController.nextPage();
      setState(() {});
    }
  }

  void _prevPage() {
    if (curPage > 0) {
      curPage -= 1;
      carouselController.previousPage();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canNext = curPage < widget.timestamps.length - 1;
    final bool canPrev = curPage > 0;
    final color = Theme.of(context).colorScheme;
    return Row(
      children: [
        IconButton(
          onPressed: _prevPage,
          color: canPrev ? color.onSurface : Colors.transparent,
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        Expanded(
          child: CarouselSlider(
            items: [
              for (int i = 0; i < widget.timestamps.length; i++)
                BadAnalysis(
                  videoPlayerController: widget.videoPlayerController,
                  storyId: widget.storyId,
                  timestamp: widget.timestamps[i],
                  num: i + 1,
                ),
            ],
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 9 / 16,
              viewportFraction: 1,
              enableInfiniteScroll: false,
              scrollPhysics: const NeverScrollableScrollPhysics(),
            ),
            carouselController: carouselController,
          ),
        ),
        IconButton(
          color: canNext ? color.onSurface : Colors.transparent,
          onPressed: _nextPage,
          icon: const Icon(Icons.navigate_next_rounded),
        ),
      ],
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          flex: 1,
          child: BadAnalysisTitle(
            num: num,
            text: text,
            videoPlayerController: videoPlayerController,
            storyId: storyId,
            timestamp: timestamp,
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
    required this.videoPlayerController,
    required this.storyId,
    required this.timestamp,
  }) : super(key: key);

  final int num;
  final TextTheme text;
  final VideoPlayerController videoPlayerController;
  final int storyId;
  final int timestamp;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    final value = videoPlayerController.value;
    final perFrameScore = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.perFrameScore));
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
              videoPlayerController: videoPlayerController,
              storyId: storyId,
              timestamp: timestamp,
            ),
          ],
        ),
        PentagonRadarChart(
          aiScoreState: AiScoreState.fromPerFrame(
            perFrameScore,
            timestamp ~/ value.duration.inMilliseconds,
          ),
          showText: false,
        ),
      ],
    );
  }
}
