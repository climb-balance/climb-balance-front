import 'package:json_annotation/json_annotation.dart';

enum FeedbackStatus {
  @JsonValue(0)
  possible,
  @JsonValue(1)
  waiting,
  @JsonValue(2)
  complete,
}
