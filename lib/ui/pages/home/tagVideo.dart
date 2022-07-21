import 'package:climb_balance/ui/widgets/video_trimmer/trimVideoViewer.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimmer.dart';
import 'package:flutter/material.dart';

import '../../widgets/bottomProgressBar.dart';

class TagVideo extends StatefulWidget {
  Trimmer trimmer;

  TagVideo({Key? key, required this.trimmer}) : super(key: key);

  @override
  State<TagVideo> createState() => _TagVideoState();
}

class _TagVideoState extends State<TagVideo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '영상 자르기',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        leading: Container(),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: TrimVideoViewer(
              trimmer: widget.trimmer,
            ),
          ),
          SafeArea(
            minimum: EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                Text('dkssud'),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: BottomProgressBar(
        handleNext: () {},
      ),
    );
  }
}
