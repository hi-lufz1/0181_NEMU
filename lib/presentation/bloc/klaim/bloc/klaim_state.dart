part of 'klaim_bloc.dart';

sealed class KlaimState extends Equatable {
  const KlaimState();

  @override
  List<Object?> get props => [];
}

class KlaimInitial extends KlaimState {}

class KlaimLoading extends KlaimState {}

class KlaimSuccess extends KlaimState {
  final KlaimResModel resModel;

  const KlaimSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class KlaimFailure extends KlaimState {
  final KlaimResModel resModel;

  const KlaimFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
