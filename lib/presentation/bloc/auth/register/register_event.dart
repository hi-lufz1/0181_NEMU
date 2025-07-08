part of 'register_bloc.dart';

sealed class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final RegisterReqModel reqModel;

  RegisterSubmitted({required this.reqModel});
}
