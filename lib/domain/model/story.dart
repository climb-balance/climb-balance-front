import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../util/feedback_status.dart';
import 'story_tag.dart';

part 'story.freezed.dart';

part 'story.g.dart';

@freezed
class Story with _$Story {
  const factory Story({
    @Default(StoryTags()) StoryTags tags,
    @Default(0) int likes,
    @Default('') String description,
    @Default(0) int comments,
    @Default(FeedbackStatus.waiting) FeedbackStatus aiStatus,
    @Default(FeedbackStatus.waiting) FeedbackStatus expertStatus,
    @Default(0) int uploadTimestamp,
    @Default('https://static-cse.canva.com/blob/651263/youtube.jpg')
        String thumbnailUrl,
    @Default(-1) int uploaderId,
    @Default(-1) int storyId,
  }) = _Story;

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
}

// TODO remove
Story genRandomStory() {
  Random random = Random();
  return Story(
    tags: StoryTags(
      videoTimestamp: DateTime.now().millisecondsSinceEpoch,
      difficulty: random.nextInt(4) - 1,
      location: random.nextInt(4) - 1,
      success: false,
    ),
    likes: random.nextInt(100),
    description: '안녕하세요',
    comments: random.nextInt(100),
    aiStatus: FeedbackStatus.values[random.nextInt(3)],
    expertStatus: FeedbackStatus.values[random.nextInt(3)],
    uploadTimestamp: DateTime.now().millisecondsSinceEpoch,
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
