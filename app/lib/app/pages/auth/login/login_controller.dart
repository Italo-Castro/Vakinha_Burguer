import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/app/exceptions/unauthorized_exception.dart';
import 'package:delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository) : super(LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWhit(status: LoginStatus.login));
      final authModel = await _authRepository.login(email, password);

      final sp = await SharedPreferences.getInstance();
      sp.setString('acessToken', authModel.acessToken);
      sp.setString('refreshToken', authModel.acessToken);
      emit(state.copyWhit(status: LoginStatus.sucess));
    } on UnauthorizedExceptions catch (e, s) {
      log('Login ou senha inválidos', error: e, stackTrace: s);
      emit(state.copyWhit(
          status: LoginStatus.loginError,
          errorMessage: 'Login ou senha inválidos'));
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWhit(status: LoginStatus.erro));
    }
  }
}
