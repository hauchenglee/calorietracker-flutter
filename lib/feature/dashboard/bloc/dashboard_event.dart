import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnLoadingEvent extends DashboardEvent {

  OnLoadingEvent();

  @override
  List<Object?> get props => [];
}
