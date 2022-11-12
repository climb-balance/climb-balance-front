import 'package:freezed_annotation/freezed_annotation.dart';

part 'update_user.freezed.dart';

part 'update_user.g.dart';

@freezed
class UpdateUser with _$UpdateUser {
  const factory UpdateUser({
    String? nickname,
    String? description,
    String? profileImage,
    bool? promotionCheck,
    bool? personalCheck,
  }) = _UpdateUser;

  factory UpdateUser.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserFromJson(json);
}
