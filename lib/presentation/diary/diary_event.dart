import 'package:climb_balance/domain/util/story_filter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary_event.freezed.dart';

@freezed
class DiaryEvent with _$DiaryEvent {
  const factory DiaryEvent.loadStories() = LoadStories;

  const factory DiaryEvent.filterStories(StoryFilter storyFilter) =
      FilterStories;
}
