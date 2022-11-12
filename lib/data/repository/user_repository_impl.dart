import 'package:climb_balance/data/data_source/user_server_helper.dart';
import 'package:climb_balance/domain/model/result.dart';
import 'package:climb_balance/domain/model/user.dart';
import 'package:climb_balance/domain/repository/user_repository.dart';
import 'package:climb_balance/presentation/home/models/home_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/const/server_config.dart';
import '../../domain/model/update_user.dart';
import '../../presentation/register/register_state.dart';

final userRepositoryImplProvider = Provider<UserRepositoryImpl>((ref) {
  final notifier =
      UserRepositoryImpl(ref: ref, server: ref.watch(userServerHelperProvider));
  return notifier;
});

class UserRepositoryImpl implements UserRepository {
  final UserServerHelper server;
  final ProviderRef<UserRepositoryImpl> ref;

  UserRepositoryImpl({
    required this.ref,
    required this.server,
  });

  @override
  Future<Result<User>> getCurrentUserProfile(String token) async {
    final result = await server.getCurrentUserProfile(token);
    return result.when(
        success: (value) => Result.success(User.fromJson(value)),
        error: (message) => Result.error(message));
  }

  @override
  Future<Result<User>> getUserProfileById(int userId) async {
    final result = await server.getUserProfileById(userId);
    return result.when(
        success: (value) => Result.success(User.fromJson(value)),
        error: (message) => Result.error(message));
  }

  @override
  String getAuthUrl() {
    return '$serverUrl$serverAuthPath';
  }

  @override
  Future<Result<void>> createUser(RegisterState registerState) async {
    final result = await server.createUser(registerState);
    return result.when(
      success: (value) => const Result.success(null),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<Result<HomeState>> getMainStatistics(String accessToken) async {
    final result = await server.getMainStatistics(accessToken);
    return result.when(
      success: (value) => Result.success(HomeState.fromJson(value)),
      error: (message) => Result.error(message),
    );
  }

  @override
  Future<Result<void>> deleteUser(String accessToken) async {
    return await server.deleteUser(accessToken);
  }

  @override
  Future<Result<void>> updateUser({
    required String accessToken,
    required UpdateUser updateUser,
  }) async {
    return await server.updateUser(
      accessToken: accessToken,
      updateUser: updateUser,
    );
  }
}
