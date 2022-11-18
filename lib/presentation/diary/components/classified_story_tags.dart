import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/model/story.dart';
import '../../common/components/tags/tags.dart';

class ClassifiedStoryTags extends ConsumerWidget {
  final Story story;

  const ClassifiedStoryTags({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: color.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DateTag(
            date: DateTime.fromMillisecondsSinceEpoch(
              story.tags.videoTimestamp,
            ),
          ),
          LocationTag(location: story.tags.location),
        ],
      ),
    );
  }
}
