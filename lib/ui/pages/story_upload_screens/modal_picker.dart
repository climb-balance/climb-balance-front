import 'package:climb_balance/ui/pages/story_upload_screens/pick_item.dart';
import 'package:climb_balance/ui/widgets/search.dart';
import 'package:flutter/material.dart';

import '../../../models/tag_selector.dart';

class ModalPicker extends StatelessWidget {
  final List<Selector> datas;
  final void Function(String) updateQuery;
  final String searchLabel;

  const ModalPicker({
    Key? key,
    required this.datas,
    required this.updateQuery,
    required this.searchLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Dialog(
      child: SafeArea(
        child: SizedBox(
          width: size.width - 80,
          height: size.height - 80,
          child: ListView.custom(
            shrinkWrap: true,
            childrenDelegate: SliverChildListDelegate(
              [
                SearchTextInput(
                  handleQuery: updateQuery,
                  searchLabel: searchLabel,
                ),
                ...datas.map(
                  (data) => PickItem(data: data),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
