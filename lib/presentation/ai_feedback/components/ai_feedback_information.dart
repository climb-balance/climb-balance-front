import 'package:climb_balance/domain/util/duration_time.dart';
import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/common/components/videos/video_time_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import 'ai_feedback_overlay.dart';
import 'ai_score.dart';

class AiFeedbackInformation extends ConsumerWidget {
  final int storyId;
  final VideoPlayerController videoPlayerController;

  const AiFeedbackInformation({
    Key? key,
    required this.storyId,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    final value = videoPlayerController.value;
    return Container(
      height: size.height * 0.6,
      width: size.width,
      color: color.background,
      child: DefaultTabController(
        length: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            AiInformationActionBar(storyId: storyId),
            const AiInformationTabBar(),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AiScore(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '1',
                              style: text.headline4,
                            ),
                            VideoTimeTextWithAnimation(
                              videoPlayerController: videoPlayerController,
                              storyId: storyId,
                              timeText: '00:10',
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
                                animationValue:
                                    formatTimeTextToSecond('00:10') /
                                        value.duration.inSeconds,
                                perFrameScore: ref.watch(
                                  aiFeedbackViewModelProvider(storyId)
                                      .select((value) => value.perFrameScore),
                                ),
                                joints: ref.watch(
                                    aiFeedbackViewModelProvider(storyId)
                                        .select((value) => value.joints)),
                                frames: ref.watch(
                                    aiFeedbackViewModelProvider(storyId)
                                        .select((value) => value.frames)),
                                lineOverlay: true,
                                squareOverlay: true,
                                squareOpacity: 0.2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text('sd'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoTimeTextWithAnimation extends ConsumerWidget {
  final String timeText;

  const VideoTimeTextWithAnimation({
    Key? key,
    required this.videoPlayerController,
    required this.storyId,
    required this.timeText,
  }) : super(key: key);

  final VideoPlayerController videoPlayerController;
  final int storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VideoTimeText(
      timeText: timeText,
      onTap: () {
        int timeSecond = formatTimeTextToSecond(timeText);
        videoPlayerController.seekTo(Duration(seconds: timeSecond));
        ref
            .read(aiFeedbackViewModelProvider(storyId).notifier)
            .seekAnimation(Duration(seconds: timeSecond));
      },
    );
  }
}

class AiInformationActionBar extends ConsumerWidget {
  const AiInformationActionBar({
    Key? key,
    required this.storyId,
  }) : super(key: key);

  final int storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.surface,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              ref
                  .read(aiFeedbackViewModelProvider(storyId).notifier)
                  .toggleInformation();
            },
            icon: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class AiInformationTabBar extends StatelessWidget {
  const AiInformationTabBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      color: color.surface,
      child: TabBar(
        indicatorColor: color.primary,
        labelPadding: EdgeInsets.all(10),
        tabs: [Text('점수'), Text('분석'), Text('통계')],
      ),
    );
  }
}
