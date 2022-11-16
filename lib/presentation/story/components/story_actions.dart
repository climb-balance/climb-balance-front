import 'package:climb_balance/domain/const/route_name.dart';
import 'package:climb_balance/presentation/story/components/story_overlay_feedback_request_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../domain/common/current_user_provider.dart';
import '../../../domain/util/feedback_status.dart';
import '../../common/components/my_icons.dart';
import '../story_view_model.dart';

class StoryActions extends ConsumerWidget {
  final int storyId;
  static const double iconSize = 28;
  final VideoPlayerController videoPlayerController;

  const StoryActions({
    Key? key,
    required this.storyId,
    required this.videoPlayerController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUserId =
        ref.watch(currentUserProvider.select((value) => value.userId));
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));
    final toggleCommentOpen =
        ref.read(storyViewModelProvider(storyId).notifier).toggleCommentOpen;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // TODO fix
        if (curUserId == story.uploaderId &&
            story.aiStatus == FeedbackStatus.complete)
          TextButton(
            onPressed: () {
              // TODO named로
              videoPlayerController.pause();
              context
                  .pushNamed(aiFeedbackRouteName, params: {'sid': '$storyId'});
            },
            child: const ColIconDetail(
              iconSize: iconSize,
              detail: 'ai',
              icon: Icons.animation,
            ),
          ),
        // TODO 다시 살리기
        // TextButton(
        //   onPressed: () {
        //     ref.read(storyViewModelProvider(storyId).notifier).likeStory();
        //   },
        //   child: ColIconDetail(
        //     iconSize: iconSize,
        //     icon: Icons.thumb_up,
        //     detail: '${story.likes}',
        //   ),
        // ),
        TextButton(
          onPressed: toggleCommentOpen,
          child: ColIconDetail(
            iconSize: iconSize,
            icon: Icons.comment,
            detail: '${story.comments}',
          ),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(storyViewModelProvider(storyId).notifier)
                .saveAndShare(context);
          },
          child: const ColIconDetail(
            iconSize: iconSize,
            icon: Icons.share,
            detail: '공유',
          ),
        ),
        if (curUserId == story.uploaderId &&
            (story.aiStatus ==
                FeedbackStatus
                    .possible)) //  || story.expertStatus == FeedbackStatus.possible
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
            child: const ColIconDetail(
              iconSize: iconSize,
              icon: Icons.more,
              detail: '피드백',
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }
}
