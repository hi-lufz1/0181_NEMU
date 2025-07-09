part of 'register_bloc.dart';

sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final RegisterResModel responseModel;

  RegisterSuccess({required this.responseModel});
}

final class RegisterFailure extends RegisterState {
   final RegisterResModel responseModel;

  RegisterFailure({required this.responseModel});
}