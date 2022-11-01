import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/common/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../common/components/my_icons.dart';
import 'ai_feedback_progress_bar.dart';

class AiFeedbackActions extends ConsumerWidget {
  final void Function() togglePlaying;
  final int storyId;
  final VideoPlayerController videoPlayerController;

  const AiFeedbackActions({
    Key? key,
    required this.storyId,
    required this.togglePlaying,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool lineOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.lineOverlay));
    final bool squareOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.squareOverlay));
    final bool isStatusChanging = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.isStatusChanging));
    return GestureDetector(
      onTap: togglePlaying,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: AiFeedbackProgressBar(
              storyId: storyId,
              controller: videoPlayerController,
            ),
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
                        .toggleLineOverlay();
                  },
                  child: ToggleIcon(
                    icon: Icons.edit_rounded,
                    isEnable: lineOverlay,
                    detail: '직선',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .toggleSquareOverlay();
                  },
                  child: ToggleIcon(
                    icon: Icons.filter,
                    isEnable: squareOverlay,
                    detail: '사각형',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Share.share(
                        '클라임 밸런스에서 다양한 클라이밍 영상과 AI 자세 분석, 맞춤 강습 매칭을 만나보세요!! https://climb-balance.com/video/123124');
                  },
                  child: const ColIconDetail(
                    icon: Icons.share,
                    detail: '공유',
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref
                        .read(aiFeedbackViewModelProvider(storyId).notifier)
                        .toggleInformation();
                  },
                  child: const ColIconDetail(
                    icon: Icons.mode_comment,
                    detail: '정보',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          AnimatedOpacity(
            opacity: isStatusChanging ? 0.5 : 0.0,
            duration: const Duration(milliseconds: 250),
            child: Center(
              child: videoPlayerController.value.isPlaying
                  ? Icon(
                      Icons.play_arrow,
                      size: 100,
                    )
                  : Icon(
                      Icons.pause,
                      size: 100,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
