import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_tag.freezed.dart';

part 'story_tag.g.dart';

@freezed
class StoryTags with _$StoryTags {
  const StoryTags._();

  const factory StoryTags({
    @Default(0) int location,
    @Default(0) int difficulty,
    @Default(false) bool success,
    @Default(0) int videoTimestamp,
  }) = _StoryTags;

  factory StoryTags.fromJson(Map<String, dynamic> json) =>
      _$StoryTagsFromJson(json);
}
