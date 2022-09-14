import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/naver_login.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  AuthState createState() => AuthState();
}

class AuthState extends ConsumerState<AuthScreen> {
  bool toRegister = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() => {toRegister = !toRegister});
              },
              child: Text('to register : $toRegister'),
            ),
            NaverLogin(toRegisterd: toRegister),
          ],
        ),
      ),
    );
  }
}
