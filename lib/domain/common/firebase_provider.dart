import 'package:climb_balance/domain/common/local_notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/data_source/service/firebase_service.dart';

final firebaseProvider = StateNotifierProvider<FirebaseNotifier, String>((ref) {
  FirebaseNotifier notifier = FirebaseNotifier(
      ref: ref, firebaseService: ref.watch(firebaseServiceProvider));
  return notifier;
});

/// firebase 토큰을 state로 가진다.
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
      debugPrint('firebase init success token : ${value}');
    }, error: (message) {
      debugPrint(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) => _openBackGroundMessage(context, message));
    FirebaseMessaging.onMessage
        .listen((message) => _foregroundMessageHandler(context, message));
  }

  void _openBackGroundMessage(
      BuildContext context, RemoteMessage message) async {
    final data = message.data;
    if (data['notificationId'] == 'AI_COMPLETE') {
      final storyId = data['videoId'] ?? '1';
      context.push('/diary/story/$storyId/ai');
    }
  }

  void _foregroundMessageHandler(BuildContext context, RemoteMessage message) {
    ref.read(localNotificationProvider.notifier).showNotification(message);
  }
}
