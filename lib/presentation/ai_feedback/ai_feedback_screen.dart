import 'package:climb_balance/presentation/ai_feedback/ai_feedback_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../common/ui/theme/specific_theme.dart';
import 'components/ai_feedback_overlay.dart';
import 'components/ai_feedback_progress_bar.dart';

class AiFeedbackScreen extends ConsumerStatefulWidget {
  final int storyId;

  const AiFeedbackScreen({Key? key, required this.storyId}) : super(key: key);

  @override
  ConsumerState<AiFeedbackScreen> createState() => _AiFeedbackScreenState();
}

class _AiFeedbackScreenState extends ConsumerState<AiFeedbackScreen>
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
    final notifier =
        ref.read(aiFeedbackViewModelProvider(widget.storyId).notifier);
    final size = MediaQuery.of(context).size;
    return StoryViewTheme(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _videoPlayerController.value.isInitialized
                ? Expanded(
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
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  ),
            if (_videoPlayerController.value.isInitialized)
              Align(
                alignment: Alignment.bottomCenter,
                child: AiFeedbackProgressBar(
                  detail: provider,
                  controller: _videoPlayerController,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
