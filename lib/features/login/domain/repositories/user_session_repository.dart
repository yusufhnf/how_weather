import '../entities/user_entity.dart';

abstract class UserSessionRepository {
  Future<void> saveUser(UserEntity user);
  Future<UserEntity?> getUser();
  Future<void> clearUser();
}
