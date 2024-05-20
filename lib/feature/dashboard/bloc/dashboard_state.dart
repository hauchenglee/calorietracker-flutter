import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitialState extends DashboardState {}

class DashboardTokenValid extends DashboardState {}

class DashboardTokenInvalid extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardSuccessState extends DashboardState {
  final String message;

  DashboardSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
