import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_balance/utils/storage/setting_storage.dart';
import '../models/settings.dart';

class SettingsNotifier extends StateNotifier<Settings> {
  final ref;

  SettingsNotifier({required this.ref}) : super(const Settings());

  void loadSettingFromStorage() async {
    state = await getStoredSettings();
  }

  void updateSetting({bool? darkMode, bool? expertMode}) async {
    darkMode ??= state.darkMode;
    expertMode ??= state.expertMode;
    Settings settings =
        state.copyWith(darkMode: darkMode, expertMode: expertMode);
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
