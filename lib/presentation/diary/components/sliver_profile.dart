import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/current_user_provider.dart';
import '../../common/components/user_profile_info.dart';
import 'edit_profile.dart';

class SliverProfile extends ConsumerWidget {
  const SliverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref
        .watch(diaryViewModelProvider.select((value) => value.isEditingMode));
    return SliverAppBar(
      backgroundColor: Colors.transparent,
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
      toolbarHeight: 120,
      flexibleSpace: isEditMode
          ? const EditProfile()
          : TopProfileInfo(
              user: ref.watch(currentUserProvider),
              onEdit: ref.read(diaryViewModelProvider.notifier).onEditMode,
            ),
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
          Icons.filter_alt,
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
                  Icons.filter_alt,
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
