import 'package:climb_balance/presentation/auth/components/guest_login.dart';
import 'package:climb_balance/presentation/auth/components/more_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'components/auth_logos.dart';
import 'components/naver_login.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/img/bg_img.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const AuthLogos(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              NaverLogin(),
              SizedBox(
                height: 8,
              ),
              GuestLogin(),
              SizedBox(
                height: 8,
              ),
              MoreInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
