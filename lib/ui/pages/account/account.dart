import 'package:climb_balance/providers/settings.dart';
import 'package:climb_balance/ui/widgets/botNavigationBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Account extends ConsumerStatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  AccountState createState() => AccountState();
}

class AccountState extends ConsumerState {
  @override
  Widget build(BuildContext context) {
    Settings settings = ref.watch(settingsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('설정'),
      ),
      body: SafeArea(
        minimum: EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Center(
          child: ListView(
            children: [
              Row(
                children: [
                  Text('DarkMode'),
                  Switch(
                    value: settings.darkMode,
                    onChanged: (bool value) {
                      ref
                          .read(settingsProvider.notifier)
                          .updateSetting(darkMode: value);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BotNavigationBar(currentIdx: 4),
    );
  }
}
