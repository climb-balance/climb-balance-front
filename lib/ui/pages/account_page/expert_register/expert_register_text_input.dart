import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/expert_register.dart';

class CodeTextInput extends ConsumerStatefulWidget {
  const CodeTextInput({Key? key}) : super(key: key);

  @override
  ConsumerState<CodeTextInput> createState() => _CodeTextInputState();
}

class _CodeTextInputState extends ConsumerState<CodeTextInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref
          .read(expertRegisterProvider.notifier)
          .updateClimbingCode(_controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
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

class NickNameTextInput extends ConsumerStatefulWidget {
  const NickNameTextInput({Key? key}) : super(key: key);

  @override
  ConsumerState<NickNameTextInput> createState() => _NickNameTextInputState();
}

class _NickNameTextInputState extends ConsumerState<NickNameTextInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref
          .read(expertRegisterProvider.notifier)
          .updateNickname(_controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: (value) {
        if (value == null || value.length < 2) {
          return '이륨은 최소 2글자 입니다.';
        }
        return null;
      },
      decoration: const InputDecoration(
        labelText: '이름',
      ),
    );
  }
}

class IntroduceTextInput extends ConsumerStatefulWidget {
  const IntroduceTextInput({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _IntroduceTextInputState();
}

class _IntroduceTextInputState extends ConsumerState<IntroduceTextInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      ref
          .read(expertRegisterProvider.notifier)
          .updateDescription(_controller.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        controller: _controller,
        maxLines: 5,
        validator: (value) {
          // TODO 조건 바꾸기
          if (value == null || value.length < 2) {
            return '글자 수가 20글자 이상이여야 합니다.';
          }
          return null;
        },
        decoration: const InputDecoration(
          labelText: '경력 및 소개',
        ),
      ),
    );
  }
}
