import 'package:climb_balance/providers/register.dart';
import 'package:climb_balance/ui/widgets/commons/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:numberpicker/numberpicker.dart';

import '../../widgets/commons/safe_area.dart';

class Register extends ConsumerStatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends ConsumerState with SingleTickerProviderStateMixin {
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
        ref.watch(registerProvider.select((value) => value.curPage));
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
            if (curPage == 0) Navigator.pop(context);
            ref.read(registerProvider.notifier).lastPage();
          },
        ),
      ),
      body: MySafeArea(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: registerTabs,
        ),
      ),
    );
  }
}

class HeightInfo extends ConsumerStatefulWidget {
  const HeightInfo({Key? key}) : super(key: key);

  @override
  HeightInfoState createState() => HeightInfoState();
}

class HeightInfoState extends ConsumerState {
  int height = 165;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          const Information(
              title: '키를 입력해주세요',
              info:
                  '맞춤형 영상을 제공하기 위해 필요한 정보입니다. 동의가 없어도 서비스는 이용 가능하지만 원활한 이용을 위해 동의를 권장드립니다.'),
          NumberPicker(
            itemCount: 5,
            textStyle: Theme.of(context).textTheme.headline4,
            selectedTextStyle: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor),
            itemHeight: 50,
            minValue: 100,
            maxValue: 200,
            value: height,
            onChanged: (value) {
              setState(() {
                height = value;
              });
            },
          ),
          FullSizeBtn(
            onPressed: () {
              ref.read(registerProvider.notifier).updateHeight(height);
              ref.read(registerProvider.notifier).nextPage();
            },
            text: '완료',
          ),
          FullSizeBtn(onPressed: () {}, text: '비밀로 할래요', type: 1),
        ],
      ),
    );
  }
}

class WeightInfo extends ConsumerStatefulWidget {
  const WeightInfo({Key? key}) : super(key: key);

  @override
  WeightInfoState createState() => WeightInfoState();
}

class WeightInfoState extends ConsumerState {
  int weight = 65;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        children: [
          const Information(
              title: '몸무게를 입력해주세요',
              info:
                  '맞춤형 영상을 제공하기 위해 필요한 정보입니다. 동의가 없어도 서비스는 이용 가능하지만 원활한 이용을 위해 동의를 권장드립니다.'),
          NumberPicker(
            itemCount: 5,
            textStyle: Theme.of(context).textTheme.headline4,
            selectedTextStyle: Theme.of(context)
                .textTheme
                .headline3
                ?.copyWith(color: Theme.of(context).primaryColor),
            itemHeight: 50,
            minValue: 25,
            maxValue: 150,
            value: weight,
            onChanged: (value) {
              setState(() {
                weight = value;
              });
            },
          ),
          FullSizeBtn(
            onPressed: () {
              final regiRef = ref.read(registerProvider.notifier);
              regiRef.updateWeight(weight);
              regiRef.nextPage();
            },
            text: '완료',
          ),
          FullSizeBtn(onPressed: () {}, text: '비밀로 할래요', type: 1),
        ],
      ),
    );
  }
}

class Information extends StatelessWidget {
  final String title;
  final String info;

  const Information({Key? key, required this.title, required this.info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(title, style: theme.textTheme.headline4),
        Text(info, style: theme.textTheme.bodyText1),
      ],
    );
  }
}
