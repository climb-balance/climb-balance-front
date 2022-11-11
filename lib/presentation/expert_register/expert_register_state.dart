import 'package:freezed_annotation/freezed_annotation.dart';

part 'expert_register_state.freezed.dart';

part 'expert_register_state.g.dart';

@freezed
class ExpertRegisterState with _$ExpertRegisterState {
  const factory ExpertRegisterState({
    @Default('default') String nickname,
    @Default('') String description,
    @Default(-1) int climbingCenterId,
    @Default('') String code,
    @JsonKey(ignore: true) String? profileImagePath,
  }) = _ExpertRegisterState;

  factory ExpertRegisterState.fromJson(Map<String, dynamic> json) =>
      _$ExpertRegisterStateFromJson(json);
}
