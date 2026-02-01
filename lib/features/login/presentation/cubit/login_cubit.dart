import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_state.dart';
part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase) : super(const LoginState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(const LoginState.loading());

    final result = await loginUseCase(
      LoginParams(email: email, password: password),
    );

    result.fold(
      (exception) => emit(LoginState.failure(exception.message)),
      (user) => emit(LoginState.success(user)),
    );
  }

  void reset() {
    emit(const LoginState.initial());
  }
}
