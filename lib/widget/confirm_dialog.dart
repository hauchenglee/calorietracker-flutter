import 'package:flutter/material.dart';

/// 显示一个确认对话框并返回一个Future，该Future在对话框关闭时解析为用户的选择
/// 适用于需要等待用户选择，并根据选择结果执行后续操作的情况。
/// 对于 showDialog：因为 showDialog 本身返回 Future，所以在封装函数时加不加 async 都可以。
/// 对于其他异步操作的函数：建议使用 async 和 await 关键字，这样代码更简洁、易读，并且避免了手动管理 Future 的麻烦。
Future<bool?> showConfirmationDialog({
  required BuildContext context,
  required String title,
  required String content,
  String confirmText = '是',
  String cancelText = '否',
}) async {
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
