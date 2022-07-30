import 'package:climb_balance/providers/settings.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers/token.dart';

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
            children: const [
              SettingCard(
                groupName: '기기 설정',
                children: [
                  DarkModeSetting(),
                ],
              ),
              SettingCard(
                groupName: '계정 설정',
                children: [
                  EditAccountSetting(),
                  LogoutSetting(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotNavigationBar(currentIdx: 4),
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
            'logout',
            style: TextStyle(
              color: theme.colorScheme.onSecondary,
            ),
          ),
          onPressed: () {
            ref.read(tokenProvider.notifier).clearToken();
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
