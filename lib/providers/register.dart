import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterType {
  int height;
  int weight;
  bool sex;
  int curPage;

  RegisterType(
      {this.height = 165, this.weight = 60, this.sex = true, this.curPage = 0});
}

class RegisterNotifier extends StateNotifier<RegisterType> {
  RegisterNotifier() : super(RegisterType());

  void updateHeight(int value) {
    state = RegisterType(
        height: value,
        weight: state.weight,
        sex: state.sex,
        curPage: state.curPage);
  }

  void updateWeight(int value) {
    state = RegisterType(
        height: state.height,
        weight: value,
        sex: state.sex,
        curPage: state.curPage);
  }

  void updateSex(bool value) {
    state = RegisterType(
        height: state.height,
        weight: state.weight,
        sex: value,
        curPage: state.curPage);
  }

  void nextPage() {
    state = RegisterType(
        height: state.height,
        weight: state.weight,
        sex: state.sex,
        curPage: (state.curPage + 1) % 2);
  }

  void lastPage() {
    state = RegisterType(
        height: state.height,
        weight: state.weight,
        sex: state.sex,
        curPage: (state.curPage - 1) % 2);
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterType>((ref) {
  RegisterNotifier notifier = RegisterNotifier();
  return notifier;
});
