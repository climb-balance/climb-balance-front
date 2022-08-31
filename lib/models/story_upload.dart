import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_upload.freezed.dart';

part 'story_upload.g.dart';

@freezed
class StoryUpload with _$StoryUpload {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory StoryUpload({
    double? start,
    double? end,
    @Default(-1) int location,
    @Default(-1) int difficulty,
    @Default(false) bool success,
    DateTime? videoDate,
    @Default('empty') String description,
    @JsonKey(ignore: true) File? file,
  }) = _StoryUpload;

  factory StoryUpload.fromJson(Map<String, dynamic> json) =>
      _$StoryUploadFromJson(json);
}
