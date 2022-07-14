import 'package:climb_balance/ui/pages/home/account.dart';
import 'package:flutter/material.dart';
import '../ui/pages/home/home.dart';
import '../ui/pages/home/upload.dart';

class HomeRoute extends StatefulWidget {
  const HomeRoute({Key? key}) : super(key: key);

  @override
  State<HomeRoute> createState() => _HomeRouteState();
}

class _HomeRouteState extends State<HomeRoute> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: homeRoute,
    );
  }
}

Route homeRoute(RouteSettings settings) {
  late Widget page;
  debugPrint('home:${settings.name}');
  switch (settings.name) {
    case '/':
      page = Home();
      break;
    case '/upload':
      page = Upload();
      break;
    case '/account':
      page = Account();
      break;
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
