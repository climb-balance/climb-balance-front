import 'package:flutter/material.dart';

import '../../../domain/model/story_tag.dart';
import '../../common/components/tags.dart';

class StoryOverlayAppBar extends StatelessWidget with PreferredSizeWidget {
  final StoryTags tags;
  final void Function() handleBack;

  const StoryOverlayAppBar(
      {Key? key, required this.tags, required this.handleBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: StoryTagInfo(
        tags: tags,
      ),
      titleTextStyle: Theme.of(context).textTheme.bodyText2,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: handleBack,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
