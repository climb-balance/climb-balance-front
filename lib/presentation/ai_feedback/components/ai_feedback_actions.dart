import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:climb_balance/presentation/common/custom_fab.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

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
          title: Text('asd'),
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
              child: Column(
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.border_color,
                        size: 35,
                      ),
                      if (lineOverlay)
                        Icon(
                          Icons.close,
                          size: 35,
                        ),
                    ],
                  ),
                  Text('직선'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(aiFeedbackViewModelProvider(storyId).notifier)
                    .toggleSquareOverlay();
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Icon(
                        Icons.filter,
                        size: 35,
                      ),
                      if (squareOverlay)
                        Icon(
                          Icons.close,
                          size: 35,
                        ),
                    ],
                  ),
                  Text('사각형'),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                Share.share(
                    '클라임 밸런스에서 다양한 클라이밍 영상과 AI 자세 분석, 맞춤 강습 매칭을 만나보세요!! https://climb-balance.com/video/123124');
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.share,
                    size: 35,
                  ),
                  Text('공유'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
