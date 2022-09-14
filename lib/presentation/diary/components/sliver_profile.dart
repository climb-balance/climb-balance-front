import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common/provider/current_user_provider.dart';
import '../../common/components/user_profile_info.dart';

class SliverProfile extends ConsumerWidget {
  const SliverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverAppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: const [
              ProfileOptions(),
            ],
          ),
        ),
      ],
      toolbarHeight: 150,
      flexibleSpace: TopProfileInfo(user: ref.watch(currentUserProvider)),
    );
  }
}

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topRight,
      child: PopupMenuButton<int>(
        icon: Icon(
          Icons.more_vert,
          color: theme.colorScheme.onBackground,
        ),
        itemBuilder: (context) => [
          // popupmenu item 1
          PopupMenuItem(
            value: 1,
            // row has two child icon and text.
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  color: theme.colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("수정하기")
              ],
            ),
          ),
          // popupmenu item 2
          PopupMenuItem(
            value: 2,
            // row has two child icon and text
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Icon(
                  Icons.notifications,
                  color: theme.colorScheme.onBackground,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text("알림"),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "2",
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
        elevation: 2,
      ),
    );
  }
}