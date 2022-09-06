import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/models/result.dart';
import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/story.dart';
import '../../domain/repository/story_repository.dart';
import '../../domain/util/feedback_status.dart';
import '../../domain/util/stories_filter.dart';
import 'diary_state.dart';

final diaryViewModelProvider =
    StateNotifierProvider.autoDispose<DiaryViewModel, DiaryState>((ref) {
  DiaryViewModel notifier =
      DiaryViewModel(ref.watch(storyRepositoryImplProvider));
  notifier.loadStories();
  return notifier;
});

class DiaryViewModel extends StateNotifier<DiaryState> {
  List<Story> stories = [];
  final StoryRepository repository;

  DiaryViewModel(this.repository) : super(const DiaryState());

  void loadStories() async {
    final Result<List<Story>> result = await repository.getStories();
    result.when(
      success: (getStories) {
        stories = getStories;
        filterStories(const StoriesFilter.noFilter());
      },
      error: (message) {},
    );
  }

  void filterStories(StoriesFilter storyFilter) {
    Map<String, List<Story>> classifiedStories = {};
    for (final story in stories) {
      final String key = _makeStoryKey(story);
      if (storyFilter == const StoriesFilter.aiOnly() &&
          story.aiStatus != FeedbackStatus.complete) {
        continue;
      } else if (storyFilter == const StoriesFilter.expertOnly() &&
          story.expertStatus != FeedbackStatus.complete) {
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
    return story.tags.videoTimestamp.toString() +
        story.tags.location.toString();
  }
}
