import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/avatar_picker.dart';

class EditProfile extends ConsumerWidget {
  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref
        .watch(diaryViewModelProvider.select((value) => value.editingProfile))!;
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Stack(
          children: [
            AvatarPickerNetwork(
              getImage: ref
                  .read(diaryViewModelProvider.notifier)
                  .updateProfileImagePath,
              imagePath: user.profileImage,
            ),
            IgnorePointer(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Center(
                  child: Icon(
                    Icons.edit,
                    size: 36,
                    color: color.onSurface.withOpacity(0.8),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          width: 16,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: TextFieldWithDefaultValue(
                    initialValue: user.nickname,
                    style: text.headline5,
                    onChanged: ref
                        .read(diaryViewModelProvider.notifier)
                        .updateNickname,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 200,
              child: TextFieldWithDefaultValue(
                initialValue: user.description,
                onChanged:
                    ref.read(diaryViewModelProvider.notifier).updateDescription,
                style: text.bodyText2,
              ),
            ),
            Text('${user.height}cm | ${user.weight}kg'),
          ],
        ),
      ],
    );
  }
}

class TextFieldWithDefaultValue extends StatefulWidget {
  final String initialValue;
  final TextStyle? style;
  final void Function(String) onChanged;

  const TextFieldWithDefaultValue(
      {Key? key,
      required this.initialValue,
      this.style,
      required this.onChanged})
      : super(key: key);

  @override
  State<TextFieldWithDefaultValue> createState() =>
      _TextFieldWithDefaultValueState();
}

class _TextFieldWithDefaultValueState extends State<TextFieldWithDefaultValue> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.all(0),
      ),
      controller: _controller,
      style: widget.style,
      onChanged: widget.onChanged,
    );
  }
}
