import 'package:climb_balance/providers/mainRoute.dart';
import 'package:climb_balance/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                child: const Text('logout'),
                onPressed: () {
                  ref.read(tokenProvider.notifier).clearToken();
                  ref.read(mainRouteProvider.notifier).toAuth();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
