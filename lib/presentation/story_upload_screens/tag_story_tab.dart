import 'package:climb_balance/presentation/story_upload_screens/story_upload_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../presentation/common/components/safe_area.dart';
import '../common/components/tags/tags.dart';

class TagStoryTab extends ConsumerWidget {
  const TagStoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final success = ref
        .watch(storyUploadViewModelProvider.select((value) => value.success));
    final date = ref.watch(
        storyUploadViewModelProvider.select((value) => value.videoTimestamp));
    final location = ref
        .watch(storyUploadViewModelProvider.select((value) => value.location));
    final difficulty = ref.watch(
        storyUploadViewModelProvider.select((value) => value.difficulty));
    final theme = Theme.of(context);
    return MySafeArea(
      child: Column(
        children: [
          Row(
            children: [
              const Text('실패/성공:'),
              Switch(
                value: success,
                onChanged: ref
                    .read(storyUploadViewModelProvider.notifier)
                    .updateSuccess,
              ),
            ],
          ),
          Row(
            children: [
              const Text('날짜:'),
              TextButton(
                onPressed: () {
                  ref
                      .read(storyUploadViewModelProvider.notifier)
                      .pickTimestamp(context);
                },
                child: DateTag(
                  date: DateTime.fromMillisecondsSinceEpoch(date),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('위치:'),
              TextButton(
                onPressed: () {
                  ref
                      .read(storyUploadViewModelProvider.notifier)
                      .pickLocation(context);
                },
                child: LocationTag(
                  location: location,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('난이도:'),
              TextButton(
                onPressed: () {
                  ref
                      .read(storyUploadViewModelProvider.notifier)
                      .pickDifficulty(context);
                },
                child: DifficultyTag(
                  difficulty: difficulty,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
