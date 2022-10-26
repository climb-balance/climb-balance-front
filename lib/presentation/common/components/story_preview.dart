import 'package:climb_balance/presentation/diary/components/triangle.dart';
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
    return InkWell(
      splashColor: color.surfaceVariant,
      onTap: () {
        // TODO named push not working
        context.push(
          '/diary/story/${story.storyId}',
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Stack(
          children: [
            AspectRatio(
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
            StoryPreviewIcon(story: story),
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
    final color = Theme.of(context).colorScheme;
    final difficultyColor = ref
            .read(difficultySelectorProvider.notifier)
            .getSelector(story.tags.difficulty)
            .color ??
        Colors.white;
    final success = story.tags.success;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TrainglePainter(
              color: difficultyColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 7,
                bottom: 3,
              ),
              child: Text(
                success ? 'SUCCESS' : 'FAILED',
                style: TextStyle(
                  color: success ? Colors.greenAccent : color.error,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
