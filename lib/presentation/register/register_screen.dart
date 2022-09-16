import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../presentation/common/components/safe_area.dart';
import 'components/height_info.dart';
import 'components/weight_info.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  static const registerTabs = [HeightInfo(), WeightInfo()];
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: registerTabs.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final curPage =
        ref.watch(registerViewModelProvider.select((value) => value.curPage));
    _tabController.animateTo(curPage);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${curPage + 1} / ${registerTabs.length}',
          style: TextStyle(color: Theme.of(context).primaryColorDark),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            if (curPage == 0) context.pop();
            ref.read(registerViewModelProvider.notifier).lastPage();
          },
        ),
      ),
      body: MySafeArea(
        child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: registerTabs,
        ),
      ),
    );
  }
}
