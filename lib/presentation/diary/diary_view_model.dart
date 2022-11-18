import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/domain/common/tag_selector_provider.dart';
import 'package:climb_balance/presentation/common/custom_dialog.dart';
import 'package:climb_balance/presentation/diary/enums/diary_filter_type.dart';
import 'package:climb_balance/presentation/diary/models/diary_filter.dart';
import 'package:flutter/cupertino.dart';
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
    StateNotifierProvider<DiaryViewModel, DiaryState>((ref) {
  DiaryViewModel notifier =
      DiaryViewModel(ref.watch(storyRepositoryImplProvider), ref);
  notifier.loadStories();
  return notifier;
});

class DiaryViewModel extends StateNotifier<DiaryState> {
  List<Story> stories = [];
  final StoryRepository repository;
  final StateNotifierProviderRef ref;

  DiaryViewModel(this.repository, this.ref) : super(const DiaryState());

  Future<void> loadStories() async {
    await ref.read(currentUserProvider.notifier).refreshUserInfo();
    final Result<List<Story>> result = await repository.getStories();
    result.when(
      success: (getStories) {
        stories = getStories;
        filterStories();
      },
      error: (message) {},
    );
  }

  void addAiFilter(StoriesFilter storyFilter) {
    state = state.copyWith(
      storyFilter: storyFilter,
    );
    filterStories();
  }

  bool _filterStory(Story story) {
    if (state.storyFilter == const StoriesFilter.aiOnly() &&
        story.aiStatus != FeedbackStatus.complete) {
      return false;
    } else if (state.storyFilter == const StoriesFilter.expertOnly() &&
        story.expertStatus != FeedbackStatus.complete) {
      return false;
    }
    for (final filter in state.diaryFilters) {
      if (!filter.validator(story)) {
        return false;
      }
    }
    return true;
  }

  void filterStories() {
    Map<String, List<Story>> classifiedStories = {};
    for (final story in stories) {
      if (!_filterStory(story)) continue;
      final String key = _makeStoryKey(story);

      if (classifiedStories.containsKey(key)) {
        classifiedStories[key]?.add(story);
      } else {
        classifiedStories[key] = [story];
      }
    }
    state = state.copyWith(
      classifiedStories: classifiedStories.values.toList(),
    );
  }

  String _makeStoryKey(Story story) {
    return (story.tags.videoTimestamp ~/ (86400 * 1000)).toString() +
        story.tags.location.toString();
  }

  void onEditMode() {
    final User user = ref.read(currentUserProvider).copyWith();
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
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      state = state.copyWith(
        editingProfile:
            state.editingProfile?.copyWith(profileImage: image!.path),
      );
    }
  }

  void endEditMode() {
    if (state.editingProfile != null) {
      final description = state.editingProfile!.description;
      final nickname = state.editingProfile!.nickname;
      final profileImage = state.editingProfile!.profileImage;
      ref.read(currentUserProvider.notifier).updateUserInfo(
            description: description,
            nickname: nickname,
            profileImage: profileImage,
          );
    }
    state = state.copyWith(
      isEditingMode: false,
      editingProfile: null,
    );
  }

  void deleteStory(
      {required int storyId, required BuildContext context}) async {
    await Future.microtask(() async {
      final confirm = await customShowConfirm(
          context: context, title: '경고', content: '정말로 삭제하시겠습니까?');
      if (!confirm) return;
      await repository.deleteStory(storyId);
      loadStories();
    });
  }

  void addCurrentAddingFilter() {
    if (state.currentAddingFilter == null) {
      return;
    }
    state = state.copyWith(
      diaryFilters: [...state.diaryFilters, state.currentAddingFilter!],
      currentAddingFilter: null,
    );
    filterStories();
  }

  void updateCurrentAddingFilter(
      {required String filterType, required String filterString}) {
    final locations = ref.read(locationSelectorProvider);
    if (filterType == '장소') {
      state = state.copyWith(
        currentAddingFilter: DiaryFilter(
            filter: DiaryFilterType.location,
            validator: (Story story) =>
                locations[story.tags.location].name.contains(filterString),
            name: '장소:$filterString'),
      );
      return;
    } else if (filterType == '시도') {
      state = state.copyWith(
        currentAddingFilter: DiaryFilter(
          filter: DiaryFilterType.success,
          validator: (Story story) =>
              story.tags.success == (filterString == '성공'),
          name: '성공 여부:${filterString == '성공' ? '성공' : '실패'}',
        ),
      );
      return;
    }
    state = state.copyWith(currentAddingFilter: null);
  }

  void deleteFilter(int idx) {
    if (idx >= state.diaryFilters.length || idx < 0) {
      return;
    }
    final newDiaryFilters = state.diaryFilters.sublist(0);
    newDiaryFilters.removeAt(idx);
    state = state.copyWith(diaryFilters: newDiaryFilters);
    filterStories();
  }
}
