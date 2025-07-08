part of 'notif_bloc.dart';

sealed class NotifState extends Equatable {
  const NotifState();

  @override
  List<Object?> get props => [];
}

class NotifInitial extends NotifState {}

class NotifLoading extends NotifState {}

class NotifSuccess extends NotifState {
  final NotifResModel resModel;

  const NotifSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class NotifFailure extends NotifState {
  final NotifResModel resModel;

  const NotifFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
