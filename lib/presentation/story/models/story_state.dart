import 'package:climb_balance/domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/model/story.dart';
import 'comment.dart';

part 'story_state.freezed.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState({
    @Default(User()) User uploader,
    @Default(Story()) Story story,
    @Default(false) bool overlayOpen,
    @Default(false) bool playStatusOpen,
    @Default(false) bool commentOpen,
    @Default(true) bool isPlaying,
    @Default(false) bool isInitialized,
    @Default('') String currentComment,
    @Default([]) List<Comment> comments,
  }) = _StoryState;
}
