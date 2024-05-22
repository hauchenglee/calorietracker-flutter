import 'package:calorie_tracker_app/feature/dashboard/dashboard_model.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardLoadedState extends DashboardState {
  final List<DashboardModel> dashboards; // 根据你的数据类型调整

  DashboardLoadedState(this.dashboards);

  @override
  List<Object?> get props => [dashboards];
}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
