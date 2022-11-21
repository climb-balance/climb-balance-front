import 'package:climb_balance/presentation/home/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/logo.dart';

class HomeAppBar extends ConsumerWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      toolbarHeight: 100,
      elevation: 0,
      title: const SizedBox(
        width: 24,
        child: Logo(),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 4,
          ),
          child: IconButton(
            icon: NotificationIcon(
              unread: ref
                  .watch(homeViewModelProvider.select((value) => value.unread)),
            ),
            onPressed: () {
              // LocalNotificationNotifier.showProgress(10);
            },
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class NotificationIcon extends StatelessWidget {
  final int unread;

  const NotificationIcon({Key? key, required this.unread}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      width: 30,
      height: 30,
      child: Stack(
        children: [
          const Icon(
            Icons.notifications_outlined,
            size: 24,
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.primary,
              ),
              child: Center(
                child: Text(
                  unread.toString(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: color.onPrimary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
