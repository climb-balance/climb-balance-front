import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FirebaseNotifier extends StateNotifier<String?> {
  final ref;

  FirebaseNotifier({required this.ref}) : super(null);

  void initFirebase() async {
    await Firebase.initializeApp();
    state = await FirebaseMessaging.instance.getToken();
  }
}

final firebaseProvider =
    StateNotifierProvider<FirebaseNotifier, String?>((ref) {
  FirebaseNotifier notifier = FirebaseNotifier(ref: ref);
  notifier.initFirebase();
  return notifier;
});
