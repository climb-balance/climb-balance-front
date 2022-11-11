import 'package:climb_balance/domain/common/current_user_provider.dart';
import 'package:climb_balance/presentation/account/account_screen.dart';
import 'package:climb_balance/presentation/ai_feedback/ai_feedback_ads_screen.dart';
import 'package:climb_balance/presentation/ai_feedback/ai_feedback_screen.dart';
import 'package:climb_balance/presentation/auth/auth_screen.dart';
import 'package:climb_balance/presentation/auth/components/web_view.dart';
import 'package:climb_balance/presentation/community/community_screen.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../presentation/diary/screens/diary_screen.dart';
import '../../presentation/expert_register/expert_register_screen.dart';
import '../../presentation/feedback_list/feedback_list.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/register/register_screen.dart';
import '../../presentation/story/story_screen.dart';
import '../const/route_config.dart';
import '../const/route_name.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final token =
      ref.watch(currentUserProvider.select((value) => value.accessToken));
  return GoRouter(
    debugLogDiagnostics: true,
    // TODO splash
    initialLocation: token == '' ? authPagePath : homePageRoute,
    routes: <GoRoute>[
      GoRoute(
        path: registerPageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: RegisterScreen(),
        ),
        name: registerRouteName,
      ),
      GoRoute(
        path: authPagePath,
        builder: (context, state) => const AuthScreen(),
        name: authPageRouteName,
        routes: [
          GoRoute(
            path: authNaverPageSubRoute,
            pageBuilder: (context, state) => const MaterialPage<void>(
              child: NaverWebView(),
            ),
            name: authNaverRouteName,
          ),
        ],
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
            name: diaryStoryRouteName,
            builder: (context, state) {
              final storyId = int.parse(state.params['sid']!);

              return StoryScreen(
                storyId: storyId,
              );
            },
            routes: [
              GoRoute(
                path: aiPageSubRoute,
                name: aiFeedbackRouteName,
                builder: (context, state) {
                  final storyId = int.parse(state.params['sid']!);

                  return AiFeedbackScreen(
                    storyId: storyId,
                  );
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
        routes: [
          GoRoute(
            path: expertRegisterPageSubRoute,
            pageBuilder: (context, state) => const MaterialPage<void>(
              child: ExpertRegisterScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: feedbackPageRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: FeedbackList(),
        ),
      ),
      GoRoute(
        path: storyUploadRoute,
        pageBuilder: (context, state) => const MaterialPage<void>(
          child: StoryUploadScreen(),
        ),
        name: storyUploadRouteName,
      ),
      GoRoute(
        path: aiAdsPageRoute,
        builder: (context, state) {
          return const AiFeedbackAdsScreen();
        },
        name: aiAdsRouteName,
      ),
    ],
  );
});
