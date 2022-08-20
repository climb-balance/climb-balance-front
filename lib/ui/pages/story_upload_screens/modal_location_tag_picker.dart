import 'package:climb_balance/providers/tag_selector_provider.dart';
import 'package:climb_balance/ui/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ModalLocationTagPicker extends ConsumerStatefulWidget {
  const ModalLocationTagPicker({Key? key}) : super(key: key);

  @override
  ConsumerState<ModalLocationTagPicker> createState() =>
      _ModalLocationTagPickerState();
}

class _ModalLocationTagPickerState
    extends ConsumerState<ModalLocationTagPicker> {
  void updateQuery(String query) {
    ref
        .read(locationSelectorProvider.notifier)
        .updateFilteredLocationSelector(query);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final datas = ref
        .watch(locationSelectorProvider.notifier)
        .getFilteredLocationSelector;
    return Scaffold(
      body: Container(
        width: size.width - 40,
        height: size.height - 80,
        color: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            SingleChildScrollView(
              child: ListView.custom(
                shrinkWrap: true,
                childrenDelegate: SliverChildListDelegate(
                  [
                    SearchTextInput(
                      handleQuery: updateQuery,
                    ),
                    ...datas.map(
                      (data) => Center(
                        child: TextButton(
                            onPressed: () {}, child: Text(data.name)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
