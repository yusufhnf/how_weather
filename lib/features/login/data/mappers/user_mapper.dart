import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../models/user_model.dart';

@lazySingleton
class UserMapper {
  UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id,
      email: model.email,
      name: model.name,
      token: model.token,
    );
  }

  UserModel toModel(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      token: entity.token,
    );
  }
}
