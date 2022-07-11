import 'package:climb_balance/providers/login.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class NaverLogin extends ConsumerStatefulWidget {
  const NaverLogin({Key? key}) : super(key: key);

  @override
  NaverLoginState createState() => NaverLoginState();
}

class NaverLoginState extends ConsumerState<NaverLogin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ref.read(authProvider.notifier).naverLogin();
      },
      child: Text('네이버 아이디로 로그인하기'),
    );
  }
}
