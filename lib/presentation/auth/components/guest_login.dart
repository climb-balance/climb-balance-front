import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/buttons.dart';
import '../auth_view_model.dart';

class GuestLogin extends ConsumerWidget {
  const GuestLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return FullSizeBtn(
      color: color.surface,
      onPressed: () {
        ref.read(authViewModelProvider.notifier).onGuestLogin(context);
      },
      child: SizedBox(
        width: size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.no_accounts,
              color: color.onSurface,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              '게스트로 시작하기',
              style: text.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
