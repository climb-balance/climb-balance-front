import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_event.freezed.dart';

@freezed
class StoryEvent with _$StoryEvent {
  const factory StoryEvent.likeStory() = likeStory;

  const factory StoryEvent.loadComments() = LoadComments;

  const factory StoryEvent.requestAiFeedback(BuildContext context) =
      RequestAiFeedback;

  const factory StoryEvent.requestExpertFeedback(BuildContext context) =
      RequestExpertFeedback;
}
