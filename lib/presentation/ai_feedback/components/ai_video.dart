import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../community/community_screen.dart';
import 'ai_feedback_progress_bar.dart';

class AiVideo extends ConsumerStatefulWidget {
  final int storyId;

  const AiVideo({Key? key, required this.storyId}) : super(key: key);

  @override
  ConsumerState<AiVideo> createState() => _AiVideoState();
}

class _AiVideoState extends ConsumerState<AiVideo>
    with TickerProviderStateMixin {
  late final VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(
      ref
          .read(aiFeedbackViewModelProvider(widget.storyId).notifier)
          .getStoryAiVideoPath(),
      formatHint: VideoFormat.hls,
    );
    _videoPlayerController.initialize().then((_) {
      _videoPlayerController.play();
      _videoPlayerController.setLooping(true);
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.removeListener(() {});
    _videoPlayerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(aiFeedbackViewModelProvider(widget.storyId));
    return _videoPlayerController.value.isInitialized
        ? Column(
            children: [
              Expanded(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Stack(
                      children: [
                        VideoPlayer(
                          _videoPlayerController,
                        ),
                        AiFeedbackOverlay(
                          videoPlayerController: _videoPlayerController,
                          ticker: this,
                          storyId: widget.storyId,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AiFeedbackProgressBar(
                  detail: provider,
                  controller: _videoPlayerController,
                ),
              ),
            ],
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
