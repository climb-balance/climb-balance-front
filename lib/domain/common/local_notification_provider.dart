import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final localNotificationProvider =
    StateNotifierProvider<LocalNotificationNotifier, String>((ref) {
  LocalNotificationNotifier notifier = LocalNotificationNotifier(ref: ref);
  notifier.initNotification();
  return notifier;
});

/// firebase 토큰을 state로 가진다.
class LocalNotificationNotifier extends StateNotifier<String> {
  final Ref ref;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotificationNotifier({
    required this.ref,
  }) : super('');

  void initNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    final result = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    if (result != null && result) {
      await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    }
    // TODO 앱 강종
  }

  void showNotification(RemoteMessage message) async {
    String title = message.notification?.title ?? '';
    String body = message.notification?.body ?? '';
    debugPrint(title);
    debugPrint(body);
    AndroidNotificationDetails androidNotiDetails = AndroidNotificationDetails(
      'dexterous.com.flutter.local_notifications',
      title,
      importance: Importance.max,
      priority: Priority.max,
    );

    final details = NotificationDetails(android: androidNotiDetails);

    await flutterLocalNotificationsPlugin.show(0, title, body, details);
  }
}
