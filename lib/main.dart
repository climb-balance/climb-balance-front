import 'package:climb_balance/domain/common/router_provider.dart';
import 'package:climb_balance/presentation/account/account_view_model.dart';
import 'package:climb_balance/presentation/common/ui/theme/main_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'domain/common/firebase_provider.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// 파이어베이스 백그라운드 메세지 핸들러
/// 아래 문서에 따라 최상위에 선언됨.
/// https://firebase.flutter.dev/docs/messaging/usage/#background-messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool darkMode =
        ref.watch(accountViewModelProvider.select((value) => value.darkMode));
    ref.read(firebaseProvider.notifier).initFirebase(context);

    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Climb Balance',
      theme: darkMode ? mainDarkTheme() : mainLightTheme(),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ko')],
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
