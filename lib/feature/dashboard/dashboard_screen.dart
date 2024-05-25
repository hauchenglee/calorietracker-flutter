import 'package:calorie_tracker_app/feature/dashboard/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/app_theme.dart';
import '../../widget/custom_dialog.dart';
import '../../widget/speedometer_all.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_event.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  final AnimationController? animationController;

  const DashboardScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    // 触发BLoC事件加载数据
    context.read<DashboardBloc>().add(OnFetchDashboardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is DashboardLoadedState) {
          if (!mounted) return;
          // 你可以在这里处理一些状态加载完成后的逻辑，但不是构建小部件
        } else if (state is DashboardErrorState) {
          if (!mounted) return;
          CustomDialog().showCustomDialog(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is DashboardLoadedState) {
          return buildBody(context, state.dashboards);
        } else if (state is DashboardErrorState) {
          // 已经有上面listener小部件了，不必下面重绘ui
        }
        // 默认显示加载中界面
        return buildLoading(); // 确保这个函数已正确定义
      },
    );
  }

  buildBody(BuildContext context, List<DashboardModel> dashboards) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double percent = dashboards.isNotEmpty ? dashboards.first.caloriePercent : 0.0;
    double currentNumber = dashboards.isNotEmpty ? dashboards.first.calorieIntake : 0.0;
    double totalNumber = dashboards.isNotEmpty ? dashboards.first.calorieLimit : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Layout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: screenHeight * 0.1),
            Container(
              width: screenWidth,
              height: screenHeight * 0.4, // 根据需要调整大小
              child: Center(
                child: SpeedometerAll(percent: percent, currentNumber: currentNumber, totalNumber: totalNumber, size: 300, color: AppTheme.circleForward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildLoading() {
    return Center(child: CircularProgressIndicator());
  }
}
