import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../services/firebase_service.dart';

enum NotificationEvent {
  aiComplete,
}

class FirebaseNotifier extends StateNotifier<String> {
  final StateNotifierProviderRef<FirebaseNotifier, String> ref;

  FirebaseNotifier({required this.ref}) : super('');

  void initFirebase() async {
    final result = await FirebaseService.getFirebaseMessagingToken();
    result.when(success: (value) {
      state = value;
    }, error: (message) {
      return;
    });
  }
}

final firebaseProvider = StateNotifierProvider<FirebaseNotifier, String>((ref) {
  FirebaseNotifier notifier = FirebaseNotifier(ref: ref);
  notifier.initFirebase();
  return notifier;
});
