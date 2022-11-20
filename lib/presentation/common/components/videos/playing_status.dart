import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PlayingStatus extends ConsumerWidget {
  final bool isPlaying;

  const PlayingStatus({
    Key? key,
    required this.isPlaying,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AnimatedOpacity(
      opacity: 0.75,
      duration: const Duration(milliseconds: 250),
      child: Center(
        child: isPlaying
            ? const Icon(
                Icons.pause_circle,
                size: 75,
              )
            : const Icon(
                Icons.play_circle,
                size: 75,
              ),
      ),
    );
  }
}
