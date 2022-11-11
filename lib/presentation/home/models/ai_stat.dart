import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_stat.freezed.dart';

part 'ai_stat.g.dart';

@freezed
class AiStat with _$AiStat {
  const factory AiStat({
    required String thumbnail,
    required double tech,
    required double flex,
    required double pose,
    required int rank,
  }) = _AiStat;

  factory AiStat.fromJson(Map<String, dynamic> json) => _$AiStatFromJson(json);
}
