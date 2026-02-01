import 'package:flutter_test/flutter_test.dart';
import 'package:how_weather/features/login/data/mappers/user_mapper.dart';
import 'package:how_weather/features/login/data/models/user_model.dart';
import 'package:how_weather/features/login/domain/entities/user_entity.dart';

void main() {
  late UserMapper mapper;

  setUp(() {
    mapper = UserMapper();
  });

  const tUserModel = UserModel(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    token: 'test_token',
  );

  const tUserEntity = UserEntity(
    id: '1',
    email: 'test@example.com',
    name: 'Test User',
    token: 'test_token',
  );

  group('UserMapper', () {
    group('toEntity', () {
      test('should convert UserModel to UserEntity correctly', () {
        final result = mapper.toEntity(tUserModel);

        expect(result, tUserEntity);
        expect(result.id, tUserModel.id);
        expect(result.email, tUserModel.email);
        expect(result.name, tUserModel.name);
        expect(result.token, tUserModel.token);
      });

      test('should preserve all fields during conversion', () {
        const model = UserModel(
          id: '123',
          email: 'john.doe@example.com',
          name: 'John Doe',
          token: 'jwt_token_12345',
        );

        final entity = mapper.toEntity(model);

        expect(entity.id, '123');
        expect(entity.email, 'john.doe@example.com');
        expect(entity.name, 'John Doe');
        expect(entity.token, 'jwt_token_12345');
      });
    });

    group('toModel', () {
      test('should convert UserEntity to UserModel correctly', () {
        final result = mapper.toModel(tUserEntity);

        expect(result, tUserModel);
        expect(result.id, tUserEntity.id);
        expect(result.email, tUserEntity.email);
        expect(result.name, tUserEntity.name);
        expect(result.token, tUserEntity.token);
      });

      test('should preserve all fields during conversion', () {
        const entity = UserEntity(
          id: '456',
          email: 'jane.doe@example.com',
          name: 'Jane Doe',
          token: 'jwt_token_67890',
        );

        final model = mapper.toModel(entity);

        expect(model.id, '456');
        expect(model.email, 'jane.doe@example.com');
        expect(model.name, 'Jane Doe');
        expect(model.token, 'jwt_token_67890');
      });
    });

    test('should maintain data integrity when converting back and forth', () {
      const originalModel = UserModel(
        id: 'test_id',
        email: 'test@test.com',
        name: 'Test',
        token: 'token',
      );

      final entity = mapper.toEntity(originalModel);
      final modelAgain = mapper.toModel(entity);

      expect(modelAgain, originalModel);
    });
  });
}
