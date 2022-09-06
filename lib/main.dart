import 'package:climb_balance/common/provider/router_provider.dart';
import 'package:climb_balance/ui/theme/main_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/const/route_name.dart';
import 'common/provider/firebase_provider.dart';
import 'common/provider/settings_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO move firebase logic to main
    bool darkMode =
        ref.watch(settingsProvider.select((value) => value.darkMode));
    ref.read(firebaseProvider);
    FirebaseMessaging.onBackgroundMessage((message) async {});
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final data = message.data;

      if (data['notification_id'] == 'AI_COMPLETE') {
        final storyId = data['video_id'] ?? '1';
        context.goNamed(diaryStoryName, params: {'sid': storyId});
      }
    });
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: darkMode ? mainDarkTheme() : mainLightTheme(),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('ko')],
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
