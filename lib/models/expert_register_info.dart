import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'expert_register_info.freezed.dart';

part 'expert_register_info.g.dart';

@freezed
class ExpertRegisterInfo with _$ExpertRegisterInfo {
  const factory ExpertRegisterInfo({
    @Default('default') String nickName,
    @Default('') String introduce,
    @Default(-1) int climbingCenterId,
    @Default('') String code,
    @JsonKey(ignore: true) File? tmpImage,
  }) = _ExpertRegisterInfo;

  factory ExpertRegisterInfo.fromJson(Map<String, dynamic> json) =>
      _$ExpertRegisterInfoFromJson(json);
}
