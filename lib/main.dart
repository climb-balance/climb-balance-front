import 'package:climb_balance/data/data_source/service/server_service.dart';
import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/domain/common/downloader_provider.dart';
import 'package:climb_balance/domain/common/loading_provider.dart';
import 'package:climb_balance/domain/common/router_provider.dart';
import 'package:climb_balance/domain/common/uploader_provider.dart';
import 'package:climb_balance/presentation/common/components/waiting_progress.dart';
import 'package:climb_balance/presentation/common/ui/theme/main_theme.dart';
import 'package:climb_balance/presentation/splash_app/splash_screen.dart';
import 'package:climb_balance/presentation/splash_app/splash_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'domain/common/firebase_provider.dart';
import 'domain/common/local_notification_provider.dart';
import 'domain/util/platform_check.dart';
import 'firebase_options.dart';

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

/// 파이어베이스 백그라운드 메세지 핸들러
/// 아래 문서에 따라 최상위에 선언됨.
/// https://firebase.flutter.dev/docs/messaging/usage/#background-messages
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Handling a background message: ${message.messageId}");
}

const bool isProduction = bool.fromEnvironment('dart.vm.product');

void main() async {
  if (isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) => null;
  }

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  final container = ProviderContainer();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const SplashApp(),
    ),
  );
  final jobs = [
    () async {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    },
    () async {
      tz.initializeTimeZones();
    },
    container.read(currentUserProvider.notifier).init,
    container.read(serverServiceProvider).healthCheck,
  ];
  if (isMobile()) {
    jobs.add(container.read(downloaderProvider.notifier).mobileInit);
    jobs.add(container.read(uploaderProvider.notifier).mobileInit);
    jobs.add(container.read(localNotificationProvider.notifier).init);
  }
  await container.read(splashViewModelProvider.notifier).init(jobs: jobs);
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(firebaseProvider.notifier).initFirebase(context);
    ref.watch(localNotificationProvider);
    final bool loading =
        ref.watch(loadingProvider.select((value) => value.isLoading));
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      scaffoldMessengerKey: scaffoldMessengerKey,
      debugShowCheckedModeBanner: false,
      title: '클라임밸런스',
      theme: mainDarkTheme(),
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [Locale('en'), Locale('kr')],
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      builder: (context, widget) {
        if (isMobile()) {
          return Stack(
            children: [
              if (widget != null) widget,
              if (loading) const WaitingProgress()
            ],
          );
        }
        return FlutterWebFrame(
          backgroundColor: Colors.black,
          builder: (BuildContext context) => Stack(
            children: [
              if (widget != null) widget,
              if (loading) const WaitingProgress()
            ],
          ),
          maximumSize: const Size(475.0, 812.0),
        );
      },
    );
  }
}
