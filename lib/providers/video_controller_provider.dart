import 'package:climb_balance/services/server_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoControllerNotifier extends StateNotifier<VideoPlayerController?> {
  final ref;

  VideoControllerNotifier({required this.ref}) : super(null);

  Future<VideoPlayerController?> getVideoPlayerController(int storyId,
      {bool isAi = false}) async {
    final result = await ServerService.gerStoryVideo(storyId, isAi: isAi);
    result.when(
        success: (controller) {
          controller.initialize().then((value) {
            controller.play();
            controller.setLooping(true);
            return controller;
          });
        },
        error: (message) {});
    return null;
  }
}

final videoControllerProvider =
    StateNotifierProvider.autoDispose<VideoControllerNotifier, void>((ref) {
  VideoControllerNotifier notifier = VideoControllerNotifier(ref: ref);
  return notifier;
});
