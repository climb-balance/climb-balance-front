import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  final List<Widget> children;
  final String groupName;

  const SettingCard({Key? key, required this.children, required this.groupName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: theme.colorScheme.outline,
                  ),
                ),
              ),
              child: Text(
                groupName,
                style: theme.textTheme.titleMedium,
              ),
            ),
            ...children
          ],
        ),
      ),
    );
  }
}
