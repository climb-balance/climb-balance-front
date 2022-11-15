import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../story_view_model.dart';

class CommentWrite extends ConsumerWidget {
  final int storyId;

  const CommentWrite({Key? key, required this.storyId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => TextFieldModal(
            storyId: storyId,
          ),
        );
      },
      child: IgnorePointer(
        child: TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            labelText: '댓글을 입력하세요',
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}

class TextFieldModal extends ConsumerWidget {
  final int storyId;

  const TextFieldModal({Key? key, required this.storyId}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateCurrentComment =
        ref.read(storyViewModelProvider(storyId).notifier).updateCurrentComment;
    final addComment =
        ref.read(storyViewModelProvider(storyId).notifier).addComment;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: TextField(
          autofocus: true,
          onChanged: updateCurrentComment,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            labelText: '댓글을 입력하세요',
            suffixIcon: IconButton(
              onPressed: () {
                addComment(context);
              },
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      ),
    );
  }
}
