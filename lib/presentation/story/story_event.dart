import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_event.freezed.dart';

@freezed
class StoryEvent with _$StoryEvent {
  const factory StoryEvent.likeStory(int storyId) = likeStory;

  const factory StoryEvent.loadComments(int storyId) = LoadComments;

  const factory StoryEvent.requestAiFeedback(int storyId) = RequestAiFeedback;

  const factory StoryEvent.requestExpertFeedback(int storyId) =
      RequestExpertFeedback;
}
