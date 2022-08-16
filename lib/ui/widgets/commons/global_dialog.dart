import 'package:flutter/material.dart';

Widget customAlertDialog(BuildContext context,
    {String title = '알 수 없는 에러', String content = '호에에엥'}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('확인'),
      ),
    ],
  );
}

Widget customConfirmDialog(BuildContext context,
    {String title = '알 수 없는 에러', String content = '호에에엥'}) {
  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: <Widget>[
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: const Text('취소'),
      ),
      TextButton(
        onPressed: () => Navigator.pop(context, true),
        child: const Text('확인'),
      ),
    ],
  );
}

Future<bool> customShowConfirm(
    {required BuildContext context,
    required String title,
    required String content}) async {
  bool result = await showDialog<bool>(
        context: context,
        builder: (context) => customConfirmDialog(
          context,
          title: title,
          content: content,
        ),
      ) ??
      false;
  return result;
}

void customShowDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  showDialog(
    context: context,
    builder: (context) => customAlertDialog(
      context,
      title: title,
      content: content,
    ),
  );
}
