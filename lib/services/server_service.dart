import 'package:climb_balance/models/story.dart';
import 'package:climb_balance/services/server_request.dart';

import '../configs/server_config.dart';
import '../models/result.dart';

class ServerService {
  Future<Result<List<Story>>> getUserStories() async {
    try {
      final result = await ServerRequest.get(ServerUrl + ServerStoryPath);
      return Result.success(result);
    } catch (e) {
      return const Result.error('네트워크 에러');
    }
  }
}
