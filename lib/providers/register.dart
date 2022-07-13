import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterType {
  int height;
  int weight;
  bool sex;
  int curPage = 0;

  RegisterType({this.height = 165, this.weight = 60, this.sex = true});
}

class RegisterNotifier extends StateNotifier<RegisterType> {
  RegisterNotifier() : super(RegisterType());

  void updateHeight(int value) {
    state.height = value;
  }

  void updateWeight(int value) {
    state.weight = value;
  }

  void updateSex(bool value) {
    state.sex = value;
  }

  void nextPage() {
    state.curPage = (state.curPage + 1) % 2;
  }

  void lastPage() {
    state.curPage = (state.curPage - 1) % 2;
  }
}

final registerProvider =
    StateNotifierProvider<RegisterNotifier, RegisterType>((ref) {
  RegisterNotifier notifier = RegisterNotifier();
  return notifier;
});
