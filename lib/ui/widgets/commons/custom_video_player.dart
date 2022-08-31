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
  late final VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    ref
        .read(videoControllerProvider.notifier)
        .getVideoPlayerController(widget.storyId)
        .then((value) {
      videoPlayerController = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: videoPlayerController != null
          ? AspectRatio(
              aspectRatio: videoPlayerController!.value.aspectRatio,
              child: VideoPlayer(videoPlayerController!),
            )
          : const CircularProgressIndicator(),
    );
  }
}
