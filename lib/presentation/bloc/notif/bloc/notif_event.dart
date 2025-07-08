part of 'notif_bloc.dart';

sealed class NotifEvent extends Equatable {
  const NotifEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifikasi extends NotifEvent {}
