import 'package:climb_balance/providers/upload.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimVideoViewer.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottomProgressBar.dart';

const Map<String, int> difficultyData = {
  '빨강': 0,
  '파랑': 2,
  '초록': 3,
  '검정': 4,
};

const Map<String, int> locationData = {
  '강남 클라이밍파크': 0,
  '신논현 더클라이밍': 1,
  '수원 클라임바운스': 2,
  '이천 클라임바운스': 3,
};

class TagVideo extends ConsumerStatefulWidget {
  Trimmer trimmer;

  TagVideo({Key? key, required this.trimmer}) : super(key: key);

  @override
  ConsumerState<TagVideo> createState() => _TagVideoState();
}

class _TagVideoState extends ConsumerState<TagVideo> {
  String difficultyDropValue = '빨강';
  String locationDropValue = '강남 클라이밍파크';
  bool success = false;
  DateTime date = DateTime.now();

  // TODO 상태 유지
  void handleDatePick() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2018),
        lastDate: DateTime.now());
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  void handelTagNext() {
    ref.read(uploadProvider.notifier).setTags(
          location: locationData[locationDropValue] ?? 0,
          difficulty: difficultyData[difficultyDropValue] ?? 0,
          success: success,
          date: date,
        );
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Container()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '태그 달기',
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
            minimum: const EdgeInsets.fromLTRB(40, 0, 40, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('난이도:'),
                    DropdownButton<String>(
                      value: difficultyDropValue,
                      icon: Icon(Icons.arrow_drop_down),
                      items: difficultyData.keys
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          difficultyDropValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('클라이밍장:'),
                    DropdownButton<String>(
                      value: locationDropValue,
                      icon: Icon(Icons.arrow_drop_down),
                      items: locationData.keys
                          .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  ))
                          .toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          locationDropValue = newValue!;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('실패/성공:'),
                    Switch(
                      value: success,
                      onChanged: (value) {
                        setState(() {
                          success = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('날짜:'),
                    TextButton(
                      // TODO 분리
                      child: Text('${date.year}-${date.month}-${date.day}'),
                      onPressed: handleDatePick,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: BottomProgressBar(
        handleNext: handelTagNext,
      ),
    );
  }
}
