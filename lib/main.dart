import 'package:climb_balance/common/provider/router_provider.dart';
import 'package:climb_balance/presentation/story/story_screen.dart';
import 'package:climb_balance/providers/feedback_status.dart';
import 'package:climb_balance/providers/firebase.dart';
import 'package:climb_balance/providers/settings.dart';
import 'package:climb_balance/services/server_service.dart';
import 'package:climb_balance/ui/theme/main_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO move firebase logic to main
    bool darkMode =
        ref.watch(settingsProvider.select((value) => value.darkMode));
    ref.read(firebaseProvider);
    FirebaseMessaging.onBackgroundMessage((message) async {});
    FirebaseMessaging.onMessageOpenedApp.listen((message) async {
      final data = message.data;

      if (data['notification_id'] == 'AI_COMPLETE') {}
      ref.read(feedbackStatusProvider.notifier).clearTimer();
      final result = await ServerService.getStory(data['video_id'] ?? 1);
      result.when(
        success: (story) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => StoryScreen(
                story: story,
                handleBack: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          );
        },
        error: (message) {},
      );
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
