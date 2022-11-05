import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../data/repository/story_repository_impl.dart';
import '../../domain/model/result.dart';
import '../../domain/model/story.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/story_repository.dart';
import '../../domain/util/feedback_status.dart';
import '../../domain/util/stories_filter.dart';
import 'models/diary_state.dart';

final diaryViewModelProvider =
    StateNotifierProvider.autoDispose<DiaryViewModel, DiaryState>((ref) {
  DiaryViewModel notifier =
      DiaryViewModel(ref.watch(storyRepositoryImplProvider), ref);
  notifier.loadStories();
  return notifier;
});

class DiaryViewModel extends StateNotifier<DiaryState> {
  List<Story> stories = [];
  final StoryRepository repository;
  final AutoDisposeStateNotifierProviderRef<DiaryViewModel, DiaryState> ref;

  DiaryViewModel(this.repository, this.ref) : super(const DiaryState());

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

  String getThumbnailUrl(int storyId) {
    return repository.getStoryThumbnailPath(storyId);
  }

  String _makeStoryKey(Story story) {
    return (story.tags.videoTimestamp ~/ (86400 * 1000)).toString() +
        story.tags.location.toString();
  }

  void onEditMode() {
    final User user = ref.watch(currentUserProvider).copyWith();
    state = state.copyWith(
      editingProfile: user,
      isEditingMode: true,
    );
  }

  void updateDescription(String description) {
    state = state.copyWith(
      editingProfile: state.editingProfile?.copyWith(description: description),
    );
  }

  void updateNickname(String nickname) {
    state = state.copyWith(
      editingProfile: state.editingProfile?.copyWith(nickname: nickname),
    );
  }

  void updateProfileImagePath() async {
    KeepAliveLink link = ref.keepAlive();
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(
        editingProfile:
            state.editingProfile?.copyWith(profileImage: image!.path),
      );
    }
    link.close();
  }

  void endEditMode() {
    if (state.editingProfile != null) {
      final User user = state.editingProfile!.copyWith();
      ref.read(currentUserProvider.notifier).updateUserInfo(user);
    }

    state = state.copyWith(
      editingProfile: null,
      isEditingMode: false,
    );
  }
}
