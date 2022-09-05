import 'package:climb_balance/presentation/common/components/my_icons.dart';
import 'package:flutter/material.dart';

class AiFeedbackAds extends StatefulWidget {
  const AiFeedbackAds({Key? key}) : super(key: key);

  @override
  State<AiFeedbackAds> createState() => _AiFeedbackAdsState();
}

class _AiFeedbackAdsState extends State<AiFeedbackAds> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI FEEDBACK'),
        centerTitle: true,
        elevation: 1,
      ),
      body: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'AI 분석 결과를 받아보세요',
                  style: theme.textTheme.headline5,
                ),
              ],
            ),
            GradientIcon(
              icon: Icons.workspace_premium,
              size: 100,
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.tertiary,
                ],
              ),
            ),
            Text(
              '첫달은 무료로 부담 없이',
              style: theme.textTheme.subtitle1,
            ),
            const Spacer(),
            const BasicPlanAds(),
            const SizedBox(
              height: 20,
            ),
            const StandardPlanAds(),
          ],
        ),
      ),
    );
  }
}

class BasicPlanAds extends StatelessWidget {
  const BasicPlanAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.deepPurple,
            Colors.pink,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            const Icon(Icons.train, size: 50, color: Colors.white),
            const SizedBox(
              width: 10,
            ),
            Text(
              '24시간 내 제공',
              style: theme.textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              '월 4900원',
              style: theme.textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StandardPlanAds extends StatelessWidget {
  const StandardPlanAds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.redAccent,
            Colors.orange,
          ],
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          children: [
            const Icon(Icons.rocket, size: 50, color: Colors.white),
            const SizedBox(
              width: 10,
            ),
            Text(
              '5분 안에 제공',
              style: theme.textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
            const Spacer(),
            Text(
              '월 9900원',
              style: theme.textTheme.headline6!.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
