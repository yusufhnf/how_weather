part of 'login_cubit.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = _LoginInitial;
  const factory LoginState.loading() = _LoginLoading;
  const factory LoginState.success(UserEntity user) = _LoginSuccess;
  const factory LoginState.failure(String message) = _LoginFailure;
}
