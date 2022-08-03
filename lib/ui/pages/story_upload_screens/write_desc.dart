import 'package:climb_balance/providers/upload.dart';
import 'package:climb_balance/ui/widgets/safearea.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'bottom_step_bar.dart';

class WriteDesc extends ConsumerStatefulWidget {
  final Trimmer trimmer;

  const WriteDesc({Key? key, required this.trimmer}) : super(key: key);

  @override
  ConsumerState<WriteDesc> createState() => _DetailVideoState();
}

class _DetailVideoState extends ConsumerState<WriteDesc> {
  String detail = "";

  // TODO 상태 유지

  void handleUpload() {
    final notifier = ref.read(uploadProvider.notifier);
    notifier.setDetail(detail: detail);
    notifier.upload().then((res) {
      ref.refresh(uploadProvider);
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '내용을 적어주세요',
                    ),
                    onChanged: handleDetailChange,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomStepBar(
        handleNext: handleUpload,
        next: '업로드',
      ),
    );
  }
}
