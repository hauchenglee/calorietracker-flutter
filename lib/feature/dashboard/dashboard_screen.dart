import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widget/speedometer.dart';
import 'bloc/dashboard_bloc.dart';
import 'bloc/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  final AnimationController? animationController;

  const DashboardScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if (state is DashboardLoading) {
          if (!mounted) return;
        } else if (state is DashboardSuccessState) {
          if (!mounted) return;
        } else if (state is DashboardErrorState) {
          if (!mounted) return;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: screenWidth,
              height: screenHeight * 0.4, // 根据需要调整大小
              color: Colors.blue, // 为了可视化区分，设置颜色
              child: Center(
                child: Speedometer(size: 300, percent: 0.99, color: Colors.red), // 设置初始百分比为0.5,,
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.1, // 根据需要调整大小
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      color: Colors.red,
                      child: Center(child: Text('左侧组件')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.green,
                      child: Center(child: Text('中间组件')),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      color: Colors.yellow,
                      child: Center(child: Text('右侧组件')),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: screenHeight * 0.2, // 根据需要调整大小
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
