import 'package:climb_balance/presentation/community/models/story_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_state.freezed.dart';

@freezed
class CommunityState with _$CommunityState {
  const factory CommunityState({
    @Default([]) List<StoryId> storyIds,
    @Default(0) int currentIdx,
  }) = _CommunityState;
}
