import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/tag_selector_provider.dart';
import '../../../domain/model/story.dart';

class StoryPreview extends ConsumerWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref
        .watch(diaryViewModelProvider.notifier)
        .getThumbnailUrl(story.storyId);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.surfaceVariant,
        onTap: () {
          // TODO named push not working
          context.push(
            '/diary/story/${story.storyId}',
          );
        },
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(image)),
              ),
            ),
            StoryPreviewIcon(story: story)
          ],
        ),
      ),
    );
  }
}

class StoryPreviewIcon extends ConsumerWidget {
  final Story story;

  const StoryPreviewIcon({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficultyColor = ref
            .read(difficultySelectorProvider.notifier)
            .getSelector(story.tags.difficulty)
            .color ??
        Colors.white;
    return Stack(
      children: [
        Icon(
          Icons.bookmark,
          color: difficultyColor,
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: 6,
          ),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.white,
            ),
            child: Icon(
              story.tags.success ? Icons.check_circle : Icons.change_circle,
              size: 12,
            ),
          ),
        ),
      ],
    );
  }
}
