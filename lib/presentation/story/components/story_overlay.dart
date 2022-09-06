import 'package:climb_balance/common/const/route_config.dart';
import 'package:climb_balance/presentation/story/story_event.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/util/feedback_status.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../../ui/widgets/user_profile_info.dart';
import '../story_view_model.dart';
import 'progress_bar.dart';
import 'story_overlay_appbar.dart';
import 'story_overlay_feedback_request_sheet.dart';

class StoryOverlay extends ConsumerWidget {
  final VideoPlayerController videoPlayerController;
  final void Function() toggleCommentOpen;
  final int storyId;

  const StoryOverlay({
    Key? key,
    required this.videoPlayerController,
    required this.toggleCommentOpen,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref.watch(storyViewModelProvider(storyId));
    return GestureDetector(
      onTapUp: (_) {
        if (!videoPlayerController.value.isInitialized) return;
        videoPlayerController.value.isPlaying
            ? videoPlayerController.pause()
            : videoPlayerController.play();
      },
      child: Scaffold(
        floatingActionButton: StoryButtons(
          storyId: storyId,
          toggleCommentOpen: toggleCommentOpen,
        ),
        floatingActionButtonLocation: CustomFabLoc(),
        backgroundColor: Colors.transparent,
        appBar: StoryOverlayAppBar(
          tags: story.tags,
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
  final void Function() toggleCommentOpen;
  final int storyId;

  const StoryButtons({
    Key? key,
    required this.toggleCommentOpen,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUserId = ref.watch(userProvider.select((value) => value.userId));
    final story = ref.watch(storyViewModelProvider(storyId));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (curUserId == curUserId && story.aiStatus == FeedbackStatus.complete)
          TextButton(
            onPressed: () {
              context.push(aiPageSubRoute);
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
            ref
                .read(storyViewModelProvider(storyId).notifier)
                .onEvent(const StoryEvent.likeStory());
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
            (story.aiStatus == FeedbackStatus.possible ||
                story.expertStatus == FeedbackStatus.possible))
          TextButton(
            onPressed: () {
              showModalBottomSheet(
                enableDrag: true,
                context: context,
                builder: (context) => StoryOverlayFeedbackRequestSheet(
                  storyId: storyId,
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
