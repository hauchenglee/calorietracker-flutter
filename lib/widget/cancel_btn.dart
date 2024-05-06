import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:flutter/material.dart';

class CancelBtn extends StatelessWidget {
  const CancelBtn({
    super.key,
    this.onPressed,
    required this.message,
    required this.widthScale,
  });

  final VoidCallback? onPressed;
  final String message;
  final int widthScale;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 使用父组件的最大宽度的1/3作为按钮宽度
        double buttonWidth = constraints.maxWidth / widthScale;

        return Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.white, // 设置按钮的背景颜色为蓝色
              foregroundColor: AppTheme.black, // 设置按钮的点击颜色（文本和图标）
              shape: RoundedRectangleBorder(
                // 设置按钮形状
                borderRadius: BorderRadius.circular(50), // 圆角矩形
                side: const BorderSide(color: AppTheme.black, width: 0.5), // 添加黑色边框，宽度为1.0
              ),
              fixedSize: Size(buttonWidth, 48), // 设置固定尺寸，高度为48
            ),
            child: Text(message, style: TextStyle(fontSize: 16)), // 显示按钮文本
          ),
        );
      },
    );
  }
}
