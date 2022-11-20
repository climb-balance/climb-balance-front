import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  final BetterPlayerController betterPlayerController;

  const ProgressBar({Key? key, required this.betterPlayerController})
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
      if (widget.betterPlayerController.videoPlayerController == null) return;
      final value = widget.betterPlayerController.videoPlayerController!.value;
      if (value.duration!.inMilliseconds == 0) {
        return;
      }
      progressDegree =
          (value.position.inMilliseconds / value.duration!.inMilliseconds);

      setState(() {});
    };
    widget.betterPlayerController.videoPlayerController!.addListener(_listener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.betterPlayerController.videoPlayerController!
        .removeListener(_listener);
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
