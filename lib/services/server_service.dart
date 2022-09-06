import 'dart:typed_data';

import 'package:climb_balance/domain/model/story.dart';
import 'package:climb_balance/services/server_request.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../data/data_source/result.dart';
import '../models/story_upload.dart';
import '../presentation/ai_feedback/ai_feedback_state.dart';
import 'server_config.dart';

// TODO remove
List<String> testVideos = [
  'http://15.164.163.153:3000/story/1/video?type=raw',
  'http://15.164.163.153:3000/story/1/video?type=ai',
  'https://assets.mixkit.co/videos/preview/mixkit-girl-in-neon-sign-1232-large.mp4',
  'https://assets.mixkit.co/videos/preview/mixkit-abstract-video-of-a-man-with-heads-like-matrushka-32647-large.mp4',
  'https://d1csarkz8obe9u.cloudfront.net/posterpreviews/house-painter-promotion-video-template-design-b0d4f2ba5aa5af51d385d0bbf813c908_screen.mp4?ts=1614933517',
];

class ServerService {
  static Future<Result<List<Story>>> getUserStories() async {
    try {
      final preResult = await ServerRequest.get(ServerStoryPath);
      // TODO : 임시로 버그 막음 임 원래 final result = StoryList.fromJson({"storyList": preResult["stories"]});
      final result = StoryList.fromJson({"story_list": preResult});
      return Result.success(result.storyList);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  static Future<Result<Story>> getStory(int storyId) async {
    try {
      final result = await ServerRequest.get('$ServerStoryPath/$storyId');
      return Result.success(Story.fromJson(result));
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  static Future<Result<String>> getLoginHtml() async {
    try {
      final result = await ServerRequest.get(ServerNaverPath);
      return Result.success(result);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }

  static Future<Result<bool>> storyUpload(StoryUpload data) async {
    int storyId;
    try {
      final result = await ServerRequest.post(ServerStoryPath, data);
      storyId = result['story_id'];
    } catch (e) {
      return const Result.error('스토리 업로드 오류');
    }

    try {
      ServerRequest.multiPartUpload(
          '$ServerStoryPath/$storyId$serverVideoPath', data.file!);
    } catch (e) {
      return const Result.error('영상 업로드 오류');
    }
    return const Result.success(true);
  }

  static Future<Result<VideoPlayerController>> getStoryVideo(int storyId,
      {bool isAi = false}) async {
    try {
      final body = await ServerRequest.get(
          '$ServerStoryPath/$storyId$serverVideoPath?type=${isAi ? 'ai' : 'raw'}');
      return Result.success(VideoPlayerController.network(body));
    } catch (e) {
      return const Result.error('영상 불러오기 오류');
    }
  }

  // TODO tmp
  static Future<Result<Uint8List>> getStoryThumbnail(int storyId) async {
    try {
      final path = await ServerRequest.nativeGet(
          '$ServerStoryPath/$storyId$serverVideoPath?type=thumbnail');
      return Result.success(path);
    } catch (e) {
      return const Result.error('영상 불러오기 오류');
    }
  }

  static String getStoryThumbnailPath(int storyId) {
    return '${ServerRequest.serverUrl}$ServerStoryPath/$storyId$serverVideoPath?type=thumbnail';
  }

  static Future<Result<AiFeedbackState>> getStoryAiDetail(int storyId) async {
    try {
      final body = await ServerRequest.get(
          '$ServerStoryPath/$storyId$serverVideoPath?type=json');
      debugPrint('a');
      return Result.success(AiFeedbackState(
          value: List.from(
        body.cast<int>(),
      )));
    } catch (e) {
      return const Result.error('영상 불러오기 오류');
    }
  }

  static String getStoryVideoPath(int storyId, {bool isAi = false}) {
    return '${ServerRequest.serverUrl}$ServerStoryPath/$storyId$serverVideoPath/?type=${isAi ? 'ai' : 'raw'}';
  }

  // TODO tmp
  static VideoPlayerController tmpStoryVideo(int storyId, {bool isAi = false}) {
    return VideoPlayerController.network(
      isAi
          ? 'http://15.164.163.153:3000/story/1/video?type=ai'
          : 'http://15.164.163.153:3000/story/1/video?type=raw',
    );
  }

  static Future<Result<bool>> putAiFeedback(
      int storyId, String pushToken) async {
    try {
      final result = await ServerRequest.put(
        '$ServerStoryPath/$storyId$serverAiFeedbackPath',
        {
          'token': pushToken,
        },
      );
      return const Result.success(true);
    } catch (e) {
      return const Result.error('AI 피드백 요청 오류');
    }
  }
}
