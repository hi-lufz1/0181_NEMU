part of 'laporan_user_bloc.dart';

sealed class LaporanUserState extends Equatable {
  const LaporanUserState();

  @override
  List<Object?> get props => [];
}

class LaporanUserInitial extends LaporanUserState {}

class LaporanUserLoading extends LaporanUserState {}

class LaporanUserSuccess extends LaporanUserState {
  final List<Datum> data;
  final String message;

  const LaporanUserSuccess({required this.data, required this.message});

  @override
  List<Object?> get props => [data, message];
}

class LaporanUserFailure extends LaporanUserState {
  final String message;

  const LaporanUserFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
