import 'package:flutter/material.dart';

class GuestCodeModal extends StatefulWidget {
  const GuestCodeModal({Key? key}) : super(key: key);

  @override
  State<GuestCodeModal> createState() => _GuestCodeModalState();
}

class _GuestCodeModalState extends State<GuestCodeModal> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('게스트 접속 코드'),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          child: const Text('접속'),
        ),
      ],
    );
  }
}
