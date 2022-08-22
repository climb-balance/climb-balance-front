import 'package:climb_balance/providers/video_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends ConsumerStatefulWidget {
  final int storyId;

  const CustomVideoPlayer({Key? key, required this.storyId}) : super(key: key);

  @override
  ConsumerState<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends ConsumerState<CustomVideoPlayer> {
  @override
  void initState() {
    super.initState();
    ref
        .read(videoControllerProvider.notifier)
        .updateVideoController(widget.storyId);
  }

  @override
  Widget build(BuildContext context) {
    final videoPlayerController = ref.watch(videoControllerProvider)!;
    return Center(
      child: videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: VideoPlayer(videoPlayerController),
            )
          : const CircularProgressIndicator(),
    );
  }
}
