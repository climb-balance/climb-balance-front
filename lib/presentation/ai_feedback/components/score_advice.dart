import 'package:carousel_slider/carousel_slider.dart';
import 'package:climb_balance/presentation/ai_feedback/enums/ai_score_type.dart';
import 'package:flutter/material.dart';

const Map<AiScoreType, List<String>> advicesMap = {
  AiScoreType.angle: [
    '랩 그립을 통해 잡아보세요.',
    '근육은 약 90도 굽혔을 때 최대 힘을 냅니다.',
    '때론 팔 힘으로 밀어 올리는 것보다 어깨를 비틀어 올리는 것이 힘을 넣기 쉽습니다.',
  ],
  AiScoreType.accuracy: [
    '발을 최대한 정확하게 짚어 보세요.',
    '손 역시 정확하게 짚어 보세요.',
    '손과 발을 한번 고정했다면, 고치지 마세요.',
    '바꿔잡기를 고려해서 손을 잡으세요.',
  ],
  AiScoreType.balance: [
    '몸의 무게 중심은 허리에 위치해 있습니다. 중심을 느껴보세요.',
    '이동 후에는 팔과 다리를 그어 만든 사각형 중심에 무게 중심이 위치 해야 합니다.',
    '밸런스를 무너 뜨려 이동 후에는 최대한 빨리 밸런스를 복구하세요.',
    '밸런스는 보통 허리를 움직여 잡습니다. 허리를 다른 방식으로 움직여 보세요.',
    '받침점이 세 개가 되도록 양 발이 벌어지는 위치를 선택해보세요.',
    '무릎을 홀드 너머로 넘겨 밸런스를 잡아보세요.',
  ],
  AiScoreType.moment: [
    '뭄의 중심을 최대한 벽에 붙여보세요.',
    '상체를 수직으로 그은 선이 최대한 받침 발에 가까이 가도록 하세요.',
    '발 홀드에 확실하게 올라탄 다음에 손을 뻗으세요',
    '손을 뻗는 쪽과 반대 방향으로 허리를 넣으면 좋은 경우도 있습니다.',
  ],
  AiScoreType.inertia: [
    '복잡한 구간에서는 재빨리 올라가야 합니다.',
    '양손으로 몸을 끌어 올렸다면 재빨리 무게 중심을 양손 위로 올리세요.',
    '손과 손 또는 손과 발의 라인보다 몸을 재빨리 올리세요.',
    '한 손으로 버티고 있다면, 몸을 손 쪽과 가까이 해보세요.',
    '동적인 움직임 전에는 스윙을 통해 속도를 얻으세요.',
  ],
};

class ScoreAdvice extends StatelessWidget {
  final AiScoreType aiScoreType;

  const ScoreAdvice({
    Key? key,
    required this.aiScoreType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final advices = advicesMap[aiScoreType];
    return CarouselSlider(
      items: [
        ...advices!.map(
          (advice) => Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: color.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              advice,
              maxLines: 3,
            ),
          ),
        )
      ],
      options: CarouselOptions(
        autoPlay: true,
        height: 50,
        aspectRatio: 0.5,
        viewportFraction: 1,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
