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
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(5),
      child: InkWell(
        splashColor: color.surfaceVariant,
        onTap: () {
          // TODO named push not working
          context.push(
            '/diary/story/${story.storyId}',
          );
        },
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: color.errorContainer,
                    child: Icon(
                      Icons.error,
                      color: color.error,
                    ),
                  ),
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      color: color.surface,
                      child: Transform.scale(
                        scale: 0.5,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
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
