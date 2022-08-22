import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../models/result.dart';

List<String> testVideos = [
  'http://15.164.163.153:3000/story/1/video?type=raw',
  'http://15.164.163.153:3000/story/1/video?type=ai',
  'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-a-man-with-heads-like-matrushka-32647-large.mp4',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/house-painter-promotion-video-template-design-b0d4f2ba5aa5af51d385d0bbf813c908_screen.mp4?ts=1614933517',
];

class VideoControllerNotifier extends StateNotifier<VideoPlayerController?> {
  final ref;

  VideoControllerNotifier({required this.ref}) : super(null);

  void updateVideoController(int storyId, {bool isAi = false}) async {
    // TODO final result = await ServerService.storyVideo(storyId, isAi: isAi);
    final result =
        Result.success(VideoPlayerController.network(testVideos[storyId]));
    result.when(
        success: (value) {
          state = value;
          state!.initialize().then((value) {
            state!.play();
            state!.setLooping(true);
          });
        },
        error: (message) {});
  }

  bool togglePlay() {
    state!.value.isPlaying ? state!.play() : state!.pause();
    return state!.value.isPlaying;
  }

  @override
  void dispose() {
    super.dispose();
    state!.dispose();
  }
}

final videoControllerProvider = StateNotifierProvider.autoDispose<
    VideoControllerNotifier, VideoPlayerController?>((ref) {
  VideoControllerNotifier notifier = VideoControllerNotifier(ref: ref);
  return notifier;
});
