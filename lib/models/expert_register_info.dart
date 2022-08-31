import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expert_register_info.freezed.dart';

part 'expert_register_info.g.dart';

@freezed
class ExpertRegisterInfo with _$ExpertRegisterInfo {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ExpertRegisterInfo({
    @Default('default') String nickname,
    @Default('') String description,
    @Default(-1) int climbingCenterId,
    @Default('') String code,
    @JsonKey(ignore: true) File? tmpImage,
  }) = _ExpertRegisterInfo;

  factory ExpertRegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$ExpertRegisterInfoFromJson(json);
}
