import 'package:climb_balance/presentation/common/components/my_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/model/story_tag.dart';
import '../../common/components/tags.dart';

class StoryOverlayAppBar extends StatelessWidget {
  final StoryTags tags;

  const StoryOverlayAppBar({
    Key? key,
    required this.tags,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Column(
      children: [
        AppBar(
          title: Text('STORY'),
          titleTextStyle: text.subtitle1,
          toolbarHeight: 48,
          centerTitle: true,
          leading: IconButton(
            icon: BackIcon(),
            onPressed: () {
              context.pop();
            },
          ),
          backgroundColor: color.background,
          elevation: 0,
        ),
        StoryTagInfo(
          tags: tags,
        ),
      ],
    );
  }
}
