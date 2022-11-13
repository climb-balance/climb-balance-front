import 'package:climb_balance/domain/common/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class WaitingProgress extends ConsumerWidget {
  const WaitingProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final int? progress =
        ref.watch(loadingProvider.select((value) => value.progress));

    return Expanded(
      child: Container(
        color: Colors.black.withOpacity(0.5),
        padding: EdgeInsets.all(60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            SizedBox(
              height: 64,
            ),
            if (progress != null)
              LinearProgressIndicator(value: progress / 100),
          ],
        ),
      ),
    );
  }
}
