import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomTextInput extends ConsumerStatefulWidget {
  final void Function(String) onChanged;
  final String? Function(String?) checkValue;
  final int maxLines;

  const CustomTextInput({
    Key? key,
    required this.onChanged,
    required this.checkValue,
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
      widget.onChanged(_controller.value.text);
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
    final color = Theme.of(context).colorScheme;
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: _controller,
      validator: widget.checkValue,
      decoration: InputDecoration(
        filled: true,
        fillColor: color.surface,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      maxLines: widget.maxLines,
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '')
      return TextEditingValue().copyWith(text: '160');
    else if (int.parse(newValue.text) < 100)
      return TextEditingValue().copyWith(text: '100');

    return int.parse(newValue.text) > 200
        ? TextEditingValue().copyWith(text: '200')
        : newValue;
  }
}

class CustomRangeNumberField extends StatefulWidget {
  final int value;
  final int maxValue;
  final int minValue;
  final void Function(int) onChange;
  final String errorText;

  const CustomRangeNumberField({
    Key? key,
    required this.value,
    required this.errorText,
    required this.onChange,
    required this.maxValue,
    required this.minValue,
  }) : super(key: key);

  @override
  State<CustomRangeNumberField> createState() => _CustomRangeNumberFieldState();
}

class _CustomRangeNumberFieldState extends State<CustomRangeNumberField> {
  late final TextEditingController _controller;
  bool _validate = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value.toString());
    if (widget.value <= widget.maxValue && widget.value >= widget.minValue) {
      _validate = true;
    } else {
      _validate = false;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return SizedBox(
      width: 135,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: TextField(
          controller: _controller,
          inputFormatters: [
            LengthLimitingTextInputFormatter(3),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (rawValue) {
            int value = int.parse(rawValue);
            widget.onChange(value);
            if (value <= widget.maxValue && value >= widget.minValue) {
              _validate = true;
            } else {
              _validate = false;
            }
            setState(() {});
          },
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            errorText: _validate ? null : widget.errorText,
            filled: true,
            fillColor: color.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          style: text.headline3,
        ),
      ),
    );
  }
}
