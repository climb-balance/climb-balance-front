import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:climb_balance/providers/token.dart';
import 'package:climb_balance/routes/authRoute.dart';
import 'package:climb_balance/ui/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainRoute extends ConsumerWidget {
  MainRoute({Key? key}) : super(key: key);
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
          '/home', //ref.read(tokenProvider.notifier).isEmpty() ? '/auth' : '/home',
      onGenerateRoute: mainRoute,
    );
  }
}

Route mainRoute(RouteSettings settings) {
  late Widget page;
  debugPrint(settings.name);
  switch (settings.name) {
    case '/auth':
      page = AuthRoute();
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
