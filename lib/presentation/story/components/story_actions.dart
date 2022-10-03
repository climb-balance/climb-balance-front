import 'package:climb_balance/domain/const/route_name.dart';
import 'package:climb_balance/presentation/story/components/story_overlay_feedback_request_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/common/current_user_provider.dart';
import '../../../domain/util/feedback_status.dart';
import '../story_view_model.dart';

class StoryActions extends ConsumerWidget {
  final void Function() toggleCommentOpen;
  final int storyId;

  const StoryActions({
    Key? key,
    required this.toggleCommentOpen,
    required this.storyId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curUserId =
        ref.watch(currentUserProvider.select((value) => value.userId));
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (curUserId == curUserId && story.aiStatus == FeedbackStatus.waiting)
          TextButton(
            onPressed: () {
              // TODO named로
              context
                  .pushNamed(aiFeedbackRouteName, params: {'sid': '$storyId'});
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
            ref.read(storyViewModelProvider(storyId).notifier).likeStory();
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
