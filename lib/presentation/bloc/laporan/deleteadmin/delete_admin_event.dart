part of 'delete_admin_bloc.dart';

sealed class DeleteAdminEvent extends Equatable {
  const DeleteAdminEvent();

  @override
  List<Object?> get props => [];
}

class DeleteAdminSubmitted extends DeleteAdminEvent {
  final String id;
  final DeleteAdminReqModel reqModel;

  const DeleteAdminSubmitted({required this.id, required this.reqModel});

  @override
  List<Object?> get props => [id, reqModel];
}
