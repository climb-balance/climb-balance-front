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
          AiParameterDetail(title: '정확도', detail: '홀드를 여러 번 고쳐 	잡지 않는지 확인'),
          AiParameterDetail(title: '각도', detail: '팔의 각도를 무리하게 굽히지 않는지 확인'),
          AiParameterDetail(title: '밸런스', detail: '클라이밍 이론의 “삼지점”을 확인'),
          AiParameterDetail(title: '관성', detail: '일정한 속도로 움직이는지 확인'),
          AiParameterDetail(title: '모멘텀', detail: '손발의 힘점, 받침점, 작용점을 확인'),
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
