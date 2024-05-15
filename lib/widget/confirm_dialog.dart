// 在您的Dart文件中导入Flutter material包
import 'package:flutter/material.dart';

/// 显示一个确认对话框并返回一个Future，该Future在对话框关闭时解析为用户的选择
Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = '是',
  String cancelText = '否',
}) {
  // 显示对话框
  return showDialog<bool>(
    context: context,
    barrierDismissible: false,  // 用户必须点击按钮才能关闭对话框
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(cancelText),
            onPressed: () => Navigator.of(context).pop(false), // 返回false
          ),
          TextButton(
            child: Text(confirmText),
            onPressed: () => Navigator.of(context).pop(true), // 返回true
          ),
        ],
      );
    },
  );
}
