// import 'package:flutter/material.dart';
//
// /// 定义一个继承自AlertDialog的类CustomDialog，用于创建自定义对话框
// /// https://www.jianshu.com/p/4144837a789b
// class CustomDialog extends AlertDialog {
//   /// 构造函数接受一个Widget类型的参数contentWidget，并利用super.key来传递可选的key参数
//   CustomDialog({super.key, required Widget contentWidget})
//       : super(
//           /// 将传入的contentWidget作为对话框的内容
//           content: contentWidget,
//
//           /// 设置内容的内边距为零，意味着内容将直接贴近对话框边缘
//           contentPadding: EdgeInsets.zero,
//
//           /// 设置对话框的外形为圆角矩形，圆角大小为20
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//
//             /// 边框设置颜色，宽度
//             side: const BorderSide(color: Colors.transparent, width: 0),
//           ),
//         );
// }
