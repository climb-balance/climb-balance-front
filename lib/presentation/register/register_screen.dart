import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../presentation/common/components/safe_area.dart';
import '../common/components/button.dart';
import 'components/height_info.dart';
import 'components/register_form.dart';
import 'components/weight_info.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  int curPage = 0;
  final formKey = GlobalKey<FormState>();
  late TabController _tabController;
  late final List<Widget> registerTabs;

  @override
  void initState() {
    registerTabs = [
      const HeightInfo(),
      const WeightInfo(),
      RegisterForm(formKey: formKey),
    ];
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
    final size = MediaQuery.of(context).size;
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
            curPage -= 1;
            setState(() {});
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: FullSizeBtn(
          onPressed: () {
            if (curPage == registerTabs.length - 1) {
              ref
                  .read(registerViewModelProvider.notifier)
                  .validate(formKey, context);
              return;
            }
            curPage += 1;
            setState(() {});
          },
          text: '완료',
        ),
      ),
    );
  }
}
