import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/story.dart';
import '../../../../providers/tag_selector_provider.dart';
import '../../../widgets/story/story.dart';

class ClassifiedStories extends StatelessWidget {
  final List<Story> stories;

  const ClassifiedStories({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClassifiedStoryTags(story: stories[0]),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:
                  stories.map((story) => StoryPreview(story: story)).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class ClassifiedStoryTags extends ConsumerWidget {
  final Story story;

  const ClassifiedStoryTags({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: theme.colorScheme.outline,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(Icons.date_range),
                Text(
                  story.tags.formatDatetime(),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                Text(
                  ref
                      .read(locationSelectorProvider.notifier)
                      .getLocationSelector(story.tags.location)
                      .name,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
