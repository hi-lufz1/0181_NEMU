part of 'klaim_bloc.dart';

sealed class KlaimEvent extends Equatable {
  const KlaimEvent();

  @override
  List<Object?> get props => [];
}

class KlaimSubmitted extends KlaimEvent {
  final String laporanId;
  final KlaimReqModel reqModel;

  const KlaimSubmitted({required this.laporanId, required this.reqModel});

  @override
  List<Object?> get props => [laporanId, reqModel];
}
