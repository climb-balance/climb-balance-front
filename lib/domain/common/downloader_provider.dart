import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final downloaderProvider =
    StateNotifierProvider<DownloaderNotifier, String>((ref) {
  DownloaderNotifier notifier = DownloaderNotifier(
    ref: ref,
  );
  return notifier;
});

/// firebase 토큰을 state로 가진다.
class DownloaderNotifier extends StateNotifier<String> {
  final StateNotifierProviderRef ref;

  DownloaderNotifier({
    required this.ref,
  }) : super('');

  @pragma('vm:entry-point')
  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send?.send([id, status, progress]);
  }

  Future<void> mobileInit() async {
    await FlutterDownloader.initialize(
      debug: true,
      ignoreSsl: true,
    );
    await FlutterDownloader.registerCallback(downloadCallback);
  }

  Future<void> deleteTmpFile({
    required String dir,
    required String fileName,
  }) async {
    try {
      final localFile = File('$dir/$fileName');
      await localFile.delete();
    } catch (e) {
      return;
    }
  }

  Future<String?> addDownload({
    required String url,
    required String dir,
    String fileName = 'tmp.mp4',
  }) async {
    await deleteTmpFile(dir: dir, fileName: fileName);
    final taskId = await FlutterDownloader.enqueue(
      showNotification: false,
      url: url,
      headers: {},
      // optional: header send with url (auth token etc)
      fileName: fileName,
      savedDir: dir,
    );
    if (taskId == null) return null;
    return '$dir/$fileName';
  }
}
