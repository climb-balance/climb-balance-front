import 'package:flutter/material.dart';

Widget customAlertDialog(BuildContext context,
    {String title = '알 수 없는 에러', String content = '호에에엥'}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, 'OK'),
        child: const Text('OK'),
      ),
    ],
  );
}
