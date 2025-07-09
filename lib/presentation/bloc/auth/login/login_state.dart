part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResModel responseModel;

  LoginSuccess({required this.responseModel});
}

final class LoginFailure extends LoginState {
  final LoginResModel responseModel;

  LoginFailure({required this.responseModel});
}
