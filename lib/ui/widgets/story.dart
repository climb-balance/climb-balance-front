import 'package:flutter/material.dart';

import '../../models/story.dart';

class StoryPreview extends StatelessWidget {
  final Story story;

  const StoryPreview({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: () {}, child: Image.network(story.thumbnailPath));
  }
}
