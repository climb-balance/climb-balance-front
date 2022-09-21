import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/model/story_tag.dart';
import '../../common/components/tags.dart';

class StoryOverlayAppBar extends StatelessWidget with PreferredSizeWidget {
  final StoryTags tags;

  const StoryOverlayAppBar({
    Key? key,
    required this.tags,
  }) : super(key: key);

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
        onPressed: () {
          context.pop();
        },
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
