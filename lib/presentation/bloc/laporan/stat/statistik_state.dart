part of 'statistik_bloc.dart';

sealed class StatistikState extends Equatable {
  const StatistikState();

  @override
  List<Object?> get props => [];
}

class StatistikInitial extends StatistikState {}

class StatistikLoading extends StatistikState {}

class StatistikSuccess extends StatistikState {
  final StatResModel resModel;

  const StatistikSuccess({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}

class StatistikFailure extends StatistikState {
  final StatResModel resModel;

  const StatistikFailure({required this.resModel});

  @override
  List<Object?> get props => [resModel];
}
