import 'dart:convert';

import 'package:climb_balance/data/data_source/service/server_service.dart';
import 'package:climb_balance/domain/const/server_config.dart';
import 'package:climb_balance/domain/model/update_user.dart';
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

  /// circular denpedency 홰결을 위해 직접 받도록
  Future<Result<Map<String, dynamic>>> getCurrentUserProfile(
      String accessToken) async {
    try {
      final result = await server.get(
        url: serverProfilePath,
        accessToken: accessToken,
      );
      return Result.success(jsonDecode(result));
    } catch (e) {
      return Result.error('내 정보 불러오기 오류 $e');
    }
  }

  Future<Result<Map<String, dynamic>>> getUserProfileById(int userId) async {
    try {
      final result = await server.get(url: '$serverProfilePath/$userId');
      return Result.success(jsonDecode(result));
    } catch (e) {
      return Result.error('유저 정보 불러오기 오류 $e');
    }
  }

  Future<Result<void>> createUser(RegisterState registerState) async {
    try {
      final result = await server.multiPartRegister(
        serverRegisterPath,
        fileField: 'profileImage',
        filePath: registerState.profileImagePath,
        data: registerState,
      );
      return Result.success(null);
    } catch (e) {
      return Result.error('회원가입 오류 ${e.toString()}');
    }
  }

  Future<Result<Map<String, dynamic>>> getMainStatistics(
      String accessToken) async {
    try {
      final result = await server.get(
        url: '$serverMainPath',
        accessToken: accessToken,
      );

      return Result.success(jsonDecode(result));
    } catch (e) {
      return Result.error('메인 정보 로드 오류 ${e.toString()}');
    }
  }

  Future<Result<void>> deleteUser(String accessToken) async {
    try {
      final result = await server.delete(
        url: '$serverRegisterPath',
        accessToken: accessToken,
      );

      return const Result.success(null);
    } catch (e) {
      return Result.error('탈퇴 실패 : ${e.toString()}');
    }
  }

  Future<Result<void>> updateUser({
    required String accessToken,
    required UpdateUser updateUser,
  }) async {
    try {
      final result = await server.patch(
        url: '$serverProfilePath',
        accessToken: accessToken,
        data: updateUser,
      );

      return const Result.success(null);
    } catch (e) {
      return Result.error('계정 수정 실패 : ${e.toString()}');
    }
  }

  Future<Result<Map<String, dynamic>>> getGuestUser(String code) async {
    try {
      final result = await server.get(
        url: '$serverGuestPath',
        accessToken: code,
      );

      return Result.success(jsonDecode(result));
    } catch (e) {
      return Result.error('메인 정보 로드 오류 ${e.toString()}');
    }
  }
}
