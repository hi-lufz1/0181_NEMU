part of 'laporan_admin_bloc.dart';

sealed class LaporanAdminState extends Equatable {
  const LaporanAdminState();

  @override
  List<Object?> get props => [];
}

class LaporanAdminInitial extends LaporanAdminState {}

class LaporanAdminLoading extends LaporanAdminState {}

class LaporanAdminSuccess extends LaporanAdminState {
  final GetallResModel resModel;

  const LaporanAdminSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class LaporanAdminFailure extends LaporanAdminState {
  final GetallResModel resModel;

  const LaporanAdminFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
