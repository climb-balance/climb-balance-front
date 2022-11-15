import 'package:freezed_annotation/freezed_annotation.dart';

part 'comment.freezed.dart';

part 'comment.g.dart';

@freezed
class Comment with _$Comment {
  const factory Comment({
    @Default(-1) int userId,
    @Default(-1) int commentId,
    @Default('') String userProfileImage,
    @Default('') String content,
    @Default('') String nickname,
    @Default(0) int likes,
    @Default(0) int createdTimestamp,
  }) = _Comment;

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
}
