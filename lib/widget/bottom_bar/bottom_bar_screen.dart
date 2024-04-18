import 'package:calorie_tracker_app/feature/diary/diary_screen.dart';
import 'package:calorie_tracker_app/feature/food/food_screen.dart';
import 'package:calorie_tracker_app/feature/home/home_screen.dart';
import 'package:calorie_tracker_app/feature/more/more_screen.dart';
import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:calorie_tracker_app/widget/bottom_bar/tab_icon_data.dart';
import 'package:flutter/material.dart';

import 'bottom_bar_view.dart';

class BottomBarScreen extends StatefulWidget {
  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen>
    with TickerProviderStateMixin {
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
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    // 4. 创建tabBody，传入animationController
    tabBody = HomeScreen(animationController: animationController);

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
    return Container(
      color: AppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: _getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            return _buildContext(context, snapshot);
          },
        ),
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
          bottomBar(),
        ],
      );
    }
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              animationController?.reverse().then<dynamic>((data) {
                /**
                 * 在 Flutter 中，mounted 是一个非常重要的属性，它用于检查当前的 State 对象是否仍然挂载到其对应的 Widget 上。
                 * 这通常与异步操作和回调有关，是用来防止在 Widget 已经从界面上移除后，仍尝试更新其状态的情况，从而避免引发运行时错误。
                 */
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      HomeScreen(animationController: animationController);
                });
              });
            } else if (index == 1) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      FoodScreen(animationController: animationController);
                });
              });
            } else if (index == 2) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      DiaryScreen(animationController: animationController);
                });
              });
            } else if (index == 3) {
              animationController?.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MoreScreen(animationController: animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
