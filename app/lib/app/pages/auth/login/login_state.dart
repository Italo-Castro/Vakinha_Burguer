import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'login_state.g.dart';

@match
enum LoginStatus { initial, login, sucess, loginError, erro }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;

  LoginState({required this.status, required this.errorMessage});

  LoginState.initial()
      : status = LoginStatus.initial,
        errorMessage = null;

  LoginState copyWhit({LoginStatus? status, String? errorMessage}) {
    return LoginState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, errorMessage];
}
