import 'package:flutter/material.dart';

class ContinuousStatistics extends StatefulWidget {
  final List<int> datas;

  const ContinuousStatistics({Key? key, required this.datas}) : super(key: key);

  @override
  State<ContinuousStatistics> createState() => _ContinuousStatisticsState();
}

class _ContinuousStatisticsState extends State<ContinuousStatistics> {
  late final int cont;

  @override
  void initState() {
    cont = getCont();
    super.initState();
  }

  int getCont() {
    for (int i = 1; i < widget.datas.length + 1; i++) {
      if (widget.datas[widget.datas.length - i] > 0) {
        continue;
      }
      return i - 1;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Expanded(
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$cont회', style: theme.textTheme.headline6),
            Icon(
              Icons.local_fire_department,
              color: theme.colorScheme.tertiary.withOpacity(cont / 30),
              size: 75,
            ),
            Text('연속 클라이밍'),
          ],
        ),
      ),
    );
  }
}
