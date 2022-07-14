import 'package:climb_balance/ui/pages/auth.dart';
import 'package:climb_balance/ui/pages/register.dart';
import 'package:flutter/material.dart';

class AuthRoute extends StatefulWidget {
  const AuthRoute({Key? key}) : super(key: key);

  @override
  State<AuthRoute> createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: authRoute,
    );
  }
}

Route authRoute(RouteSettings settings) {
  late Widget page;
  switch (settings.name) {
    case '/':
      page = Auth();
      break;
    case '/register':
      page = Register();
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
