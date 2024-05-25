import 'package:calorie_tracker_app/feature/dashboard/dashboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/api_response.dart';
import '../../../util/datetime_utils.dart';
import '../dashboard_model.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitialState()) {
    on<OnFetchDashboardEvent>(_onLoading);
    on<OnSelectDashboardEvent>(_onSelectLoading);
  }

  void _onLoading(OnFetchDashboardEvent event, Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    DateTime today = DateTime.now();
    String formattedToday = DateTimeUtils.formatDate(today);

    try {
      ApiResponse response = await DashboardService().getDashboardList(start: formattedToday, end: formattedToday);
      if (response.message.toUpperCase() == "SUCCESS") {
        if (response.data is List) {
          List<DashboardModel> dashboards = (response.data as List).map((item) {
            DashboardModel model = DashboardModel.fromJson(item);
            return model;
          }).toList();
          emit(DashboardLoadedState(dashboards));
        } else {
          emit(DashboardErrorState('Unexpected data format'));
        }
      } else {
        emit(DashboardErrorState("数据加载失败"));
      }
    } catch (e) {
      print(e);
      emit(DashboardErrorState(e.toString()));
    }
  }

  void _onSelectLoading(OnSelectDashboardEvent event, Emitter<DashboardState> emit) async {
    String start = DateTimeUtils.formatDate(event.startDate);
    String end = DateTimeUtils.formatDate(event.endDate);

    try {
      ApiResponse response = await DashboardService().getDashboardList(start: start, end: end);
      if (response.message.toUpperCase() == "SUCCESS") {
        emit(DashboardLoadedState(response.data));
      } else {
        emit(DashboardErrorState("数据加载失败"));
      }
    } catch (e) {
      emit(DashboardErrorState(e.toString()));
    }
  }
}
