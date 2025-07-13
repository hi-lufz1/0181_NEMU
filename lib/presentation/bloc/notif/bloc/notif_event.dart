part of 'notif_bloc.dart';

sealed class NotifEvent extends Equatable {
  const NotifEvent();

  @override
  List<Object> get props => [];
}

class LoadNotifikasi extends NotifEvent {}

class TandaiNotifSudahDibaca extends NotifEvent {
  final String id;
  final String terkaitId;

  const TandaiNotifSudahDibaca({required this.id, required this.terkaitId});

  @override
  List<Object> get props => [id, terkaitId];
}
