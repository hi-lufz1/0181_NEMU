part of 'laporan_user_bloc.dart';

sealed class LaporanUserState extends Equatable {
  const LaporanUserState();

  @override
  List<Object?> get props => [];
}

class LaporanUserInitial extends LaporanUserState {}

class LaporanUserLoading extends LaporanUserState {}

class LaporanUserSuccess extends LaporanUserState {
  final GetallResModel resModel;

  const LaporanUserSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class LaporanUserFailure extends LaporanUserState {
  final GetallResModel resModel;

  const LaporanUserFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
