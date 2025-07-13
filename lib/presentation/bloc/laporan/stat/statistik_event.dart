part of 'statistik_bloc.dart';

sealed class StatistikEvent extends Equatable {
  const StatistikEvent();

  @override
  List<Object?> get props => [];
}

class StatistikRequested extends StatistikEvent {}
