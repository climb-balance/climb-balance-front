import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final File? image;
  final void Function(File) updateFile;

  const AvatarPicker({Key? key, this.image, required this.updateFile})
      : super(key: key);

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  void getImage() {
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((image) {
      widget.updateFile(File(image!.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: getImage,
      child: widget.image == null
          ? const NoAvatar()
          : CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              backgroundImage: FileImage(widget.image!),
            ),
    );
  }
}

class NoAvatar extends StatelessWidget {
  const NoAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return CircleAvatar(
      backgroundColor: theme.colorScheme.secondary,
      radius: 60,
      child: const Icon(Icons.photo_sharp, size: 60),
    );
  }
}
