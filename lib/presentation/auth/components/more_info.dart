import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        // TODO GO HOMEPAGE
        Fluttertoast.showToast(
          msg: "무언가 보여줘야함",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
        );
      },
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 1,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: color.onBackground,
              width: 1,
            ),
          ),
        ),
        child: Text(
          '클라임밸런스란?',
          style: text.bodyText2!,
        ),
      ),
    );
  }
}
