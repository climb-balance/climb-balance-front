import 'package:climb_balance/data/data_source/service/storage_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'account_state.dart';

final accountViewModelProvider =
    StateNotifierProvider<AccountViewModel, AccountState>((ref) {
  AccountViewModel notifier = AccountViewModel(
      ref: ref, storageService: ref.watch(storageServiceProvider));
  notifier.loadSettingFromStorage();
  return notifier;
});

class AccountViewModel extends StateNotifier<AccountState> {
  final ref;
  final StorageService storageService;

  AccountViewModel({
    required this.ref,
    required this.storageService,
  }) : super(const AccountState());

  void loadSettingFromStorage() async {
    state = await storageService.getStoredSettings();
  }

  void updateSetting({bool? darkMode, bool? expertMode}) {
    darkMode ??= state.darkMode;
    expertMode ??= state.expertMode;
    AccountState settings =
        state.copyWith(darkMode: darkMode, expertMode: expertMode);
    state = settings;
    storageService.storeSettings(settings);
  }
}
