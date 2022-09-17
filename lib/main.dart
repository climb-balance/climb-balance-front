import 'package:climb_balance/domain/common/router_provider.dart';
import 'package:climb_balance/presentation/account/account_view_model.dart';
import 'package:climb_balance/presentation/common/ui/theme/main_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'domain/common/firebase_provider.dart';
import 'domain/const/route_name.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO move firebase logic to main
    bool darkMode =
        ref.watch(accountViewModelProvider.select((value) => value.darkMode));
    ref.read(firebaseProvider);
    FirebaseMessaging.onBackgroundMessage((message) async {});
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final data = message.data;

      if (data['notification_id'] == 'AI_COMPLETE') {
        final storyId = data['video_id'] ?? '1';
        context.goNamed(diaryStoryRouteName, params: {'sid': storyId});
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
