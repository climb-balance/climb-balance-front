import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/provider/tag_selector_provider.dart';
import '../../../domain/model/story_tag.dart';
import '../../../domain/util/duration_time.dart';

class StoryTagInfo extends StatelessWidget {
  final StoryTags tags;

  const StoryTagInfo({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DateTag(
              date: DateTime.fromMillisecondsSinceEpoch(tags.videoTimestamp),
            ),
            SuccessTag(success: tags.success),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (tags.location != -1)
              LocationTag(
                location: tags.location,
              ),
            if (tags.difficulty != -1)
              DifficultyTag(
                difficulty: tags.difficulty,
              ),
          ],
        ),
      ],
    );
  }
}

class DateTag extends StatelessWidget {
  final DateTime date;

  const DateTag({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(Icons.calendar_today),
        Text(
          formatDatetimeToYYMMDD(date),
        ),
      ],
    );
  }
}

class LocationTag extends ConsumerWidget {
  final int location;

  const LocationTag({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationValue =
        ref.read(locationSelectorProvider.notifier).getSelector(location);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Icon(Icons.location_on),
        Text(locationValue.name),
      ],
    );
  }
}

class DifficultyTag extends ConsumerWidget {
  final int difficulty;

  const DifficultyTag({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficultyValue =
        ref.read(difficultySelectorProvider.notifier).getSelector(difficulty);
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.bookmark,
            color: difficultyValue.color,
          ),
          Text(
            difficultyValue.name,
            style: TextStyle(
              color: difficultyValue.color,
            ),
          ),
        ],
      ),
    );
  }
}

class SuccessTag extends StatelessWidget {
  final bool success;

  const SuccessTag({Key? key, required this.success}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: success
          ? [
              Icon(
                Icons.star,
                color: theme.colorScheme.primary,
              ),
              Text(
                '성공',
                style: TextStyle(color: theme.colorScheme.primary),
              )
            ]
          : [
              Icon(
                Icons.star_border,
                color: theme.colorScheme.tertiary,
              ),
              Text(
                '실패',
                style: TextStyle(
                  color: theme.colorScheme.tertiary,
                ),
              ),
            ],
    );
  }
}
