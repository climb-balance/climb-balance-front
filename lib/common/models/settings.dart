import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

part 'settings.g.dart';

@freezed
class Settings with _$Settings {
  const factory Settings({
    @Default(false) darkMode,
    @Default(false) expertMode,
  }) = _Settings;

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);
}
