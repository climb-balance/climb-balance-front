import 'package:climb_balance/providers/tag_selector_provider.dart';
import 'package:climb_balance/ui/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModalLocationTagPicker extends ConsumerWidget {
  const ModalLocationTagPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final datas = ref
        .watch(locationSelectorProvider.notifier)
        .getFilteredLocationSelector;
    final updateQuery = ref
        .read(locationSelectorProvider.notifier)
        .updateFilteredLocationSelector;
    return Dialog(
      child: SafeArea(
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
