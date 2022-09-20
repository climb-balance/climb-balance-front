import '../../presentation/register/register_state.dart';
import '../model/result.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<Result<User>> getCurrentUserProfile(String accessToken);

  Future<Result<User>> getUserProfileById(int userId);

  String getAuthUrl();

  Future<Result<void>> createUser(RegisterState registerState);
}
