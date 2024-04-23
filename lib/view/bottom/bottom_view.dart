import 'package:calorie_tracker_app/feature/addition/addition_form_screen.dart';
import 'package:calorie_tracker_app/util/app_color.dart';
import 'package:calorie_tracker_app/view/bottom/tab_clipper.dart';
import 'package:calorie_tracker_app/view/bottom/tab_icon_data.dart';
import 'package:calorie_tracker_app/view/bottom/tab_icons.dart';
import 'package:flutter/material.dart';

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
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      /**
       * SizedBox: 设定bottom中间icon的宽高数值
       * 相对于整个页面
       */
      child: SizedBox(
        width: 38 * 2.0,
        height: 38 + 62.0,
        child: Container(
          alignment: Alignment.topCenter,
          color: Colors.transparent,
          /**
           * SizedBox: 设置于中间加号的宽高数值
           * 相对于外一层的SizedBox
           */
          child: SizedBox(
            width: 38 * 2.0,
            height: 38 * 2.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ScaleTransition(
                alignment: Alignment.center,
                scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                        parent: animationController!,
                        curve: Curves.fastOutSlowIn)),
                child: Container(
                  // alignment: Alignment.center,s
                  decoration: BoxDecoration(
                    color: AppTheme.darkGrey,
                    /**
                     * 这段代码是一个渐变色设置，使用的是 LinearGradient 类，它属于 Flutter 中用于定义线性渐变的小部件。
                     * 在这里，渐变被应用于某个组件的 decoration 属性，比如一个 Container、BoxDecoration 或者其他可视化元素的背景。
                     */
                    // gradient: LinearGradient(
                    //     colors: [
                    //       AppTheme.nearlyDarkBlue,
                    //       HexColor('#6A88E5'),
                    //     ],
                    //     begin: Alignment.topLeft,
                    //     end: Alignment.bottomRight),
                    shape: BoxShape.circle,

                    /// 阴影特效
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: AppTheme.nearlyDarkBlue.withOpacity(0.4),
                          offset: const Offset(8.0, 16.0),
                          blurRadius: 16.0),
                    ],
                  ),
                  child: Material(
                    /// 设置 Material 小部件的背景颜色为透明。这样做是为了确保水墨效果（ink effect）是在一个透明的背景上呈现，不影响其他背景元素。
                    color: Colors.transparent,
                    child: InkWell(
                      /// 设置触摸波纹效果的颜色。这里使用白色的波纹，不过透明度设置为0.1，使得波纹效果非常微弱，几乎看不清，仅有轻微的视觉提示。
                      splashColor: Colors.white.withOpacity(0.1),

                      /// 设置高亮颜色为透明。在材料设计中，高亮颜色是指触摸或点击小部件时的背景颜色。透明表示没有明显的颜色变化。
                      highlightColor: Colors.transparent,

                      /// 设置聚焦时的颜色为透明。聚焦通常发生在用户通过键盘导航到小部件或小部件成为焦点时。透明意味着在聚焦时不会有任何颜色变化。
                      focusColor: Colors.transparent,

                      /// onTap 是一个回调函数，当用户点击这个 InkWell 时会被触发。widget.addClick 可能是外部传入的一个函数，用于处理点击事件。
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdditionFormScreen()),
                      ),
                      child: const Icon(
                        /// 这是 InkWell 的子小部件，一个图标。
                        Icons.add,

                        /// 设置图标的颜色为白色，这通常是为了确保图标在任何背景上都能清晰可见。
                        color: AppTheme.white,

                        /// 设置图标的大小为32像素。这是图标的尺寸，确保图标足够大，用户可以容易点击。
                        size: 32,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
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
