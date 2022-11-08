import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayingStatus extends StatefulWidget {
  const PlayingStatus({
    Key? key,
    required this.togglePlaying,
    required this.videoPlayerController,
  }) : super(key: key);

  final void Function() togglePlaying;
  final VideoPlayerController videoPlayerController;

  @override
  State<PlayingStatus> createState() => _PlayingStatusState();
}

class _PlayingStatusState extends State<PlayingStatus> {
  @override
  void initState() {
    super.initState();
    widget.videoPlayerController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.togglePlaying();
      },
      child: AnimatedOpacity(
        opacity: 0.75,
        duration: const Duration(milliseconds: 250),
        child: Center(
          child: widget.videoPlayerController.value.isPlaying
              ? const Icon(
                  Icons.pause_circle,
                  size: 75,
                )
              : const Icon(
                  Icons.play_circle,
                  size: 75,
                ),
        ),
      ),
    );
  }
}
