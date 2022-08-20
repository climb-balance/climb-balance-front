import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_tag.freezed.dart';

part 'story_tag.g.dart';

@freezed
class StoryTags with _$StoryTags {
  const StoryTags._();

  const factory StoryTags({
    @Default(-1) int location,
    @Default(-1) int difficulty,
    @Default(false) bool success,
    required DateTime videoDate,
  }) = _StoryTags;

  factory StoryTags.fromJson(Map<String, dynamic> json) =>
      _$StoryTagsFromJson(json);

  String formatDatetime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDay = twoDigits(videoDate.day);
    String twoDigitMonth = twoDigits(videoDate.month);
    return "${videoDate.year}-$twoDigitMonth-$twoDigitDay";
  }
}
