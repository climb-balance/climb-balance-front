import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data_source/service/firebase_service.dart';

final firebaseProvider = StateNotifierProvider<FirebaseNotifier, String>((ref) {
  FirebaseNotifier notifier = FirebaseNotifier(
      ref: ref, firebaseService: ref.watch(firebaseServiceProvider));
  notifier.initFirebase();
  return notifier;
});

class FirebaseNotifier extends StateNotifier<String> {
  final StateNotifierProviderRef<FirebaseNotifier, String> ref;
  final FirebaseService firebaseService;

  FirebaseNotifier({
    required this.ref,
    required this.firebaseService,
  }) : super('');

  void initFirebase() async {
    final result = await firebaseService.getFirebaseMessagingToken();
    result.when(success: (value) {
      state = value;
    }, error: (message) {
      return;
    });
  }
}
