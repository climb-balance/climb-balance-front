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
      appBar: AppBar(
        title: Text('전문가 계정 등록'),
        centerTitle: true,
      ),
      body: MySafeArea(
        child: Column(
          children: [
            Text(
              '제휴 클라이밍장 소속이라면 언제든지 전문가 계정이 될 수 있습니다.',
              style: theme.textTheme.headline6,
            ),
          ],
        ),
      ),
    );
  }
}
