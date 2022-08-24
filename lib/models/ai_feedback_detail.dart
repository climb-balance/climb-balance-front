import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_feedback_detail.freezed.dart';

part 'ai_feedback_detail.g.dart';

@freezed
class AiFeedbackDetail with _$AiFeedbackDetail {
  const factory AiFeedbackDetail({
    required List<int> value,
  }) = _AiFeedbackDetail;

  factory AiFeedbackDetail.fromJson(Map<String, dynamic> json) =>
      _$AiFeedbackDetailFromJson(json);
}
