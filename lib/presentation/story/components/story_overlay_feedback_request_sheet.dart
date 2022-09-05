import 'package:climb_balance/presentation/story/story_event.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/model/story.dart';
import '../../common/components/row_icon_detail.dart';
import '../story_view_model.dart';

class StoryOverlayFeedbackRequestSheet extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<StoryViewModel, Story> provider;

  const StoryOverlayFeedbackRequestSheet({Key? key, required this.provider})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final story = ref.watch(provider);
    return ListView(
      shrinkWrap: true,
      children: [
        if (story.aiAvailable == 1)
          SizedBox(
            height: 60,
            child: TextButton(
              onPressed: () {
                ref
                    .read(provider.notifier)
                    .onEvent(StoryEvent.requestAiFeedback(context));
              },
              child: const RowIconDetail(
                  icon: Icon(Icons.android), detail: 'AI 피드백 요청하기'),
            ),
          ),
        if (story.expertAvailable == 1)
          SizedBox(
            height: 60,
            child: TextButton(
              onPressed: () {
                ref
                    .read(provider.notifier)
                    .onEvent(StoryEvent.requestExpertFeedback(context));
              },
              child: const RowIconDetail(
                  icon: Icon(Icons.my_library_books), detail: '전문가 피드백 요청하기'),
            ),
          ),
      ],
    );
  }
}
