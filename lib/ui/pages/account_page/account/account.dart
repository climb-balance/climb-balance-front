import 'package:climb_balance/providers/settings.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/current_user.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => AccountState();
}

class AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SettingCard(
                groupName: '기기 설정',
                children: [
                  DarkModeSetting(),
                ],
              ),
              const SettingCard(
                groupName: '계정 설정',
                children: [
                  EditAccountSetting(),
                  LogoutSetting(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {}, child: const Text("이용 약관")),
                  TextButton(onPressed: () {}, child: const Text("개인정보 처리방침")),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BotNavigationBar(currentIdx: 4),
    );
  }
}

class SettingCard extends StatelessWidget {
  final List<Widget> children;
  final String groupName;

  const SettingCard({Key? key, required this.children, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              child: Text(
                groupName,
                style: theme.textTheme.titleMedium,
              ),
            ),
            ...children
          ],
        ),
      ),
    );
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

class ExpertSetting extends ConsumerWidget {
  const ExpertSetting({
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
            ref.read(currentUserProvider.notifier).clearToken();
            Navigator.pushNamedAndRemoveUntil(
                context, '/auth', (route) => false);
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
            ref.read(currentUserProvider.notifier).clearToken();
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
