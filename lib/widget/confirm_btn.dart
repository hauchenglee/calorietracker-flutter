import 'package:flutter/material.dart';

class ConfirmBtn extends StatelessWidget {
  const ConfirmBtn({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // 使用父组件的最大宽度的1/3作为按钮宽度
        double buttonWidth = constraints.maxWidth / 2;

        return Center(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent, // 设置按钮的背景颜色为蓝色
              foregroundColor: Colors.white, // 设置按钮的点击颜色（文本和图标）
              shape: RoundedRectangleBorder(
                // 设置按钮形状
                borderRadius: BorderRadius.circular(8), // 圆角矩形
              ),
              fixedSize: Size(buttonWidth, 48), // 设置固定尺寸，高度为48
            ),
            child:
                const Text("Confirm", style: TextStyle(fontSize: 16)), // 显示按钮文本
          ),
        );
      },
    );
  }
}
