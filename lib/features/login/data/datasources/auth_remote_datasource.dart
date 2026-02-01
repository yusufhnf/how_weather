import 'package:injectable/injectable.dart';

import '../../../../core/exceptions/app_exceptions.dart';
import '../models/user_model.dart';

@lazySingleton
class AuthRemoteDataSource {
  static const String _validEmail = 'admin@meetucup.com';
  static const String _validPassword = 'admin1234';

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(seconds: 2));

    if (email != _validEmail) {
      throw ValidationException('Email not found');
    }

    if (password != _validPassword) {
      throw UnauthorizedException('Invalid password');
    }

    return const UserModel(
      id: '1',
      email: _validEmail,
      name: 'Admin User',
      token: 'fake_token_123456789',
    );
  }
}
