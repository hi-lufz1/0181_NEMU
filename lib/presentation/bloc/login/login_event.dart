part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginSubmitted extends LoginEvent {
final LoginReqModel reqModel;

  LoginSubmitted({required this.reqModel});
}