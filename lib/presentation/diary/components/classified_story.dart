import 'package:flutter/material.dart';

import '../../../../domain/model/story.dart';
import '../../story/components/story_preview.dart';
import 'classified_story_tags.dart';

class ClassifiedStories extends StatelessWidget {
  final List<Story> stories;

  const ClassifiedStories({Key? key, required this.stories}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            ClassifiedStoryTags(story: stories[0]),
            Container(
              decoration: BoxDecoration(
                color: color.surface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: GridView.count(
                crossAxisSpacing: 12,
                mainAxisSpacing: 8,
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children:
                    stories.map((story) => StoryPreview(story: story)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
