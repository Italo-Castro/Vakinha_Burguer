import 'dart:developer';

import 'package:delivery_app/app/exceptions/repository_exception.dart';
import 'package:delivery_app/app/models/auth_model.dart';
import 'package:delivery_app/app/repositories/auth/auth_repository.dart';
import 'package:dio/dio.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../exceptions/unauthorized_exception.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  AuthRepositoryImpl({required this.dio});

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio
          .unauth()
          .post('/auth', data: {'email': email, 'password': password});
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('E-mail ou senha inválidos', error: e, stackTrace: s);
        throw UnauthorizedExceptions();
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao realizar login');
    }
  }

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users',
          data: {'name': name, 'email': email, 'password': password});
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar usuário');
    }
  }
}
