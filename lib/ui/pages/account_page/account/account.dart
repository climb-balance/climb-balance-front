import 'package:climb_balance/ui/pages/account_page/account/setting_card.dart';
import 'package:climb_balance/ui/widgets/bot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/user_provider.dart';
import 'account_settings.dart';

class Account extends ConsumerStatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  ConsumerState<Account> createState() => AccountState();
}

class AccountState extends ConsumerState<Account> {
  @override
  Widget build(BuildContext context) {
    final isExpert = ref.watch(userProvider.select((value) => value.isExpert));
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
                  ExpertSetting(),
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
