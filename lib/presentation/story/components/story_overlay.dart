import 'package:climb_balance/presentation/story/story_event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/model/story.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../../ui/pages/feedback_page/ai_feedback/ai_feedback.dart';
import '../../../ui/widgets/user_profile_info.dart';
import '../story_view_model.dart';
import 'progress_bar.dart';
import 'story_overlay_appbar.dart';
import 'story_overlay_feedback_request_sheet.dart';

class StoryOverlay extends ConsumerWidget {
  final VideoPlayerController videoPlayerController;
  final AutoDisposeStateNotifierProvider<StoryViewModel, Story> provider;
  final void Function() handleBack;
  final void Function() toggleCommentOpen;

  const StoryOverlay({
    Key? key,
    required this.provider,
    required this.handleBack,
    required this.videoPlayerController,
    required this.toggleCommentOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref.watch(provider);
    return GestureDetector(
      onTapUp: (_) {
        if (!videoPlayerController.value.isInitialized) return;
        videoPlayerController.value.isPlaying
            ? videoPlayerController.pause()
            : videoPlayerController.play();
      },
      child: Scaffold(
        floatingActionButton: StoryButtons(
          provider: provider,
          toggleCommentOpen: toggleCommentOpen,
        ),
        floatingActionButtonLocation: CustomFabLoc(),
        backgroundColor: Colors.transparent,
        appBar: StoryOverlayAppBar(
          tags: story.tags,
          handleBack: handleBack,
        ),
        body: SafeArea(
          minimum: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(story.description),
                  ],
                ),
              ),
              BottomUserProfile(
                userProfile: genRandomUser(),
                description: story.description,
              ),
            ],
          ),
        ),
        bottomNavigationBar: ProgressBar(
          videoPlayerController: videoPlayerController,
        ),
      ),
    );
  }
}

class CustomFabLoc extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    return Offset(
      scaffoldGeometry.scaffoldSize.width -
          scaffoldGeometry.floatingActionButtonSize.width,
      scaffoldGeometry.scaffoldSize.height -
          scaffoldGeometry.floatingActionButtonSize.height,
    );
  }
}

class StoryButtons extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<StoryViewModel, Story> provider;
  final void Function() toggleCommentOpen;

  const StoryButtons(
      {Key? key, required this.provider, required this.toggleCommentOpen})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUserId = ref.watch(userProvider.select((value) => value.userId));
    final story = ref.watch(provider);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (curUserId == curUserId && story.aiAvailable == 3)
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => AiFeedback(
                    story: story,
                  ),
                ),
              );
            },
            child: Column(
              children: const [
                Icon(
                  Icons.android,
                  size: 35,
                ),
              ],
            ),
          ),
        TextButton(
          onPressed: () {
            ref.read(provider.notifier).onEvent(const StoryEvent.likeStory());
          },
          child: Column(
            children: [
              const Icon(
                Icons.thumb_up,
                size: 35,
              ),
              Text('${story.likes}'),
            ],
          ),
        ),
        TextButton(
          onPressed: toggleCommentOpen,
          child: Column(
            children: [
              const Icon(
                Icons.comment,
                size: 35,
              ),
              Text('${story.comments}'),
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
        if (curUserId == curUserId &&
            (story.aiAvailable == 1 || story.expertAvailable == 1))
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                enableDrag: true,
                context: context,
                builder: (context) => StoryOverlayFeedbackRequestSheet(
                  provider: provider,
                ),
              );
            },
            child: Column(
              children: const [
                Icon(
                  Icons.more,
                  size: 35,
                ),
                Text('피드백'),
              ],
            ),
          ),
      ],
    );
  }
}
