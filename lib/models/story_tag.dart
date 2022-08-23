import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_tag.freezed.dart';

part 'story_tag.g.dart';

@freezed
class StoryTags with _$StoryTags {
  const StoryTags._();

  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StoryTags({
    @Default(-1) int location,
    @Default(-1) int difficulty,
    @Default(false) bool success,
    required DateTime? videoDate,
  }) = _StoryTags;

  factory StoryTags.fromJson(Map<String, dynamic> json) =>
      _$StoryTagsFromJson(json);

  DateTime get getVideoDate => videoDate ?? DateTime(2022, 08, 12);

  String formatDatetime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitDay = twoDigits(getVideoDate.day);
    String twoDigitMonth = twoDigits(getVideoDate.month);
    return "${getVideoDate.year}-$twoDigitMonth-$twoDigitDay";
  }
}
