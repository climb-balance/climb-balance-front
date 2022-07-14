import 'package:climb_balance/ui/pages/auth.dart';
import 'package:climb_balance/ui/pages/register.dart';
import 'package:flutter/material.dart';

class AuthRoute extends StatefulWidget {
  const AuthRoute({Key? key}) : super(key: key);

  @override
  State<AuthRoute> createState() => _AuthState();
}

class _AuthState extends State<AuthRoute> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    debugPrint(settings.name);
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
}
