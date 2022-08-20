import 'package:flutter/material.dart';

class SearchTextInput extends StatelessWidget {
  final void Function(String) handleQuery;

  const SearchTextInput({Key? key, required this.handleQuery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: TextField(
        onChanged: handleQuery,
        style: Theme.of(context).textTheme.subtitle2,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: '클라이밍장 이름을 입력하세요',
        ),
      ),
    );
  }
}
