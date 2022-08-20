import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/services/server_request.dart';

import '../models/result.dart';
import 'server_config.dart';

class ServerService {
  static Future<Result<List<Story>>> getUserStories() async {
    try {
      final result = await ServerRequest.get(ServerStoryPath);
      return Result.success(result);
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
}
