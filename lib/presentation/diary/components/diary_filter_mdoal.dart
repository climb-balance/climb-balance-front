import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common/components/my_icons.dart';
import '../../common/components/safe_area.dart';
import '../diary_view_model.dart';
import '../enums/diary_filter_type.dart';

class DiaryFilterModal extends ConsumerWidget {
  const DiaryFilterModal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
    final currentAddingFilter = ref.watch(
        diaryViewModelProvider.select((value) => value.currentAddingFilter));
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: BackIconButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: MySafeArea(
        child: DefaultTabController(
          length: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '태그 추가하기',
                style: text.headline6,
              ),
              DiaryFilterInput(),
              DiaryFilterTip(
                filter: '장소:',
                example: '장소:클라임 바운스',
                detail: '장소를 필터합니다.',
                isPrimary:
                    currentAddingFilter?.filter == DiaryFilterType.location,
              ),
              DiaryFilterTip(
                filter: '시도:',
                example: '시도:성공, 시도:실패',
                detail: '성공 여부를 필터합니다.',
                isPrimary:
                    currentAddingFilter?.filter == DiaryFilterType.success,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DiaryFilterTip extends StatelessWidget {
  final String filter;
  final String example;
  final String detail;
  final bool isPrimary;

  const DiaryFilterTip({
    Key? key,
    required this.filter,
    required this.example,
    required this.detail,
    this.isPrimary = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          filter,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: isPrimary ? color.primary : color.onBackground,
          ),
        ),
        const VerticalDivider(),
        Text(
          example,
          style: TextStyle(
            color: isPrimary ? color.primary : color.onBackground,
          ),
        ),
        const VerticalDivider(),
        Text(
          detail,
          style: TextStyle(
            color: isPrimary ? color.primary : color.onBackground,
          ),
        ),
      ],
    );
  }
}

class DiaryFilterInput extends ConsumerStatefulWidget {
  const DiaryFilterInput({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _DiaryFilterInputState();
}

class _DiaryFilterInputState extends ConsumerState<DiaryFilterInput> {
  TextEditingController textEditingController = TextEditingController();
  bool isValid = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    textEditingController.addListener(() {
      final text = textEditingController.value.text;
    });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      ref
          .read(diaryViewModelProvider.notifier)
          .updateCurrentAddingFilter(filterType: '', filterString: '');
      return ' ';
    }
    final filters = value.split(':');
    if (filters.length != 2 || filters[1].isEmpty) {
      ref
          .read(diaryViewModelProvider.notifier)
          .updateCurrentAddingFilter(filterType: '', filterString: '');
      return '태그 형식이 잘못 됐습니다.';
    }
    ref.read(diaryViewModelProvider.notifier).updateCurrentAddingFilter(
        filterType: filters[0], filterString: filters[1]);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: TextFormField(
        validator: _validate,
        onChanged: (String value) {
          setState(() {
            isValid = _formKey.currentState!.validate();
          });
        },
        controller: textEditingController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffixIcon: isValid
              ? IconButton(
                  onPressed: () {
                    ref
                        .read(diaryViewModelProvider.notifier)
                        .addCurrentAddingFilter();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.add_circle_rounded),
                )
              : const Icon(Icons.warning),
        ),
      ),
    );
  }
}
