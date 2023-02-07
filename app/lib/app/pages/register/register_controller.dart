import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:delivery_app/app/pages/home/widgtes/home_state.dart';
import 'package:delivery_app/app/pages/register/register_state.dart';

import '../../repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterController(this._authRepository) : super(RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWhit(status: RegisterStatus.register));

      await _authRepository.register(name, email, password);
      emit(state.copyWhit(status: RegisterStatus.success));
    } catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      emit(state.copyWhit(status: RegisterStatus.error));
    }
  }
}
