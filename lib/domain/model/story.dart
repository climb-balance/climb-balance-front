import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'story_tag.dart';

part 'story.freezed.dart';

part 'story.g.dart';

@freezed
class Story with _$Story {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Story({
    required StoryTags tags,
    @Default(0) int likes,
    @Default('') String description,
    @Default(0) int comments,
    @Default(0) int aiAvailable,
    @Default(0) int expertAvailable,
    required DateTime? uploadDate,
    @Default('https://static-cse.canva.com/blob/651263/youtube.jpg')
        String thumbnailUrl,
    required int uploaderId,
    @Default(-1) int storyId,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

// TODO remove
Story genRandomStory() {
  Random random = Random();
  return Story(
    tags: StoryTags(
      videoDate: DateTime.now(),
      difficulty: random.nextInt(4) - 1,
      location: random.nextInt(4) - 1,
      success: false,
    ),
    likes: random.nextInt(100),
    description: '안녕하세요',
    comments: random.nextInt(100),
    aiAvailable: random.nextInt(3) + 1,
    expertAvailable: random.nextInt(3) + 1,
    uploadDate: DateTime.now(),
    thumbnailUrl: 'https://i.imgur.com/IAhL4iA.jpeg',
    uploaderId: 2,
    storyId: random.nextInt(10),
  );
}

@freezed
class StoryList with _$StoryList {
  const factory StoryList({
    required List<Story> storyList,
  }) = _StoryList;

  factory StoryList.fromJson(Map<String, dynamic> json) =>
      _$StoryListFromJson(json);
}
