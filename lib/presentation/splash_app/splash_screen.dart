import 'package:climb_balance/presentation/splash_app/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../common/components/logo.dart';
import '../common/ui/theme/main_theme.dart';

class SplashApp extends ConsumerWidget {
  const SplashApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(splashViewModelProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: mainDarkTheme(),
      home: Scaffold(
        body: const SplashInfo(),
        bottomNavigationBar: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: state.error == null
                ? LinearProgressIndicator(
                    value: state.progress,
                  )
                : ErrorProgress(error: state.error!),
          ),
        ),
      ),
    );
  }
}

class ErrorProgress extends StatelessWidget {
  final String error;

  const ErrorProgress({Key? key, required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Text(
      '에러 : ${error}',
      style: TextStyle(color: color.error),
    );
  }
}

class SplashInfo extends StatelessWidget {
  const SplashInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Logo(),
          SizedBox(
            height: 30,
          ),
          Text(
            '클라임밸런스',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 30,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '클라이밍을 기록하다',
            style: TextStyle(
              fontSize: 18,
            ),
          )
        ],
      ),
    );
  }
}
