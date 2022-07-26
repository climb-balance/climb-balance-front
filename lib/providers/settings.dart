import 'package:climb_balance/utils/storage/setting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings {
  bool darkMode = false;

  Settings({this.darkMode = false});

  void loadSettingFromStorage() {}

  Settings.clone(Settings settings) : this(darkMode: settings.darkMode);
}

class SettingsNotifier extends StateNotifier<Settings> {
  final ref;

  SettingsNotifier({required this.ref}) : super(Settings());

  void loadSettingFromStorage() async {
    state = await getStoredSettings();
  }

  void updateSetting({bool? darkMode}) async {
    Settings settings = Settings();
    if (darkMode != null) {
      settings.darkMode = darkMode;
    }
    await storeSettings(settings);
    state = settings;
  }
}

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  SettingsNotifier notifier = SettingsNotifier(ref: ref);
  notifier.loadSettingFromStorage();
  return notifier;
});
