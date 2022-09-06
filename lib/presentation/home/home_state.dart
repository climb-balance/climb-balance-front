import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/model/image_banner.dart';

part 'home_state.freezed.dart';

part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<int> climbingDatas,
    @Default([]) List<ImageBanner> imageBanners,
    @Default(0) int completedAiFeedback,
    @Default(0) int waitingExpertFeedback,
    @Default(0) int completedExpertFeedback,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
