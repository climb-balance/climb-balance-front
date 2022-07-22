import 'package:climb_balance/routes/mainRoute.dart';
import 'package:climb_balance/ui/theme/mainTheme.dart';
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
      theme: false ? mainDarkTheme() : mainLightTheme(),
      initialRoute: '/',
      routes: {
        '/': (_) => MainRoute(),
      },
    );
  }
}
