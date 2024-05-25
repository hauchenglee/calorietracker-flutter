import 'package:equatable/equatable.dart';

import '../../../util/datetime_utils.dart';

abstract class DashboardEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 第一次初始化展示数据
class OnFetchDashboardEvent extends DashboardEvent {
  OnFetchDashboardEvent();

  @override
  List<Object?> get props => [];
}

// 使用者选择日期展示数据
class OnSelectDashboardEvent extends DashboardEvent {
  final DateTime startDate;
  final DateTime endDate;

  OnSelectDashboardEvent(this.startDate, this.endDate);

  @override
  List<Object?> get props => [startDate, endDate];
}
