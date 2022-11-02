import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/model/result.dart';

final firebaseServiceProvider = Provider<FirebaseService>((ref) {
  return FirebaseService();
});

class FirebaseService {
  Future<Result<String>> getFirebaseMessagingToken() async {
    try {
      final result = await FirebaseMessaging.instance.getToken();
      return Result.success(result!);
    } catch (e) {
      return Result.error('메세지 토큰 에러 ${e}');
    }
  }
}
