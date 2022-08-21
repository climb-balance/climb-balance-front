import 'package:flutter/material.dart';

class SearchTextInput extends StatefulWidget {
  final void Function(String) handleQuery;
  final String searchLabel;

  const SearchTextInput({
    Key? key,
    required this.handleQuery,
    required this.searchLabel,
  }) : super(key: key);

  @override
  State<SearchTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      debugPrint(_controller.value.text);
      widget.handleQuery(_controller.value.text);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: TextField(
        controller: _controller,
        onChanged: widget.handleQuery,
        style: Theme.of(context).textTheme.subtitle2,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: widget.searchLabel,
        ),
      ),
    );
  }
}
