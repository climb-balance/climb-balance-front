import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../auth_provider.dart';

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
        ref.read(authProvider.notifier).onNaverLogin(context, ref, toRegisterd);
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