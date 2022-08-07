import 'dart:io';

import 'package:climb_balance/models/expert_profile.dart';
import 'package:climb_balance/providers/current_user.dart';
import 'package:climb_balance/providers/expert_register.dart';
import 'package:climb_balance/ui/widgets/avatarPicker.dart';
import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'expert_register_text_input.dart';

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

class ExpertForm extends ConsumerStatefulWidget {
  const ExpertForm({Key? key}) : super(key: key);

  @override
  ConsumerState<ExpertForm> createState() => _ExpertFormState();
}

class _ExpertFormState extends ConsumerState<ExpertForm> {
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
                  updateFile: (File image) {
                    ref
                        .read(expertRegisterProvider.notifier)
                        .updateProfilePicture(image);
                  },
                  image: ref.watch(
                      expertRegisterProvider.select((value) => value.tmpImage)),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    CodeTextInput(),
                    NickNameTextInput(),
                  ],
                ),
              ),
            ],
          ),
          const IntroduceTextInput(),
          ExpertRegisterButton(formKey: _formKey)
        ],
      ),
    );
  }
}

class ExpertRegisterButton extends ConsumerWidget {
  final GlobalKey<FormState> formKey;

  const ExpertRegisterButton({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('성공')),
            );

            final expertProfile = ref.watch(expertRegisterProvider);
            ref
                .read(currentUserProvider.notifier)
                .updateExpertInfo(ExpertProfile(
                  nickName: expertProfile.nickName,
                  introduce: expertProfile.introduce,
                ));
            ref.read(expertRegisterProvider.notifier).clear();
            debugPrint('여기까진 온다');
            Navigator.of(context).pop();
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('실패')),
          );
        },
        child: Text('등록하기'),
      ),
    );
  }
}
