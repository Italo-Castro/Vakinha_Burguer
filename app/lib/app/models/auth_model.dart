import 'dart:convert';

class AuthModel {
  final String acessToken;
  final String refreshToken;

  AuthModel({required this.acessToken, required this.refreshToken});

  Map<String, dynamic> toMap() {
    return {'acess_Token': acessToken, 'refresh_Token': refreshToken};
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
        acessToken: map['acess_Token'] ?? '',
        refreshToken: map['refresh_Token'] ?? '');
  }

  String toJson() => jsonEncode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(jsonDecode(source));
}
