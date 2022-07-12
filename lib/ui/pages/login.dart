import 'package:climb_balance/providers/token.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: NaverLogin(),
      ),
    );
  }
}

class NaverLogin extends ConsumerStatefulWidget {
  const NaverLogin({Key? key}) : super(key: key);

  @override
  NaverLoginState createState() => NaverLoginState();
}

class NaverLoginState extends ConsumerState<NaverLogin> {
  late bool toRegisted;
  late bool needLogin;

  @override
  void initState() {
    toRegisted = false;
    needLogin = ref.read(tokenProvider.notifier).isEmpty();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!needLogin) {
      Navigator.popAndPushNamed(context, '/main');
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {
              setState(() => {toRegisted = !toRegisted});
            },
            child: Text('to register : $toRegisted')),
        TextButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(const Color.fromRGBO(3, 199, 90, 1)),
          ),
          onPressed: () {
            ref
                .read(tokenProvider.notifier)
                .naverLogin()
                .then((isRegistered) => {
                      // for test
                      if (toRegisted)
                        {
                          // to main
                          Navigator.popAndPushNamed(context, '/main')
                        }
                      else
                        {Navigator.popAndPushNamed(context, '/register')}
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
        ),
      ],
    );
  }
}
