import 'package:flutter/material.dart';

import '../../../../presentation/common/components/safe_area.dart';
import 'components/expert_form.dart';

class ExpertRegisterScreen extends StatelessWidget {
  const ExpertRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('전문가 계정 등록'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: MySafeArea(
          child: Column(
            children: [
              Text(
                '제휴 클라이밍장 소속이라면 언제든지 전문가 계정이 될 수 있습니다.',
                style: theme.textTheme.headline6,
              ),
              const ExpertForm(),
            ],
          ),
        ),
      ),
    );
  }
}
