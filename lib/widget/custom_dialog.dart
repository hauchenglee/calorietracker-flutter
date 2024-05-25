import 'package:flutter/material.dart';

class CustomDialog {
  /// 适用于只需要显示信息或通知，而不需要获取用户选择的情况。
  void showCustomDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("CLOSE"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
          ],
        );
      },
    );
  }
}
