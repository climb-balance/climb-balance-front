import 'package:climb_balance/configs/routeConfig.dart';
import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:climb_balance/providers/mainRoute.dart';
import 'package:climb_balance/routes/authRoute.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:climb_balance/ui/pages/home/account.dart';
import '../ui/pages/home/home.dart';

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
    //ref.read(mainRouteProvider.notifier).updateNavigator(_navigatorKey);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future(() => false);
      },
      child: Navigator(
        key: _navigatorKey,
        initialRoute: '/home',
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
    case '/auth':
      page = AuthRoute();
      break;
    case HOME_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => Home(),
      );
    case ACCOUNT_PAGE_PATH:
      return PageRouteBuilder(
        settings: settings,
        // Pass this to make popUntil(), pushNamedAndRemoveUntil(), works
        pageBuilder: (_, __, ___) => Account(),
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
