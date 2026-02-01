import 'package:injectable/injectable.dart';

import '../../../../core/constants/string_constants.dart';
import '../../../../core/services/shared_preferences_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_session_repository.dart';

@LazySingleton(as: UserSessionRepository)
class UserSessionRepositoryImpl implements UserSessionRepository {
  final SharedPreferencesService _sharedPreferencesService;

  UserSessionRepositoryImpl(this._sharedPreferencesService);

  @override
  Future<void> saveUser(UserEntity user) async {
    await _sharedPreferencesService.setString(
      key: StringConstants.userIdKey,
      value: user.id,
    );
    await _sharedPreferencesService.setString(
      key: StringConstants.userEmailKey,
      value: user.email,
    );
    await _sharedPreferencesService.setString(
      key: StringConstants.userNameKey,
      value: user.name,
    );
    await _sharedPreferencesService.setString(
      key: StringConstants.userTokenKey,
      value: user.token,
    );
  }

  @override
  Future<UserEntity?> getUser() async {
    final userId = await _sharedPreferencesService.getString(
      key: StringConstants.userIdKey,
    );
    final email = await _sharedPreferencesService.getString(
      key: StringConstants.userEmailKey,
    );
    final name = await _sharedPreferencesService.getString(
      key: StringConstants.userNameKey,
    );
    final token = await _sharedPreferencesService.getString(
      key: StringConstants.userTokenKey,
    );

    if (userId != null && email != null && name != null && token != null) {
      return UserEntity(id: userId, email: email, name: name, token: token);
    }
    return null;
  }

  @override
  Future<void> clearUser() async {
    await _sharedPreferencesService.remove(key: StringConstants.userIdKey);
    await _sharedPreferencesService.remove(key: StringConstants.userEmailKey);
    await _sharedPreferencesService.remove(key: StringConstants.userNameKey);
    await _sharedPreferencesService.remove(key: StringConstants.userTokenKey);
  }
}
