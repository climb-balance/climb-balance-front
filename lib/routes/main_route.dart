import 'package:climb_balance/providers/user_provider.dart';
import 'package:climb_balance/routes/route_config.dart';
import 'package:climb_balance/ui/pages/account_page/account/account.dart';
import 'package:climb_balance/ui/pages/community/community.dart';
import 'package:climb_balance/ui/pages/diary_page/diary/diary.dart';
import 'package:climb_balance/ui/pages/feedback_page/feedback_list/feedback_list.dart';
import 'package:climb_balance/ui/pages/testPage/testPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../ui/pages/auth/auth.dart';
import '../ui/pages/home_page/home/home.dart';

class MainRoute extends ConsumerWidget {
  MainRoute({Key? key}) : super(key: key);
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final token = ref.watch(userProvider.select((value) => value.token));
    return WillPopScope(
      onWillPop: () async {
        return !await _navigatorKey.currentState!.maybePop();
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: token == '' ? HOME_PAGE_PATH : HOME_PAGE_PATH,
        //ref.read(tokenProvider.notifier).isEmpty() ? '/auth' : '/home',
        onGenerateRoute: mainRoute,
      ),
    );
  }
}

Route mainRoute(RouteSettings settings) {
  late Widget page;
  debugPrint(settings.name);
  switch (settings.name) {
    case '/testpage':
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => TestPage(),
      );
    case AUTH_PAGE_PATH:
      page = const Auth();
      break;
    case HOME_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => Home(),
      );
    case COMMUNITY_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => Community(),
      );
    case DIARY_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => Diary(),
      );
    case ACCOUNT_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => Account(),
      );
    case FEEDBACK_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => FeedbackList(),
      );
    default:
      page = Container();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
}
