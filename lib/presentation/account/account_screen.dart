import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/presentation/account/components/setting_card.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../presentation/common/components/bot_navigation_bar.dart';
import 'components/account_infos.dart';
import 'components/account_settings.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final rank = ref.watch(currentUserProvider.select((value) => value.rank));
    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SettingCard(
                groupName: '현재 계정 정보',
                children: [
                  AccountEmail(),
                  AccountPersonal(),
                  AccountPromotion(),
                ],
              ),
              SettingCard(
                groupName: '계정 설정',
                children: [
                  const ExpertSetting(),
                  const LogoutSetting(),
                  if (rank != -1) const RemoveAccountSetting(),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                            'https://www.climb-balance.com/policy/service'),
                      );
                    },
                    child: const Text("이용 약관"),
                  ),
                  TextButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                            'https://www.climb-balance.com/policy/privacy'),
                      );
                    },
                    child: const Text("개인정보 처리방침"),
                  ),
                  TextButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                            'mailto:admin@climb-balance.com?subject=News&body=New%20plugin'),
                      );
                    },
                    child: const Text("문의하기"),
                  ),
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
