import 'package:freezed_annotation/freezed_annotation.dart';

part 'feedback_status.freezed.dart';

part 'feedback_status.g.dart';

@freezed
class FeedbackStatus with _$FeedbackStatus {
  const factory FeedbackStatus({
    @Default(Duration.zero) Duration aiLeftTime,
    @Default(false) bool aiIsWaiting,
    @Default(Duration.zero) Duration aiWaitingTime,
    @Default(0) int waitingExpertFeedback,
    @Default(0) finishedExpertFeedback,
  }) = _FeedbackStatus;

  factory FeedbackStatus.fromJson(Map<String, dynamic> json) =>
      _$FeedbackStatusFromJson(json);
}
