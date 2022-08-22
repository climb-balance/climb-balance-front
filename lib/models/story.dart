import 'dart:math';

import 'package:climb_balance/models/story_tag.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story.freezed.dart';

part 'story.g.dart';

@freezed
class Story with _$Story {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Story({
    required StoryTags tags,
    required int likes,
    @Default('') String description,
    required int comments,
    required int aiAvailable,
    required int expertAvailable,
    required DateTime uploadDate,
    @Default('https://static-cse.canva.com/blob/651263/youtube.jpg')
        String thumbnailUrl,
    required int uploaderId,
    @Default(0) int videoId,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

Story getRandomStory() {
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
    uploaderId: random.nextInt(2),
    videoId: random.nextInt(4),
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
