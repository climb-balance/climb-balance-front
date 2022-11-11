import 'package:flutter/material.dart';

import '../../../domain/model/tag_selector.dart';

class PickItem extends StatelessWidget {
  final Selector data;

  const PickItem({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Center(
      child: Container(
        height: 40,
        width: size.width - 80,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: theme.colorScheme.surface,
            ),
            top: BorderSide(
              color: theme.colorScheme.surface,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () {
            Navigator.of(context).pop(data.id);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 15,
                width: 15,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: data.selectColors,
                  ),
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                data.name,
                style: theme.textTheme.subtitle2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
