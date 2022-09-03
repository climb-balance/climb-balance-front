import 'package:climb_balance/domain/util/story_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/story.dart';

part 'diary_state.freezed.dart';

@freezed
class DiaryState with _$DiaryState {
  const factory DiaryState({
    @Default([]) List<List<Story>> classifiedStories,
    @Default(StoryFilter.noFilter()) StoryFilter storyFilter,
  }) = _DiaryState;
}
