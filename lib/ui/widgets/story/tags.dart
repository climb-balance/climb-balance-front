import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/tag.dart';
import '../../../providers/tags.dart';

class StoryTagInfo extends ConsumerWidget {
  final Tags tags;

  const StoryTagInfo({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refState = ref.watch(tagsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            DateTag(
              dateString: tags.getDateString(),
            ),
            SuccessTag(success: tags.success),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (tags.location != -1)
              LocationTag(location: refState.locations[tags.location + 1]),
            if (tags.difficulty != -1)
              DifficultyTag(
                  difficulty: refState.difficulties[tags.difficulty + 1]),
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
  final Location location;

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
  final Difficulty difficulty;

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
