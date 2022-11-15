import 'package:flutter/material.dart';

class AiParameterDetailTab extends StatelessWidget {
  const AiParameterDetailTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AiParameterDetail(title: '정확도', detail: '어쩌구저쩌구'),
      ],
    );
  }
}

class AiParameterDetail extends StatelessWidget {
  final String title;
  final String detail;

  const AiParameterDetail({
    Key? key,
    required this.title,
    required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(detail),
      ],
    );
  }
}
