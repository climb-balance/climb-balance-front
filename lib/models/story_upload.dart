import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_upload.freezed.dart';

part 'story_upload.g.dart';

@freezed
class StoryUpload with _$StoryUpload {
  const factory StoryUpload({
    @Default(-1) double start,
    @Default(-1) double end,
    @Default(-1) int location,
    @Default(-1) int difficulty,
    @Default(false) bool success,
    DateTime? date,
    @Default('') String detail,
    @JsonKey(ignore: true) File? file,
  }) = _StoryUpload;

  factory StoryUpload.fromJson(Map<String, dynamic> json) =>
      _$StoryUploadFromJson(json);
}
