import 'package:climb_balance/domain/common/local_notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final uploaderProvider = StateNotifierProvider<UploaderNotifier, String>((ref) {
  UploaderNotifier notifier = UploaderNotifier(
    ref: ref,
  );
  return notifier;
});

class UploaderNotifier extends StateNotifier<String> {
  final StateNotifierProviderRef ref;
  final FlutterUploader uploader = FlutterUploader();

  UploaderNotifier({
    required this.ref,
  }) : super('');

  Future<void> mobileInit() async {
    await FlutterUploader().setBackgroundHandler(backgroundHandler);
  }

  static void backgroundHandler() {
    // Needed so that plugin communication works.
    WidgetsFlutterBinding.ensureInitialized();

    // This uploader instance works within the isolate only.
    FlutterUploader uploader = FlutterUploader();

    // You have now access to:
    uploader.progress.listen((progress) {
      if (progress.progress == null) {
        return;
      }
      debugPrint('${progress.toString()} dasdasdasd');
      LocalNotificationNotifier.showProgress(progress.progress!);
    });
    uploader.result.listen((result) {
      if (result.status == UploadTaskStatus.complete) {
        LocalNotificationNotifier.showProgressResult('업로드 성공');
      } else {
        LocalNotificationNotifier.showProgressResult('업로드 실패');
      }
    });
  }
}
