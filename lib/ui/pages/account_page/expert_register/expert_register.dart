import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:flutter/material.dart';

class ExpertRegister extends StatefulWidget {
  const ExpertRegister({Key? key}) : super(key: key);

  @override
  State<ExpertRegister> createState() => _ExpertRegisterState();
}

class _ExpertRegisterState extends State<ExpertRegister> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: MySafeArea(
        child: Center(
          child: Column(
            children: [
              Text(
                '전문가 정보를 입력해주세요.',
                style: theme.textTheme.headline5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
