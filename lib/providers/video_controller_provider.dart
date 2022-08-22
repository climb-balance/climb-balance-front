import 'package:climb_balance/services/server_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class VideoControllerNotifier extends StateNotifier<void> {
  final ref;
  late final VideoPlayerController videoPlayerController;

  void updateVideoController(int storyId, {bool isAi = false}) async {
    final result = await ServerService.storyVideo(storyId, isAi: isAi);
    result.when(
        success: (value) {
          videoPlayerController = value;
        },
        error: (message) {});
  }

  bool togglePlay() {
    videoPlayerController.value.isPlaying
        ? videoPlayerController.play()
        : videoPlayerController.pause();
    return videoPlayerController.value.isPlaying;
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }

  VideoControllerNotifier({required this.ref}) : super(null);
}

final videoControllerProvider =
    StateNotifierProvider<VideoControllerNotifier, void>((ref) {
  VideoControllerNotifier notifier = VideoControllerNotifier(ref: ref);
  return notifier;
});
