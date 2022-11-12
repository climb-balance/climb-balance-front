import 'package:climb_balance/presentation/home/models/home_state.dart';

import '../../presentation/register/register_state.dart';
import '../model/result.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<Result<User>> getCurrentUserProfile(String accessToken);

  Future<Result<User>> getUserProfileById(int userId);

  String getAuthUrl();

  Future<Result<void>> createUser(RegisterState registerState);

  Future<Result<HomeState>> getMainStatistics(String accessToken);

  Future<Result<void>> deleteUser(String accessToken);
}
