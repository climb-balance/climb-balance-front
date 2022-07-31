import 'package:climb_balance/ui/widgets/modalDataPicker.dart';
import 'package:flutter/material.dart';

import '../../../models/story.dart';
import '../../widgets/story.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return StoryView(
      story: getRandomStory(),
      handleBack: () {},
    );
  }
}
