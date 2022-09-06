import '../../common/models/result.dart';
import '../model/user.dart';

abstract class UserRepository {
  Future<Result<User>> getCurrentUserProfile();

  Future<Result<User>> getUserProfileById(int userId);
}
