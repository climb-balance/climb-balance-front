import 'package:climb_balance/presentation/account/account.dart';
import 'package:climb_balance/presentation/ai_feedback/ai_feedback_ads_screen.dart';
import 'package:climb_balance/presentation/community/community_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/diary/diary_screen.dart';
import '../../presentation/feedback_list/feedback_list.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/story/story_screen.dart';
import '../../providers/user_provider.dart';
import '../../ui/pages/auth/auth.dart';
import '../const/route_config.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final token = ref.watch(userProvider.select((value) => value.token));

  return GoRouter(
    initialLocation: token == '' ? homePageRoute : homePageRoute,
    routes: <GoRoute>[
      GoRoute(
        path: authPagePath,
        builder: (context, state) => const Auth(),
      ),
      GoRoute(
        path: homePageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: HomeScreen(),
        ),
      ),
      GoRoute(
        path: communityPageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: CommunityScreen(),
        ),
      ),
      GoRoute(
        path: diaryPageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: DiaryScreen(),
        ),
        routes: [
          GoRoute(
            path: storyPageSubRoute,
            builder: (context, state) {
              final storyId = int.parse(state.params['sid']!);

              return StoryScreen(
                storyId: storyId,
              );
            },
            routes: [
              GoRoute(
                path: aiPageSubRoute,
                builder: (context, state) {
                  final storyId = int.parse(state.params['sid']!);
                  // TODO connect

                  return StoryScreen(
                    storyId: storyId,
                  );
                },
              ),
              GoRoute(
                path: aiAdsPageSubRoute,
                builder: (context, state) {
                  return const AiFeedbackAdsScreen();
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: accountPageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: AccountScreen(),
        ),
      ),
      GoRoute(
        path: feedbackPageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: FeedbackList(),
        ),
      ),
    ],
  );
});
