import 'package:climb_balance/presentation/auth/components/guest_login.dart';
import 'package:climb_balance/presentation/auth/components/more_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/util/platform_check.dart';
import 'components/auth_logos.dart';
import 'components/naver_login.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('assets/img/bg_img.png'),
          fit: BoxFit.fill,
        ),
        color: color.background,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: const AuthLogos(),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isMobile()) const NaverLogin(),
              const SizedBox(
                height: 8,
              ),
              const GuestLogin(),
              const SizedBox(
                height: 8,
              ),
              const MoreInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
