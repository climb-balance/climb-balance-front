import 'package:climb_balance/services/server_service.dart';
import 'package:climb_balance/utils/durations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/result.dart';
import '../models/story.dart';

enum FilterType { noFilter, aiOnly, expertOnly }

class DiaryNotifier extends StateNotifier<List<List<Story>>> {
  late List<Story> stories;

  DiaryNotifier() : super([]);

  void loadStories() async {
    final Result<List<Story>> result = await ServerService().getUserStories();
    result.when(
        success: (stories) {
          filterStories(FilterType.noFilter);
        },
        error: (message) {},
        loading: () {});
  }

  void filterStories(FilterType filter) {
    Map<String, List<Story>> classifiedStories = {};
    for (final story in stories) {
      final String key = _makeStoryKey(story);
      if (filter == FilterType.aiOnly && story.aiAvailable != 2) {
        continue;
      } else if (filter == FilterType.expertOnly &&
          story.expertAvailable != 2) {
        continue;
      }
      if (classifiedStories.containsKey(key)) {
        classifiedStories[key]?.add(story);
      } else {
        classifiedStories[key] = [story];
      }
    }
    state = classifiedStories.values.toList();
  }

  String _makeStoryKey(Story story) {
    return formatDatetime(story.tags.videoDate) +
        story.tags.location.toString();
  }
}

final diaryProvider =
    StateNotifierProvider.autoDispose<DiaryNotifier, List<List<Story>>>((_) {
  DiaryNotifier notifier = DiaryNotifier();
  notifier.loadStories();
  return notifier;
});
