import 'package:climb_balance/presentation/common/components/my_icons.dart';
import 'package:climb_balance/presentation/common/components/safe_area.dart';
import 'package:climb_balance/presentation/diary/diary_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/current_user_provider.dart';
import '../../common/components/user_profile_info.dart';
import 'edit_profile.dart';

class SliverProfile extends ConsumerWidget {
  const SliverProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isEditMode = ref
        .watch(diaryViewModelProvider.select((value) => value.isEditingMode));
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: const [
              ProfileOptions(),
            ],
          ),
        ),
      ],
      toolbarHeight: 120,
      flexibleSpace: isEditMode
          ? const EditProfile()
          : TopProfileInfo(
              user: ref.watch(currentUserProvider),
            ),
    );
  }
}

class ProfileOptions extends ConsumerWidget {
  const ProfileOptions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final onEdit = ref.read(diaryViewModelProvider.notifier).onEditMode;
    final endEdit = ref.read(diaryViewModelProvider.notifier).endEditMode;
    final isEditMode = ref
        .watch(diaryViewModelProvider.select((value) => value.isEditingMode));
    return Align(
      alignment: Alignment.topRight,
      child: Row(
        children: [
          isEditMode
              ? IconButton(onPressed: endEdit, icon: const Icon(Icons.check))
              : IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
          IconButton(
            icon: Icon(
              Icons.filter_alt,
              color: theme.colorScheme.onBackground,
            ),
            onPressed: () {
              showDialog(context: context, builder: (_) => DiaryFilterModal());
            },
          ),
        ],
      ),
    );
  }
}

class DiaryFilterModal extends StatefulWidget {
  const DiaryFilterModal({Key? key}) : super(key: key);

  @override
  State<DiaryFilterModal> createState() => _DiaryFilterModalState();
}

class _DiaryFilterModalState extends State<DiaryFilterModal> {
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final color = Theme.of(context).colorScheme;
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
              ),
              DiaryFilterTip(
                filter: '시도:',
                example: '시도:성공, 시도:실패',
                detail: '성공 여부를 필터합니다.',
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
      return '';
    }
    final filters = value.split(':');
    if (filters.length != 2 || filters[1].isEmpty) {
      return '태그 형식이 잘못 됐습니다.';
    }
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
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_rounded),
                )
              : const Icon(Icons.warning),
        ),
      ),
    );
  }
}
