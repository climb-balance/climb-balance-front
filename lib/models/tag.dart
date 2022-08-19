import 'dart:convert';

// To parse this JSON data, do
//
//     final tags = tagsFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'tags.freezed.dart';

part 'tags.g.dart';

Tags tagsFromJson(String str) => Tags.fromJson(json.decode(str));

String tagsToJson(Tags data) => json.encode(data.toJson());

@freezed
abstract class Tags with _$Tags {
  const factory Tags({
    int storyId,
    int location,
    int difficulty,
    bool success,
    DateTime videoDate,
  }) = _Tags;

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
}
