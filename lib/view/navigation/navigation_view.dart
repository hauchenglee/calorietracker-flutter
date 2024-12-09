import 'package:calorie_tracker_app/feature/dashboard/dashboard_screen.dart';
import 'package:calorie_tracker_app/feature/food/food_screen.dart';
import 'package:calorie_tracker_app/feature/food_record/food_record_screen.dart';
import 'package:calorie_tracker_app/feature/more/more_screen.dart';
import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:calorie_tracker_app/view/bottom/bottom_view.dart';
import 'package:calorie_tracker_app/view/bottom/tab_icon_data.dart';
import 'package:flutter/material.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({super.key});

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: AppTheme.background,
  );

  @override
  void initState() {
    // 1. 遍历tabIconsList，将每个tab的isSelected属性设置为false
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });

    // 2. 设置列表中第一个tab为选中状态
    tabIconsList[0].isSelected = true;

    // 3. 初始化animationController
    animationController = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);

    // 4. 创建tabBody，传入animationController
    tabBody = DashboardScreen(animationController: animationController);

    // 5. 调用父类的initState方法
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder<bool>(
        future: _getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return _buildContext(context, snapshot);
        },
      ),
    );
  }

  Future<bool> _getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget _buildContext(BuildContext context, AsyncSnapshot<bool> snapshot) {
    if (!snapshot.hasData) {
      return const SizedBox();
    } else {
      return Stack(
        children: <Widget>[
          tabBody,
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: bottomBar(),
          ),
        ],
      );
    }
  }

  Widget bottomBar() {
    return BottomView(
      tabIconsList: tabIconsList,
      addClick: () {},
      changeIndex: (int index) {
        setState(() => tabBody = _getScreenForIndex(index));
      },
    );
  }

  Widget _getScreenForIndex(int index) {
    if (!mounted) {
      return tabBody; // 返回当前状态，不更改
    }
    switch (index) {
      case 0:
        return DashboardScreen(animationController: animationController);
      case 1:
        return FoodScreen(animationController: animationController);
      case 2:
        return FoodRecordScreen(animationController: animationController);
      case 3:
        return MoreScreen(animationController: animationController);
      default:
        return DashboardScreen(animationController: animationController);
    }
  }
}
