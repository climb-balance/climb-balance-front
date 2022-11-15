import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_id.freezed.dart';

part 'story_id.g.dart';

@freezed
class StoryId with _$StoryId {
  const factory StoryId({
    required int storyId,
  }) = _StoryId;

  factory StoryId.fromJson(Map<String, dynamic> json) =>
      _$StoryIdFromJson(json);
}

@freezed
class StoryIds with _$StoryIds {
  const factory StoryIds({
    @Default([]) List<StoryId> storyIds,
  }) = _StoryIds;

  factory StoryIds.fromJson(Map<String, dynamic> json) =>
      _$StoryIdsFromJson(json);
}
