import 'dart:io';

import 'package:climb_balance/ui/widgets/avatarPicker.dart';
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
        title: const Text('전문가 계정 등록'),
        centerTitle: true,
      ),
      body: MySafeArea(
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
    );
  }
}

class ExpertForm extends StatefulWidget {
  const ExpertForm({Key? key}) : super(key: key);

  @override
  State<ExpertForm> createState() => _ExpertFormState();
}

class _ExpertFormState extends State<ExpertForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                Flexible(
                  child: AvatarPicker(
                    updateFile: (File image) {},
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value?.length != 4) {
                            return '코드는 영문 4글자 입니다.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: '클라이밍장 코드',
                        ),
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value?.length != 4) {
                            return '코드는 영문 4글자 입니다.';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: '이름',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
