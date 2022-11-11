import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AiPromotion extends ConsumerWidget {
  const AiPromotion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'AI 피드백을 만나보세요',
          style: text.bodyText1,
        ),
        const SizedBox(
          height: 16,
        ),
        AspectRatio(
          aspectRatio: 2,
          child: Container(
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/img/bef.png'),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: color.primary,
                  size: 36,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/img/aft.png'),
                ),
                const SizedBox(
                  width: 8,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'AI 피드백',
                      style: text.headline6?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: color.primary,
                      ),
                    ),
                    const Icon(Icons.android),
                    Text(
                      '자동 확대\n자세 정보\n자세 점수\n자세 교정',
                      style: text.bodyText2?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: color.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
