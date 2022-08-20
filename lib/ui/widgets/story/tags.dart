import 'package:climb_balance/models/tag_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/story_tag.dart';
import '../../../providers/tag_selector_provider.dart';

class StoryTagInfo extends ConsumerWidget {
  final StoryTags tags;

  const StoryTagInfo({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getLocation =
        ref.read(locationSelectorProvider.notifier).getLocationSelector;
    final getDifficulty =
        ref.read(difficultySelectorProvider.notifier).getDifficultySelector;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DateTag(
              dateString: tags.formatDatetime(),
            ),
            SuccessTag(success: tags.success),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (tags.location != -1)
              LocationTag(location: getLocation(tags.location)),
            if (tags.difficulty != -1)
              DifficultyTag(difficulty: getDifficulty(tags.location)),
          ],
        ),
      ],
    );
  }
}

class DateTag extends StatelessWidget {
  final String dateString;

  const DateTag({Key? key, required this.dateString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(Icons.calendar_today),
        Text(dateString),
      ],
    );
  }
}

class LocationTag extends StatelessWidget {
  final LocationSelector location;

  const LocationTag({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(Icons.location_on),
        Text(location.name),
      ],
    );
  }
}

class DifficultyTag extends StatelessWidget {
  final DifficultySelector difficulty;

  const DifficultyTag({Key? key, required this.difficulty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.bookmark,
          color: difficulty.color,
        ),
        Text(
          difficulty.name,
          style: TextStyle(
            color: difficulty.color,
          ),
        ),
      ],
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
