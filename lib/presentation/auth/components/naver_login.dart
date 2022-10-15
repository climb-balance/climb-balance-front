import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/buttons.dart';
import '../auth_view_model.dart';

class NaverLogin extends ConsumerWidget {
  const NaverLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return FullSizeBtn(
      color: const Color.fromRGBO(3, 199, 90, 1),
      onPressed: () {
        ref.read(authViewModelProvider.notifier).onNaverLogin(context);
      },
      child: SizedBox(
        width: size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'N',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 20,
                color: color.onBackground,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '네이버로 시작하기',
              style: text.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
