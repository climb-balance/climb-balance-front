import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/current_user_provider.dart';
import '../../common/components/user_profile_info.dart';
import 'diary_filter_mdoal.dart';
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
            ),
    );
  }
}

class ProfileOptions extends ConsumerWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final onEdit = ref.read(diaryViewModelProvider.notifier).onEditMode;
    final endEdit = ref.read(diaryViewModelProvider.notifier).endEditMode;
    final isEditMode = ref
        .watch(diaryViewModelProvider.select((value) => value.isEditingMode));
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        children: [
          isEditMode
              ? IconButton(onPressed: endEdit, icon: const Icon(Icons.check))
              : IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: theme.colorScheme.onBackground,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => const DiaryFilterModal(),
              );
            },
          ),
        ],
      ),
    );
  }
}
