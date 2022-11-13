import 'package:climb_balance/domain/model/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/story.dart';

part 'story_state.freezed.dart';

@freezed
class StoryState with _$StoryState {
  const factory StoryState({
    @Default(User()) User uploader,
    @Default(Story()) Story story,
    @Default(false) bool overlayOpen,
    @Default(false) bool playStatusOpen,
  }) = _StoryState;
}
