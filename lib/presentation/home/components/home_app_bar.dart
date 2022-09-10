import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class HomeAppBar extends StatelessWidget with PreferredSizeWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 5,
          ),
          Container(
            height: 25,
            width: 25,
            child: SvgPicture.asset(
              'assets/logo.svg',
              color: theme.colorScheme.primary,
            ),
          ),
          Text(
            '클라임밸런스',
            style: TextStyle(
              color: theme.colorScheme.onBackground,
            ),
          ),
        ],
      ),
      actions: [
        InkWell(
          onTap: () {
            context.go('/');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: theme.colorScheme.primary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
          child: Icon(
            Icons.notifications,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
