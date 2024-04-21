import 'package:calorie_tracker_app/view/bottom/tab_icon_data.dart';
import 'package:flutter/material.dart';

import 'tab_icons.dart';

class BottomView extends StatefulWidget {
  const BottomView(
      {Key? key, this.tabIconsList, this.changeIndex, this.addClick})
      : super(key: key);

  final Function(int index)? changeIndex;
  final Function()? addClick;
  final List<TabIconData>? tabIconsList;

  @override
  _BottomViewState createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> with TickerProviderStateMixin {
  /// 负责 bottom 的起始位置与结束位置
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.bottom,
            ),
            Container(
              /// 渲染阴影
              decoration: BoxDecoration(
                color: Colors.white, // 你可以根据需要调整颜色
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // 阴影颜色
                    spreadRadius: 1, // 阴影扩散程度
                    blurRadius: 10, // 阴影模糊程度
                    offset: Offset(0, 4), // 阴影的位置偏移
                  ),
                ],
              ),
              child:

                  /// 功能：SizedBox 用于给其子 widget 指定一个固定的大小。在这里，你设定了高度为 65 像素。
                  /// 由于没有指定宽度，SizedBox 的宽度将取决于其父容器的宽度或其内部子元素的宽度（如果存在的话）。
                  // 影响：确保了内部内容（在这个例子中是 Padding）具有最少 65 像素的高度。
                  SizedBox(
                height: 65,

                /// 功能：Padding widget 用于在其子 widget 的周围添加空白区域。在这个例子中，你为左侧和右侧各添加了 6 像素的填充，顶部添加了 2 像素的填充。
                // 影响：Padding 使得任何放置在其内部的子元素都会被这些指定的边距距离边界隔开。
                // 这里的代码实际上没有指定 Padding 的子元素，因此，尽管有填充，但没有可见的视觉效果，除非添加了子元素。
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, right: 6, top: 2),
                  child: Row(
                    children: <Widget>[
                      /// 在 Flutter 中，Expanded 小部件用于在 Row、Column 或 Flex 布局中强制其子小部件填充可用的空间。
                      /// 通过使用 Expanded，你可以控制布局中子小部件如何分配和占用多余的空间。
                      /// 简单来说：占领并填满剩余空间
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
            ),
          ],
        ),
      ],
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
