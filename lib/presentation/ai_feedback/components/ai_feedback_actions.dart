import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/common/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../common/components/my_icons.dart';

class AiFeedbackActions extends ConsumerWidget {
  final void Function() togglePlaying;
  final int storyId;

  const AiFeedbackActions({
    Key? key,
    required this.storyId,
    required this.togglePlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool lineOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.lineOverlay));
    final bool squareOverlay = ref.watch(aiFeedbackViewModelProvider(storyId)
        .select((value) => value.squareOverlay));
    return GestureDetector(
      onTap: togglePlaying,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
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
              onPressed: () {},
              child: const ColIconDetail(
                icon: Icons.mode_comment,
                detail: '정보',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
