import 'package:climb_balance/ui/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModalDataPicker<T> extends ConsumerStatefulWidget {
  void Function(T) handleData;
  List<T> datas;
  T initData;

  ModalDataPicker(
      {Key? key,
      required this.handleData,
      required this.datas,
      required this.initData})
      : super(key: key);

  @override
  ConsumerState<ModalDataPicker> createState() => _ModalDataPickerState();
}

class _ModalDataPickerState<T> extends ConsumerState<ModalDataPicker> {
  late T data;
  String query = '';

  @override
  void initState() {
    data = widget.initData;
    super.initState();
  }

  void updateQuery(String query) {
    setState(() {
      this.query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('alert title'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Save'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel')),
      ],
      content: Column(
        children: [
          SearchTextInput(
            query: query,
            handleQuery: updateQuery,
          ),
        ],
      ),
    );
  }
}
