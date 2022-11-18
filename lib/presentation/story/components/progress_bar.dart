import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ProgressBar extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const ProgressBar({Key? key, required this.videoPlayerController})
      : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  double progressDegree = 0;
  int progressDuration = 500;
  late final void Function() _listener;

  @override
  void initState() {
    super.initState();
    _listener = () {
      final value = widget.videoPlayerController.value;
      if (value.duration.inMilliseconds == 0) {
        return;
      }
      progressDegree =
          (value.position.inMilliseconds / value.duration.inMilliseconds);

      setState(() {});
    };
    widget.videoPlayerController.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.videoPlayerController.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      width: size.width,
      height: 14,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Stack(
          children: [
            Container(
              height: 4,
              width: size.width,
              color: color.surface,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  height: 4,
                  width: progressDegree * size.width,
                  color: color.primary,
                  duration: Duration(milliseconds: progressDuration),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
