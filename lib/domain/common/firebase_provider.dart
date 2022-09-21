import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data_source/service/firebase_service.dart';
import '../const/route_name.dart';

final firebaseProvider = StateNotifierProvider<FirebaseNotifier, String>((ref) {
  FirebaseNotifier notifier = FirebaseNotifier(
      ref: ref, firebaseService: ref.watch(firebaseServiceProvider));
  return notifier;
});

class FirebaseNotifier extends StateNotifier<String> {
  final StateNotifierProviderRef<FirebaseNotifier, String> ref;
  final FirebaseService firebaseService;

  FirebaseNotifier({
    required this.ref,
    required this.firebaseService,
  }) : super('');

  void initFirebase(BuildContext context) async {
    final result = await firebaseService.getFirebaseMessagingToken();
    result.when(success: (value) {
      state = value;
    }, error: (message) {
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final data = message.data;

      if (data['notification_id'] == 'AI_COMPLETE') {
        final storyId = data['video_id'] ?? '1';
        context.pushNamed(diaryStoryRouteName, params: {'sid': storyId});
      }
    });
  }
}