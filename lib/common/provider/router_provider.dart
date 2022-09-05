import 'package:climb_balance/presentation/community/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/diary/diary_screen.dart';
import '../../presentation/home/home_screen.dart';
import '../../providers/user_provider.dart';
import '../../ui/pages/account_page/account/account.dart';
import '../../ui/pages/auth/auth.dart';
import '../../ui/pages/feedback_page/feedback_list/feedback_list.dart';
import '../const/route_config.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final token = ref.watch(userProvider.select((value) => value.token));

  return GoRouter(
    initialLocation: token == '' ? HOME_PAGE_PATH : HOME_PAGE_PATH,
    routes: <GoRoute>[
      GoRoute(
        path: AUTH_PAGE_PATH,
        builder: (context, state) => const Auth(),
      ),
      GoRoute(
        path: HOME_PAGE_PATH,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: COMMUNITY_PAGE_PATH,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: CommunityScreen(),
        ),
      ),
      GoRoute(
        path: DIARY_PAGE_PATH,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: DiaryScreen(),
        ),
      ),
      GoRoute(
        path: ACCOUNT_PAGE_PATH,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: Account(),
        ),
      ),
      GoRoute(
        path: FEEDBACK_PAGE_PATH,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: FeedbackList(),
        ),
      ),
    ],
  );
});
