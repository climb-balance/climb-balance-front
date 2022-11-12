import 'package:climb_balance/presentation/account/components/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../presentation/common/components/bot_navigation_bar.dart';
import 'components/account_settings.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
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
                children: [],
              ),
              const SettingCard(
                groupName: '계정 설정',
                children: [
                  ExpertSetting(),
                  LogoutSetting(),
                  RemoveAccountSetting(),
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
