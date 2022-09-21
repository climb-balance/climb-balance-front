import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_feedback_state.freezed.dart';

part 'ai_feedback_state.g.dart';

@freezed
class AiFeedbackState with _$AiFeedbackState {
  const factory AiFeedbackState({
    @Default([]) List<int> value,
  }) = _AiFeedbackDetail;

  factory AiFeedbackState.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackStateFromJson(json);
}
