import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainRouteNotifier extends StateNotifier<GlobalKey<NavigatorState>> {
  final ref;

  MainRouteNotifier({required this.ref}) : super(GlobalKey<NavigatorState>());

  void updateNavigator(GlobalKey<NavigatorState> key) {
    state = key;
  }

  void toAuth() {
    state.currentState?.pushNamedAndRemoveUntil('/auth', (route) => false);
  }

  void toMain() {
    state.currentState?.pushNamedAndRemoveUntil('/home', (route) => false);
  }
}

final mainRouteProvider =
    StateNotifierProvider<MainRouteNotifier, GlobalKey<NavigatorState>>((ref) {
  MainRouteNotifier notifier = MainRouteNotifier(ref: ref);
  return notifier;
});
