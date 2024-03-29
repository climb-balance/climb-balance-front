import 'package:climb_balance/presentation/common/components/search.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/common/tag_selector_provider.dart';
import '../../../domain/model/tag_selector.dart';
import 'pick_item.dart';

class ModalPicker extends ConsumerWidget {
  final StateNotifierProvider<SelectorNotifier, List<Selector>> provider;
  final String searchLabel;

  const ModalPicker({
    Key? key,
    required this.provider,
    required this.searchLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Selector> datas = ref.watch(provider);
    final void Function(String) updateQuery =
        ref.read(provider.notifier).updateDatas;
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Dialog(
      child: SafeArea(
        child: SizedBox(
          width: size.width - 80,
          height: size.height - 80,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: SearchTextInput(
                  handleQuery: updateQuery,
                  searchLabel: searchLabel,
                ),
                pinned: true,
                leading: Container(),
                backgroundColor: Colors.transparent,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    ...datas.map(
                      (data) => PickItem(data: data),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
