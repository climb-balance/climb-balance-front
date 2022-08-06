import 'package:flutter/material.dart';

class SearchTextInput extends StatefulWidget {
  final String query;
  final void Function(String) handleQuery;

  const SearchTextInput(
      {Key? key, required this.query, required this.handleQuery})
      : super(key: key);

  @override
  State<SearchTextInput> createState() => _SearchTextInputState();
}

class _SearchTextInputState extends State<SearchTextInput> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.text = widget.query;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.search),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: TextField(
            controller: _controller,
            onChanged: widget.handleQuery,
          ),
        )
      ],
    );
  }
}
