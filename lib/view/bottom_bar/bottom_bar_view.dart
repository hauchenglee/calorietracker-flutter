import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:calorie_tracker_app/view/addition/addition_bar_view.dart';
import 'package:calorie_tracker_app/view/bottom_bar/tab_icon_data.dart';
import 'package:flutter/material.dart';

import 'tab_clipper.dart';
import 'tab_icons.dart';

class BottomBarView extends StatefulWidget {
  const BottomBarView(
      {Key? key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index)? changeIndex;
  final Function()? addClick;
  final List<TabIconData>? tabIconsList;

  @override
  _BottomBarViewState createState() => _BottomBarViewState();
}

class _BottomBarViewState extends State<BottomBarView>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    animationController?.forward();
    super.initState();
  }

  /// 负责 bottom 的起始位置与结束位置
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        _animatedBuilder(),
        _padding(),
      ],
    );
  }

  /// 负责处理Tab动画生成
  Widget _animatedBuilder() {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return Transform(
          transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          child: PhysicalShape(
            color: AppTheme.white,
            elevation: 16.0,
            clipper: TabClipper(
                radius: Tween<double>(begin: 0.0, end: 1.0)
                        .animate(CurvedAnimation(
                            parent: animationController!,
                            curve: Curves.fastOutSlowIn))
                        .value *
                    38.0),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 65,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6, top: 2),
                    child: Row(
                      children: <Widget>[
                        /**
                         * 在 Flutter 中，Expanded 小部件用于在 Row、Column 或 Flex 布局中强制其子小部件填充可用的空间。
                         * 通过使用 Expanded，你可以控制布局中子小部件如何分配和占用多余的空间。
                         * 简单来说：占领并填满剩余空间
                         */
                        Expanded(
                          child: TabIcons(
                              tabIconData: widget.tabIconsList?[0],
                              removeAllSelect: () {
                                setRemoveAllSelection(widget.tabIconsList?[0]);
                                widget.changeIndex!(0);
                              }),
                        ),
                        Expanded(
                          child: TabIcons(
                              tabIconData: widget.tabIconsList?[1],
                              removeAllSelect: () {
                                setRemoveAllSelection(widget.tabIconsList?[1]);
                                widget.changeIndex!(1);
                              }),
                        ),
                        SizedBox(
                          width: Tween<double>(begin: 0.0, end: 1.0)
                                  .animate(CurvedAnimation(
                                      parent: animationController!,
                                      curve: Curves.fastOutSlowIn))
                                  .value *
                              64.0,
                        ),

                        /// 往旁边两侧挤压
                        Expanded(
                          child: TabIcons(
                              tabIconData: widget.tabIconsList?[2],
                              removeAllSelect: () {
                                setRemoveAllSelection(widget.tabIconsList?[2]);
                                widget.changeIndex!(2);
                              }),
                        ),
                        Expanded(
                          child: TabIcons(
                              tabIconData: widget.tabIconsList?[3],
                              removeAllSelect: () {
                                setRemoveAllSelection(widget.tabIconsList?[3]);
                                widget.changeIndex!(3);
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).padding.bottom,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  /// 负责处理中间加号
  Widget _padding() {
    return Padding(
      /// 在该组件的底部添加一个与设备的底部安全区高度相等的内边距
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),

      /// 设置相对于页面
      child: Container(
        width: 38 * 2.0,
        height: 38 + 62.0,
        alignment: Alignment.topCenter,

        /// 设置相对于父元件
        child: Container(
          width: 38 * 2.0,
          height: 32 * 2.0,
          color: Colors.transparent,
          child: AdditionBarView(), // 假设 AdditionBarView 是你要显示的自定义视图或部件
        ),
      ),
    );
  }

  void setRemoveAllSelection(TabIconData? tabIconData) {
    if (!mounted) return;
    setState(() {
      widget.tabIconsList?.forEach((TabIconData tab) {
        tab.isSelected = false;
        if (tabIconData!.index == tab.index) {
          tab.isSelected = true;
        }
      });
    });
  }
}
