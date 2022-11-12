import 'package:climb_balance/domain/util/stories_filter.dart';
import 'package:climb_balance/presentation/diary/models/diary_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/story.dart';
import '../../../domain/model/user.dart';

part 'diary_state.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState({
    @Default([]) List<List<Story>> classifiedStories,
    @Default(StoriesFilter.noFilter()) StoriesFilter storyFilter,
    @Default([]) List<DiaryFilter> diaryFilters,
    DiaryFilter? currentAddingFilter,
    User? editingProfile,
    @Default(false) isEditingMode,
  }) = _DiaryState;
}
