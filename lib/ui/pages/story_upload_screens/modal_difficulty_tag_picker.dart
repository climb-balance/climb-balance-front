import 'package:climb_balance/providers/tag_selector_provider.dart';
import 'package:climb_balance/ui/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModalDifficultyTagPicker extends ConsumerStatefulWidget {
  const ModalDifficultyTagPicker({Key? key}) : super(key: key);

  @override
  ConsumerState<ModalDifficultyTagPicker> createState() =>
      _ModalLocationTagPickerState();
}

class _ModalLocationTagPickerState
    extends ConsumerState<ModalDifficultyTagPicker> {
  void updateQuery(String query) {
    ref
        .read(difficultySelectorProvider.notifier)
        .updateFilteredDifficultySelector(query);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final datas = ref
        .watch(difficultySelectorProvider.notifier)
        .getFilteredDifficultySelector;
    return Dialog(
      child: Container(
        width: size.width - 40,
        height: size.height - 80,
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          child: ListView.custom(
            shrinkWrap: true,
            childrenDelegate: SliverChildListDelegate(
              [
                SearchTextInput(
                  handleQuery: updateQuery,
                ),
                ...datas.map(
                  (data) => Center(
                    child: TextButton(onPressed: () {}, child: Text(data.name)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
