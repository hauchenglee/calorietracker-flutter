import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:flutter/material.dart';

import 'tab_icon_data.dart';

class TabIcons extends StatefulWidget {
  const TabIcons({Key? key, this.tabIconData, this.removeAllSelect})
      : super(key: key);

  final TabIconData? tabIconData;
  final Function()? removeAllSelect;

  @override
  _TabIconsState createState() => _TabIconsState();
}

class _TabIconsState extends State<TabIcons> with TickerProviderStateMixin {
  @override
  void initState() {
    widget.tabIconData?.animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          if (!mounted) return;
          widget.removeAllSelect!();
          widget.tabIconData?.animationController?.reverse();
        }
      });
    super.initState();
  }

  void setAnimation() {
    widget.tabIconData?.animationController?.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // 确保外层容器保持正方形形状
      child: Material(
        color: Colors.transparent, // 确保Material不影响背景颜色
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // 确保背景是圆形
          ),
          child: InkWell(
            onTap: () {
              if (!widget.tabIconData!.isSelected) {
                setAnimation();
              }
            },
            // 使用CircleBorder确保水波纹的形状为圆形
            customBorder: const CircleBorder(),
            child: Container(
              alignment: Alignment.center,
              child: Icon(
                widget.tabIconData?.iconData,
                size: 24,
                color: AppTheme.grey, // 替换为适当的颜色或AppTheme.lightText
              ),
            ),
          ),
        ),
      ),
    );
  }
}
