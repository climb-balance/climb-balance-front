import 'package:climb_balance/providers/current_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Test extends ConsumerWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('logout'),
          onPressed: () {
            ref.read(currentUserProvier.notifier).clearToken();
            Navigator.popAndPushNamed(context, '/auth');
          },
        ),
      ),
    );
  }
}
