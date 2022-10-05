import 'package:flutter/material.dart';

import '../common/ui/theme/specific_theme.dart';
import 'components/ai_video.dart';

class AiFeedbackScreen extends StatelessWidget {
  final int storyId;

  const AiFeedbackScreen({Key? key, required this.storyId}) : super(key: key);

  Widget build(BuildContext context) {
    return StoryViewTheme(
      child: SafeArea(
        child: Stack(
          children: [
            AiVideo(storyId: storyId),
          ],
        ),
      ),
    );
  }
}
