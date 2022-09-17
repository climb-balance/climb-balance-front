import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_upload_state.freezed.dart';

part 'story_upload_state.g.dart';

@freezed
class StoryUploadState with _$StoryUploadState {
  const factory StoryUploadState({
    double? start,
    double? end,
    @Default(0) int location,
    @Default(0) int difficulty,
    @Default(false) bool success,
    @Default('empty') String description,
    @Default(0) int videoTimestamp,
    @JsonKey(ignore: true) String? videoPath,
  }) = _StoryUploadState;

  factory StoryUploadState.fromJson(Map<String, dynamic> json) =>
      _$StoryUploadStateFromJson(json);
}
