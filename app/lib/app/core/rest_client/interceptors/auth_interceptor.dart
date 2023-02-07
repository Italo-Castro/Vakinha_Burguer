import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final sp = await SharedPreferences.getInstance();
    final acessToken = sp.get('acessToken');

    //adicionando o acessToken no authorization da request
    options.headers['Authorization'] = 'Bearer $acessToken';

  }
}
