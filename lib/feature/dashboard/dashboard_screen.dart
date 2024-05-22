import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../util/app_theme.dart';
import '../../widget/custom_dialog.dart';
import '../../widget/speedometer_number.dart';
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
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is DashboardLoadingState) {
          if (!mounted) return;
        } else if (state is DashboardLoadedState) {
          if (!mounted) return;
        } else if (state is DashboardErrorState) {
          if (!mounted) return;
          CustomDialog().showCustomDialog(context, state.message);
        }
      },
      child: buildBody(context),
    );
  }

  buildBody(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sample Layout'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.4, // 根据需要调整大小
              // color: Colors.blue, // 为了可视化区分，设置颜色
              child: Center(
                child: SpeedometerNumber(currentNumber: 1750.0, totalNumber: 2000.0, size: 300, color: AppTheme.iceBlue4), // 设置初始百分比为0.5,,
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.4, // 根据需要调整大小
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // SpeedometerPercent(currentNumber: 1000.0, totalNumber: 2000.0, size: 300, color: AppTheme.iceBlue4), // 设置初始百分比为0.5,,
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.6, // 根据需要调整大小
              color: Colors.orange,
              child: Center(
                child: Text('第三层组件'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
