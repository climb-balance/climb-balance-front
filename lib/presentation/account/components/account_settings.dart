import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/presentation/account/account_view_model.dart';
import 'package:climb_balance/presentation/common/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/const/route_name.dart';

class RegisterExpert extends StatelessWidget {
  const RegisterExpert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('전문가 등록'),
        ElevatedButton(
          child: const Text(
            '등록하기',
          ),
          onPressed: () {
            context.pushNamed(accountExpertRegisterRouteName);
          },
        ),
      ],
    );
  }
}

class ExpertSwap extends ConsumerWidget {
  const ExpertSwap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expertMode =
        ref.watch(accountViewModelProvider.select((value) => value.expertMode));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('전문가 모드'),
        Switch(
          value: expertMode,
          onChanged: (bool value) {
            ref
                .read(accountViewModelProvider.notifier)
                .updateSetting(expertMode: value);
          },
        ),
      ],
    );
  }
}

class ExpertSetting extends ConsumerWidget {
  const ExpertSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpert =
        ref.watch(currentUserProvider.select((value) => value.isExpert));
    return isExpert ? const ExpertSwap() : const RegisterExpert();
  }
}
//
// class DarkModeSetting extends ConsumerWidget {
//   const DarkModeSetting({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool darkMode =
//         ref.watch(accountViewModelProvider.select((value) => value.darkMode));
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         const Text('DarkMode'),
//         Switch(
//           value: darkMode,
//           onChanged: (bool value) {
//             ref
//                 .read(accountViewModelProvider.notifier)
//                 .updateSetting(darkMode: value);
//           },
//         ),
//       ],
//     );
//   }
// }

class LogoutSetting extends ConsumerWidget {
  const LogoutSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('로그아웃'),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(theme.colorScheme.secondary),
          ),
          child: Text(
            '로그아웃',
            style: TextStyle(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          onPressed: () {
            ref.read(currentUserProvider.notifier).logout(context);
          },
        ),
      ],
    );
  }
}

class RemoveAccountSetting extends ConsumerWidget {
  const RemoveAccountSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('회원탈퇴'),
        OutlinedButton(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(theme.colorScheme.errorContainer),
          ),
          child: Text(
            '회원탈퇴',
            style: TextStyle(
              color: theme.colorScheme.onErrorContainer,
            ),
          ),
          onPressed: () async {
            final result = await customShowConfirm(
              context: context,
              title: '정말로 탈퇴하시겠습니까?',
              content: '모든 기록이 말소됩니다.',
            );
            if (!result) return;

            ref.read(currentUserProvider.notifier).removeUserAccount(context);
          },
        ),
      ],
    );
  }
}
