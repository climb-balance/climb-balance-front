import 'package:flutter/material.dart';

class AiParameterDetailTab extends StatelessWidget {
  const AiParameterDetailTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          AiParameterTitle(title: 'AI 점수 항목에 대한 설명'),
          AiParameterDetail(title: '정확도', detail: '팔, 다리를 고친 정도'),
          AiParameterDetail(title: '자세', detail: '팔과 몸의 각도'),
          AiParameterDetail(title: '밸런스', detail: '삼지점의 원리'),
          AiParameterDetail(title: '관성', detail: '이동 속도의 일정함'),
          AiParameterDetail(title: '모멘텀', detail: '받침점 발과 몸의 가까움 정도'),
          Divider(
            height: 16,
            thickness: 2,
          ),
          AiParameterTitle(title: 'AI 점수 측정'),
          AiParameterDetail(
            detail: '정확도를 높이려면 삼각대를 이용해 촬영해주세요.',
          ),
          AiParameterDetail(
            detail: '정확하지 않을 수 있으니 참고 용도로 이용해주세요.',
          ),
        ],
      ),
    );
  }
}

class AiParameterTitle extends StatelessWidget {
  final String title;

  const AiParameterTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: text.headline6,
      ),
    );
  }
}

class AiParameterDetail extends StatelessWidget {
  final String? title;
  final String detail;

  const AiParameterDetail({
    Key? key,
    this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (title != null)
            Text(
              title!,
              style: text.titleMedium,
            ),
          Text(detail),
        ],
      ),
    );
  }
}
