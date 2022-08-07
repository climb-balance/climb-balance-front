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
          Row(
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CodeTextInput(),
                    NameTextInput(),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            child: TextFormField(
              maxLines: 5,
              validator: (value) {
                if (value?.length != 4) {
                  return '코드는 영문 4글자 입니다.';
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: '경력 및 소개',
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('성공')),
                  );
                  Navigator.of(context).pop();
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('실패')),
                );
              },
              child: Text('등록하기'),
            ),
          ),
        ],
      ),
    );
  }
}

class CodeTextInput extends StatefulWidget {
  const CodeTextInput({Key? key}) : super(key: key);

  @override
  State<CodeTextInput> createState() => _CodeTextInputState();
}

class _CodeTextInputState extends State<CodeTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.length != 4) {
          return '4글자 입니다.';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: '클라이밍장 코드',
      ),
    );
  }
}

class NameTextInput extends StatefulWidget {
  const NameTextInput({Key? key}) : super(key: key);

  @override
  State<NameTextInput> createState() => _NameTextInputState();
}

class _NameTextInputState extends State<NameTextInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value?.length != 4) {
          return '코드는 영문 4글자 입니다.';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: '이름',
      ),
    );
  }
}
