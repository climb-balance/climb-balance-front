import 'package:climb_balance/presentation/register/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../presentation/common/components/safe_area.dart';
import '../common/components/button.dart';
import 'components/height_tab.dart';
import 'components/register_form_tab.dart';
import 'components/register_status.dart';
import 'components/weight_tab.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Widget> registerTabs = [
    const HeightTab(),
    const WeightTab(),
    RegisterFormTab(formKey: GlobalKey<FormState>()),
  ];
  bool valueCheck = false;

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
    final color = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final curPage =
        ref.watch(registerViewModelProvider.select((value) => value.curPage));

    final isValid =
        ref.watch(registerViewModelProvider.select((value) => value.isValid));
    _tabController.animateTo(curPage);
    return Scaffold(
      backgroundColor: color.background,
      appBar: AppBar(
        title: Text(
          '회원가입',
          style: text.subtitle1,
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            ref.read(registerViewModelProvider.notifier).goBack(context);
          },
        ),
      ),
      body: MySafeArea(
        child: Column(
          children: [
            RegisterStatus(
              maxStep: registerTabs.length,
              currentStep: curPage,
            ),
            Expanded(
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _tabController,
                children: registerTabs,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: FullSizeBtn(
          onPressed: () {
            if (isValid) {
              ref.read(registerViewModelProvider.notifier).goNext(context);
            }
          },
          color: isValid ? color.primary : color.surface,
          child: SizedBox(
            height: 56,
            child: Center(
              child: Text(
                curPage == registerTabs.length - 1 ? '완료' : '다음',
                style: text.headline6!.copyWith(
                  color: color.onPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
