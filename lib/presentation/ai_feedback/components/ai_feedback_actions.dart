import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/common/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../common/components/my_icons.dart';
import '../../common/components/videos/playing_status.dart';

class AiFeedbackActions extends ConsumerWidget {
  final void Function() togglePlaying;
  final int storyId;
  final VideoPlayerController videoPlayerController;
  final double iconSize;

  const AiFeedbackActions({
    Key? key,
    required this.storyId,
    required this.togglePlaying,
    required this.videoPlayerController,
    this.iconSize = 28,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool lineOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.lineOverlay));
    final bool squareOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.squareOverlay));
    final bool scoreOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.scoreOverlay));
    return GestureDetector(
      onTap: () {
        ref
            .read(aiFeedbackViewModelProvider(storyId).notifier)
            .toggleActionOpen(videoPlayerController.value.isPlaying);
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: BackIconButton(
                onPressed: () {
                  context.pop();
                },
              ),
              elevation: 0,
            ),
            backgroundColor: Colors.transparent,
            floatingActionButtonAnimator: NoFabScalingAnimation(),
            floatingActionButtonLocation: CustomFabLoc(),
            floatingActionButton: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .toggleScoreOverlay();
                  },
                  child: ToggleIcon(
                    icon: Icons.score,
                    isEnable: scoreOverlay,
                    detail: '점수',
                    iconSize: iconSize,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .toggleLineOverlay();
                  },
                  child: ToggleIcon(
                    icon: Icons.linear_scale,
                    isEnable: lineOverlay,
                    detail: '직선',
                    iconSize: iconSize,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .toggleSquareOverlay();
                  },
                  child: ToggleIcon(
                    icon: Icons.square_foot,
                    isEnable: squareOverlay,
                    detail: '사각형',
                    iconSize: iconSize,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .toggleInformation();
                  },
                  child: ColIconDetail(
                    icon: Icons.mode_comment,
                    detail: '정보',
                    iconSize: iconSize,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .saveAndShare();
                  },
                  child: ColIconDetail(
                    icon: Icons.share,
                    detail: '공유',
                    iconSize: iconSize,
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          PlayingStatus(
            togglePlaying: togglePlaying,
            videoPlayerController: videoPlayerController,
          ),
        ],
      ),
    );
  }
}
