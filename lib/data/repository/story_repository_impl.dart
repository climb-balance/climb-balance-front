import 'dart:isolate';
import 'dart:ui';

import 'package:climb_balance/data/data_source/story_server_helper.dart';
import 'package:climb_balance/domain/common/downloader_provider.dart';
import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/domain/repository/story_repository.dart';
import 'package:climb_balance/presentation/ai_feedback/models/ai_feedback_state.dart';
import 'package:climb_balance/presentation/community/models/story_id.dart';
import 'package:climb_balance/presentation/story/models/comment.dart';
import 'package:climb_balance/presentation/story_upload_screens/story_upload_state.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../domain/common/loading_provider.dart';
import '../../domain/const/server_config.dart';
import '../../domain/model/result.dart';

// TODO move to di
final storyRepositoryImplProvider = Provider<StoryRepositoryImpl>((ref) {
  final server = ref.watch(storyServerHelperProvider);
  return StoryRepositoryImpl(server, ref);
});

class StoryRepositoryImpl implements StoryRepository {
  StoryServerHelper server;
  ProviderRef ref;

  StoryRepositoryImpl(this.server, this.ref);

  @override
  Future<Result<void>> createStory({
    required StoryUploadState storyUpload,
  }) async {
    ref.read(loadingProvider.notifier).openLoading();
    final result = await server.createStory(storyUpload);
    ref.read(loadingProvider.notifier).closeLoading();
    return result;
  }

  @override
  Future<Result<Story>> getStoryById(int storyId) async {
    final result = await server.getStoryById(storyId);
    return result.when(
      success: (data) => Result.success(Story.fromJson(data)),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<Result<Story>> getRecommendStory() async {
    // TODO: implement getRecommendStory
    throw UnimplementedError();
  }

  @override
  String getStoryVideoPathById(int storyId, {bool isAi = false}) {
    return '$serverUrl$serverStoryPath/$storyId$serverVideoPath/?type=${isAi ? 'ai' : 'raw'}';
  }

  @override
  Future<Result<List<Story>>> getStories() async {
    final result = await server.getStories();
    return result.when(
      success: (iterable) =>
          Result.success(StoryList.fromJson({"storyList": iterable}).storyList),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<Result<AiFeedbackState>> getStoryAiDetailById(int storyId) async {
    final result = await server.getStoryAiDetailById(storyId);

    return result.when(
      success: (value) => Result.success(AiFeedbackState.fromJson(value)),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<void> updateStory(Story story) {
    // TODO: implement updateStory
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> deleteStory(int storyId) async {
    final result = await server.deleteStory(storyId);
    return result.when(
      success: (value) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<int>> likeStory() {
    // TODO: implement likeStory
    throw UnimplementedError();
  }

  @override
  Future<Result<void>> putAiFeedback(int storyId, String pushToken) async {
    final result = await server.putAiFeedback(storyId, pushToken);
    return result.when(
      success: (value) {
        return const Result.success(null);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  String _getStoryVidoUrl({required int storyId, required bool isAi}) {
    return '$serverUrl$serverStoryPath/$storyId$serverVideoPath?type=${isAi ? 'aimp4' : 'rawmp4'}';
  }

  @override
  Future<String?> getStoryVideo(
      {required int storyId, bool isAi = false}) async {
    final url = _getStoryVidoUrl(storyId: storyId, isAi: isAi);
    final documentDirectory = await getTemporaryDirectory();

    final path = await ref.read(downloaderProvider.notifier).addDownload(
          url: url,
          dir: '${documentDirectory.path}',
          fileName: isAi ? 'ai.mp4' : 'raw.mp4',
        );

    if (path == null) return null;

    final ReceivePort port = ReceivePort();
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      'downloader_send_port',
    );
    port.listen((dynamic data) async {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      if (status == DownloadTaskStatus.complete ||
          status == DownloadTaskStatus.failed) {
        await Share.shareFiles(
          [path],
          mimeTypes: ['video/mp4'],
        );
        port.close();
        IsolateNameServer.removePortNameMapping('downloader_send_port');
        return;
      }
      ref.read(loadingProvider.notifier).updateProgress(progress);
    });
    return null;
  }

  @override
  Future<Result<Comments>> getStoryComments(int storyId) async {
    final result = await server.getStoryComments(storyId);
    return result.when(
      success: (value) {
        return Result.success(Comments.fromJson({'comments': value}));
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }

  @override
  Future<Result<void>> addComment(int storyId, String content) async {
    return await server.addStoryComment(storyId, content);
  }

  @override
  Future<Result<void>> deleteComment(
      {required int commentId, required int storyId}) async {
    return await server.deleteStoryComment(
        storyId: storyId, commentId: commentId);
  }

  @override
  Future<Result<List<StoryId>>> getOtherStories({
    required int page,
  }) async {
    final result = await server.getOtherStories(
      page: page,
    );
    return result.when(
      success: (value) {
        return Result.success(StoryIds.fromJson({'storyIds': value}).storyIds);
      },
      error: (message) {
        return Result.error(message);
      },
    );
  }
}
