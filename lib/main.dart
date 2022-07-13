import 'package:climb_balance/providers/async_status.dart';
import 'package:climb_balance/providers/token.dart';
import 'package:climb_balance/ui/pages/auth.dart';
import 'package:climb_balance/ui/pages/home.dart';
import 'package:climb_balance/ui/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

class MyRoute extends ConsumerWidget {
  MyRoute({Key? key}) : super(key: key);
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(asyncStatusProvider, (_, next) {
      if (next == true) {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(),
              ),
            ],
          ),
        );
      } else {
        Navigator.of(context).pop();
      }
    });
    return Navigator(
      key: _navigatorKey,
      initialRoute:
          ref.read(tokenProvider.notifier).isEmpty() ? '/auth' : '/home',
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    debugPrint(settings.name);
    switch (settings.name) {
      case '/auth':
        page = Auth();
        break;
      case '/auth/register':
        page = Register();
        break;
      case '/home':
        page = Home();
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
