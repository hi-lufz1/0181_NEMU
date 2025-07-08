part of 'delete_admin_bloc.dart';

sealed class DeleteAdminState extends Equatable {
  const DeleteAdminState();

  @override
  List<Object?> get props => [];
}

class DeleteAdminInitial extends DeleteAdminState {}

class DeleteAdminLoading extends DeleteAdminState {}

class DeleteAdminSuccess extends DeleteAdminState {
  final DeleteResModel resModel;

  const DeleteAdminSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class DeleteAdminFailure extends DeleteAdminState {
  final DeleteResModel resModel;

  const DeleteAdminFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
