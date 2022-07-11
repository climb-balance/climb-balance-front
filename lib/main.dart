import 'package:climb_balance/ui/pages/login.dart';
import 'package:climb_balance/ui/pages/test.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => MyRoute(),
      },
    );
  }
}

class MyRoute extends StatelessWidget {
  MyRoute({Key? key}) : super(key: key);
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      initialRoute: '/auth',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case '/login':
        page = Login();
        break;
      case '/main':
        page = Test();
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
