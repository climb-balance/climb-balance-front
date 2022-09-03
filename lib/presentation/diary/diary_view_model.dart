import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data_source/result.dart';
import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import '../../domain/util/durationTime.dart';
import '../../domain/util/stories_filter.dart';
import 'diary_event.dart';
import 'diary_state.dart';

final diaryViewModelProvider =
    StateNotifierProvider.autoDispose<DiaryViewModel, DiaryState>((ref) {
  DiaryViewModel notifier =
      DiaryViewModel(ref.watch(storyRepositoryImplProvider));
  notifier._loadStories();
  return notifier;
});

class DiaryViewModel extends StateNotifier<DiaryState> {
  List<Story> stories = [];
  final StoryRepository repository;

  DiaryViewModel(this.repository) : super(const DiaryState());

  void onEvent(DiaryEvent event) {
    event.when(
        filterStories: (StoriesFilter storyFilter) {
          _filterStories(storyFilter);
        },
        loadStories: _loadStories);
  }

  void _loadStories() async {
    final Result<List<Story>> result = await repository.getStories();
    result.when(
      success: (getStories) {
        stories = getStories;
        _filterStories(const StoriesFilter.noFilter());
      },
      error: (message) {},
    );
  }

  void _filterStories(StoriesFilter storyFilter) {
    Map<String, List<Story>> classifiedStories = {};
    for (final story in stories) {
      final String key = _makeStoryKey(story);
      if (storyFilter == const StoriesFilter.aiOnly() &&
          story.aiAvailable != 3) {
        continue;
      } else if (storyFilter == const StoriesFilter.expertOnly() &&
          story.expertAvailable != 3) {
        continue;
      }
      if (classifiedStories.containsKey(key)) {
        classifiedStories[key]?.add(story);
      } else {
        classifiedStories[key] = [story];
      }
    }
    state = state.copyWith(
        classifiedStories: classifiedStories.values.toList(),
        storyFilter: storyFilter);
  }

  String _makeStoryKey(Story story) {
    return formatDatetimeToYYMMDD(story.tags.videoDate) +
        story.tags.location.toString();
  }
}
