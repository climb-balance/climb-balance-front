import 'package:climb_balance/data/data_source/service/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/settings.dart';

final settingsProvider =
    StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  SettingsNotifier notifier = SettingsNotifier(
      ref: ref, storageService: ref.watch(storageServiceProvider));
  notifier.loadSettingFromStorage();
  return notifier;
});

class SettingsNotifier extends StateNotifier<Settings> {
  final ref;
  final StorageService storageService;

  SettingsNotifier({
    required this.ref,
    required this.storageService,
  }) : super(const Settings());

  void loadSettingFromStorage() async {
    state = await storageService.getStoredSettings();
  }

  void updateSetting({bool? darkMode, bool? expertMode}) {
    darkMode ??= state.darkMode;
    expertMode ??= state.expertMode;
    Settings settings =
        state.copyWith(darkMode: darkMode, expertMode: expertMode);
    state = settings;
    storageService.storeSettings(settings);
  }
}
