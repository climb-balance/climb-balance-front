import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  final String? imagePath;
  final void Function(String) updateImagePath;

  const AvatarPicker({Key? key, this.imagePath, required this.updateImagePath})
      : super(key: key);

  @override
  State<AvatarPicker> createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  void getImage() {
    final picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((image) {
      widget.updateImagePath(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: getImage,
          child: widget.imagePath == null
              ? const NoAvatar()
              : CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: FileImage(File(widget.imagePath!)),
                ),
        ),
      ],
    );
  }
}

class NoAvatar extends StatelessWidget {
  const NoAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color.surface,
      ),
      child: Icon(
        Icons.image_search,
        size: 60,
        color: color.surfaceVariant,
      ),
    );
  }
}
