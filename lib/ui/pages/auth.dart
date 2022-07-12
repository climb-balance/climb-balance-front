import 'package:climb_balance/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Auth extends ConsumerStatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  AuthState createState() => AuthState();
}

class AuthState extends ConsumerState<Auth> {
  bool toRegisterd = false;

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
                setState(() => {toRegisterd = !toRegisterd});
              },
              child: Text('to register : $toRegisterd'),
            ),
            NaverLogin(toRegisterd: toRegisterd),
          ],
        ),
      ),
    );
  }
}

class NaverLogin extends ConsumerWidget {
  final bool toRegisterd;

  const NaverLogin({Key? key, required this.toRegisterd}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromRGBO(3, 199, 90, 1)),
      ),
      onPressed: () {
        ref.read(tokenProvider.notifier).naverLogin().then((isRegistered) => {
              // for test
              if (toRegisterd)
                {
                  // to main
                  Navigator.popAndPushNamed(context, '/register')
                }
              else
                {Navigator.popAndPushNamed(context, '/home')}
            });
      },
      child: SizedBox(
        width: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: const [
            Text(
              'N',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
            Text(
              '네이버로 시작하기',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
