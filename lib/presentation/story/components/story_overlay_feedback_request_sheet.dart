import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/util/feedback_status.dart';
import '../../common/components/row_icon_detail.dart';
import '../story_view_model.dart';

class StoryOverlayFeedbackRequestSheet extends ConsumerWidget {
  final int storyId;

  const StoryOverlayFeedbackRequestSheet({Key? key, required this.storyId})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref
        .watch(storyViewModelProvider(storyId).select((value) => value.story));
    final notifier = ref.read(storyViewModelProvider(storyId).notifier);
    return ListView(
      shrinkWrap: true,
      children: [
        if (story.aiStatus == FeedbackStatus.possible)
          SizedBox(
            height: 60,
            child: TextButton(
              onPressed: () {
                notifier.requestAiFeedback(context);
              },
              child: const RowIconDetail(
                  icon: Icon(Icons.android), detail: 'AI 피드백 요청하기'),
            ),
          ),
        // if (story.expertStatus == FeedbackStatus.possible)
        //   SizedBox(
        //     height: 60,
        //     child: TextButton(
        //       onPressed: () {
        //         // TODO expert
        //         notifier.requestAiFeedback(context);
        //       },
        //       child: const RowIconDetail(
        //           icon: Icon(Icons.my_library_books), detail: '전문가 피드백 요청하기'),
        //     ),
        //   ),
      ],
    );
  }
}
