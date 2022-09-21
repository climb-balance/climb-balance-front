import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomTextInput extends ConsumerStatefulWidget {
  final void Function(String) handleUpdate;
  final String? Function(String?) checkValue;
  final String label;
  final int maxLines;

  const CustomTextInput({
    Key? key,
    required this.handleUpdate,
    required this.checkValue,
    required this.label,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  ConsumerState<CustomTextInput> createState() => _CustomTextInput();
}

class _CustomTextInput extends ConsumerState<CustomTextInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.handleUpdate(_controller.value.text);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(() {});
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      validator: widget.checkValue,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      maxLines: widget.maxLines,
    );
  }
}
