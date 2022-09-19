import 'dart:convert';

import 'package:climb_balance/data/data_source/service/server_service.dart';
import 'package:climb_balance/domain/const/server_config.dart';
import 'package:climb_balance/presentation/register/register_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/model/result.dart';

final userServerHelperProvider = Provider((ref) {
  return UserServerHelper(ref, ref.watch(serverServiceProvider));
});

class UserServerHelper {
  final ServerService server;
  final ref;

  const UserServerHelper(this.ref, this.server);

  Future<Result<Map<String, dynamic>>> getCurrentUserProfile() async {
    try {
      final result = await server.get(serverProfilePath);
      return Result.success(jsonDecode(result));
    } catch (e) {
      return const Result.error('내 정보 불러오기 오류');
    }
  }

  Future<Result<Map<String, dynamic>>> getUserProfileById(int userId) async {
    try {
      final result = await server.get('$serverProfilePath/$userId');
      return Result.success(jsonDecode(result));
    } catch (e) {
      return const Result.error('유저 정보 불러오기 오류');
    }
  }

  Future<Result<Map<String, dynamic>>> createUser(
      RegisterState registerState) async {
    try {
      final result = await server.post(serverAuthPath, registerState);
      return Result.success(jsonDecode(result));
    } catch (e) {
      return Result.error('회원가입 오류 ${e.toString()}');
    }
  }
}
