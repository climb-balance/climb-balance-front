import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../common/ui/theme/specific_theme.dart';
import 'components/ai_feedback_progress_bar.dart';

class AiFeedbackScreen extends ConsumerStatefulWidget {
  final int storyId;

  const AiFeedbackScreen({Key? key, required this.storyId}) : super(key: key);

  @override
  ConsumerState<AiFeedbackScreen> createState() => _AiFeedbackScreenState();
}

class _AiFeedbackScreenState extends ConsumerState<AiFeedbackScreen> {
  late final VideoPlayerController _controller;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(aiFeedbackViewModelProvider(widget.storyId));
    final notifier =
        ref.read(aiFeedbackViewModelProvider(widget.storyId).notifier);
    _controller = VideoPlayerController.network(
      notifier.getStoryAiVideoPath(),
      formatHint: VideoFormat.hls,
    )..initialize().then((value) {
        _controller.setLooping(true);
        _controller.play();
        setState(() {});
      });
    final size = MediaQuery.of(context).size;
    return StoryViewTheme(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _controller.value.isInitialized
                ? Expanded(
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(
                          _controller,
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            if (_controller.value.isInitialized)
              Align(
                alignment: Alignment.bottomCenter,
                child: AiFeedbackProgressBar(
                  detail: provider,
                  controller: _controller,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
