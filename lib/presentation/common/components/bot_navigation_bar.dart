import 'package:climb_balance/domain/const/route_config.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../account/account_view_model.dart';
import '../../story_upload_screens/pick_video_screen.dart';

class BotNavigationBar extends ConsumerWidget {
  final int currentIdx;

  const BotNavigationBar({Key? key, required this.currentIdx})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isExpert =
        ref.watch(accountViewModelProvider.select((value) => value.expertMode));
    final List<String> paths = [
      homePageRoute,
      communityPageRoute,
      '',
      isExpert ? feedbackPageRoute : diaryPageRoute,
      accountPageRoute
    ];
    final color = Theme.of(context).colorScheme;
    final goRouter = GoRouter.of(context);
    return SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            BotNavigationBarItem(
              active: 0 == currentIdx,
              icon: Icon(Icons.home),
              onTap: () {
                goRouter.go(homePageRoute);
              },
              alignment: Alignment.bottomCenter,
            ),
            BotNavigationBarItem(
              active: 1 == currentIdx,
              icon: Icon(Icons.people),
              onTap: () {
                goRouter.go(communityPageRoute);
              },
            ),
            BotNavigationBarAddItem(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => const PickVideoScreen(),
                );
              },
            ),
            BotNavigationBarItem(
              active: 3 == currentIdx,
              icon: isExpert ? Icon(Icons.feedback) : Icon(Icons.menu_book),
              onTap: () {
                isExpert
                    ? goRouter.go(feedbackPageRoute)
                    : goRouter.go(diaryPageRoute);
              },
            ),
            BotNavigationBarItem(
              active: 4 == currentIdx,
              icon: Icon(Icons.account_box),
              onTap: () {
                goRouter.go(accountPageRoute);
              },
              alignment: Alignment.bottomCenter,
            ),
          ],
        ),
      ),
    );
  }
}

class BotNavigationBarAddItem extends StatelessWidget {
  final Function() onTap;

  const BotNavigationBarAddItem({Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                36,
              ),
              color: color.primary,
            ),
            child: IconButton(
              color: color.onPrimary,
              iconSize: 36,
              onPressed: onTap,
              icon: Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BotNavigationBarItem extends StatelessWidget {
  final bool active;
  final Widget icon;
  final Alignment alignment;
  final Color? activeColor;
  final Color? baseColor;
  final Function() onTap;

  const BotNavigationBarItem({
    Key? key,
    required this.active,
    required this.icon,
    this.alignment = Alignment.center,
    this.baseColor,
    this.activeColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      children: [
        Expanded(
          child: Align(
            child: IconButton(
              iconSize: 28,
              color: active ? (color.onBackground) : color.secondaryContainer,
              onPressed: onTap,
              icon: icon,
            ),
            alignment: alignment,
          ),
        ),
      ],
    );
  }
}
