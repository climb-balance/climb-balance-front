import 'package:freezed_annotation/freezed_annotation.dart';

part 'expert_feedback.freezed.dart';

part 'expert_feedback.g.dart';

@freezed
class ExpertFeedback with _$ExpertFeedback {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ExpertFeedback({
    @Default('') String comment,
    @Default(1) int stars,
  }) = _ExpertFeedback;

  factory ExpertFeedback.fromJson(Map<String, dynamic> json) =>
      _$ExpertFeedbackFromJson(json);
}
