import 'package:climb_balance/providers/api.dart';
import 'package:climb_balance/providers/token.dart';
import 'package:climb_balance/utils/webView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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

  NaverLogin({Key? key, required this.toRegisterd}) : super(key: key);

  void onPress(BuildContext context, WidgetRef ref) async {
    await ref.read(serverProiver).getLoginHtml().catchError((err) {
      debugPrint(err.toString());
    }).then((html) async {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NaverWebView(html: html),
        ),
      ).then((res) => Navigator.popAndPushNamed(
          context, toRegisterd ? '/register' : '/home'));
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(const Color.fromRGBO(3, 199, 90, 1)),
      ),
      onPressed: () => {onPress(context, ref)},
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
