import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/tag_selector_provider.dart';
import '../../../domain/model/story_tag.dart';
import '../../../domain/util/duration_time.dart';

class StoryTagInfo extends StatelessWidget {
  final StoryTags tags;

  const StoryTagInfo({Key? key, required this.tags}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.only(
        bottom: 40,
        left: 16,
        right: 16,
      ),
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            color.background,
            Colors.transparent,
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DateTag(
            date: DateTime.fromMillisecondsSinceEpoch(tags.videoTimestamp),
          ),
          SizedBox(
            width: 8,
          ),
          LocationTag(
            location: tags.location,
          ),
          SizedBox(
            width: 8,
          ),
          SuccessTag(success: tags.success),
          SizedBox(
            width: 8,
          ),
          DifficultyTag(
            difficulty: tags.difficulty,
          ),
        ],
      ),
    );
  }
}

class DateTag extends StatelessWidget {
  final DateTime date;

  const DateTag({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.calendar_today,
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          formatDatetimeToYYMMDD(date),
          style: text.bodyText1,
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
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final locationValue =
        ref.read(locationSelectorProvider.notifier).getSelector(location);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(
          Icons.location_on,
          size: 16,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          locationValue.name,
          style: text.subtitle2?.copyWith(height: 1.2),
        ),
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
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: difficultyValue.selectColors,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 12,
      ),
      child: Text(
        difficultyValue.name,
        style: text.bodyText1?.copyWith(
          color: difficultyValue.selectColors![0].computeLuminance() > 0.5
              ? Colors.black
              : Colors.white,
          shadows: [],
        ),
      ),
    );
  }
}

class SuccessTag extends StatelessWidget {
  final bool success;

  const SuccessTag({Key? key, required this.success}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: success
          ? [
              Icon(
                Icons.check_circle,
                color: color.primary,
                size: 16,
              ),
              Text(
                '성공',
                style: TextStyle(
                  color: color.primary,
                  height: 1.2,
                ),
              ),
            ]
          : [
              Icon(
                Icons.star,
                color: color.error,
                size: 16,
              ),
              Text(
                '실패',
                style: TextStyle(
                  color: color.error,
                  height: 1.2,
                ),
              ),
            ],
    );
  }
}
