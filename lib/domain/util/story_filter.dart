import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_filter.freezed.dart';

@freezed
class StoryFilter with _$StoryFilter {
  const factory StoryFilter.noFilter() = NoFilter;

  const factory StoryFilter.aiOnly() = AiOnly;

  const factory StoryFilter.expertOnly() = ExpertOnly;
}
