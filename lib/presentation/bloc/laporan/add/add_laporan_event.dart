part of 'add_laporan_bloc.dart';


sealed class AddLaporanEvent extends Equatable {
  const AddLaporanEvent();

  @override
  List<Object> get props => [];
}

class AddLaporanSubmitted extends AddLaporanEvent {
  final AddLaporanReqModel reqModel;

  const AddLaporanSubmitted({required this.reqModel});

  @override
  List<Object> get props => [reqModel];
}