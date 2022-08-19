import 'package:flutter/material.dart';

class ExpertFeedbackRequest extends StatelessWidget {
  const ExpertFeedbackRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('전문가 피드백 요청'),
        centerTitle: true,
      ),
    );
  }
}
