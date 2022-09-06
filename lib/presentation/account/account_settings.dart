import 'package:climb_balance/providers/settings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../providers/user_provider.dart';
import '../../ui/pages/account_page/expert_register/expert_register.dart';

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExpertRegister(),
              ),
            );
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
        ref.watch(settingsProvider.select((value) => value.expertMode));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('전문가 모드'),
        Switch(
          value: expertMode,
          onChanged: (bool value) {
            ref
                .read(settingsProvider.notifier)
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
    final isExpert = ref.watch(userProvider.select((value) => value.isExpert));
    return isExpert ? const ExpertSwap() : const RegisterExpert();
  }
}

class DarkModeSetting extends ConsumerWidget {
  const DarkModeSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool darkMode =
        ref.watch(settingsProvider.select((value) => value.darkMode));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('DarkMode'),
        Switch(
          value: darkMode,
          onChanged: (bool value) {
            ref.read(settingsProvider.notifier).updateSetting(darkMode: value);
          },
        ),
      ],
    );
  }
}

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
            ref.read(userProvider.notifier).clearToken();
            Navigator.pushNamedAndRemoveUntil(
                context, '/auth', (route) => false);
          },
        ),
      ],
    );
  }
}

class EditAccountSetting extends ConsumerWidget {
  const EditAccountSetting({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('계정 정보 수정'),
        OutlinedButton(
          child: const Text(
            '수정하기',
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
