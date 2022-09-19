import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_state.freezed.dart';

part 'register_state.g.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState({
    @Default(165) int height,
    @Default(60) int weight,
    @Default('M') String sex,
    @Default('') String description,
    @Default('') String nickname,
    @Default('') String accessToken,
    @Default('https://unsplash.com/photos/T0t72_3yIIY') String profileImage,
    @JsonKey(ignore: true) @Default(0) int curPage,
  }) = _RegisterState;

  factory RegisterState.fromJson(Map<String, dynamic> json) =>
      _$RegisterStateFromJson(json);
}
