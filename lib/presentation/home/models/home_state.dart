import 'package:climb_balance/presentation/home/models/ai_stat.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    AiStat? aiStat,
    @Default([1, 2, 3, 4, 5]) List<int> storyCount,
    @Default(0) int continuity,
    @Default(2) int unread,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
