import 'package:climb_balance/models/tag.dart';
import 'package:climb_balance/providers/upload.dart';
import 'package:climb_balance/ui/pages/story_upload_screens/write_desc.dart';
import 'package:climb_balance/ui/widgets/commons/safe_area.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_step_bar.dart';

class TagStory extends ConsumerStatefulWidget {
  final Trimmer trimmer;

  const TagStory({Key? key, required this.trimmer}) : super(key: key);

  @override
  ConsumerState<TagStory> createState() => _TagVideoState();
}

class _TagVideoState extends ConsumerState<TagStory> {
  late Difficulty difficulty;
  late Location location;
  late bool success;
  late DateTime date;

  @override
  void initState() {
    UploadType state = ref.read(uploadProvider.notifier).getState();
    difficulty = state.difficulty;
    location = state.location;
    success = state.success;
    date = state.date;
    super.initState();
  }

  @override
  void dispose() {
    ref.read(uploadProvider.notifier).setTags(
        difficulty: difficulty,
        location: location,
        success: success,
        date: date);
    super.dispose();
  }

  void handleDatePick() async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2010),
        lastDate: DateTime.now());
    if (newDate == null) return;
    setState(() {
      date = newDate;
    });
  }

  void handelTagNext() {
    ref.read(uploadProvider.notifier).setTags(
          location: location,
          difficulty: difficulty,
          success: success,
          date: date,
        );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WriteDesc(trimmer: widget.trimmer),
      ),
    );
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
            child: VideoViewer(
              trimmer: widget.trimmer,
            ),
          ),
          MySafeArea(
            child: Column(
              children: [
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
      bottomNavigationBar: BottomStepBar(
        handleNext: handelTagNext,
      ),
    );
  }
}