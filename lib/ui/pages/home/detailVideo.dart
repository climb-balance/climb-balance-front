import 'package:climb_balance/providers/asyncStatus.dart';
import 'package:climb_balance/providers/upload.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimVideoViewer.dart';
import 'package:climb_balance/ui/widgets/video_trimmer/trimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../widgets/bottomStepBar.dart';

class DetailVideo extends ConsumerStatefulWidget {
  Trimmer trimmer;

  DetailVideo({Key? key, required this.trimmer}) : super(key: key);

  @override
  ConsumerState<DetailVideo> createState() => _DetailVideoState();
}

class _DetailVideoState extends ConsumerState<DetailVideo> {
  String detail = "";

  // TODO 상태 유지

  void handleUpload() {
    final notifier = ref.read(uploadProvider.notifier);
    notifier.setDetail(detail: detail);
    notifier.upload().then((res) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text('호에에엥'),
        ),
      );
    });
  }

  void handleDetailChange(String value) {
    setState(() {
      detail = value;
    });
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
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '내용을 적어주세요',
                  ),
                  onChanged: handleDetailChange,
                )
              ],
            ),
          ),
        ],
      ),
      bottomSheet: BottomStepBar(
        handleNext: handleUpload,
        next: '업로드',
      ),
    );
  }
}
