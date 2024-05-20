import 'dart:math';

import 'package:flutter/material.dart';

// 自定义绘制类，用于绘制圆形进度条
// 自定义绘制类，用于绘制圆形进度条
class SpeedometerPainter extends CustomPainter {
  final double percent; // 0.0至1.0之间，用于显示和绘制进度
  final Color progressColor; // 进度条的颜色

  SpeedometerPainter(this.percent, this.progressColor);

  @override
  void paint(Canvas canvas, Size size) {
    double padAngle = pi / 4; // 开口的角度大小
    double startAngle = pi / 2 + padAngle / 2; // 起始角度，从底部中央开始
    double sweepAngle = 2 * pi - padAngle; // 进度条的扫描角度

    Paint paint = Paint()
      ..color = progressColor // 使用传入的颜色绘制进度条
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..strokeCap = StrokeCap.round;

    // 绘制背景圆环
    canvas.drawArc(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
      startAngle,
      sweepAngle,
      false,
      paint..color = Colors.grey.withOpacity(0.3),
    );

    // 绘制进度圆环
    canvas.drawArc(
      Rect.fromCenter(center: Offset(size.width / 2, size.height / 2), width: size.width, height: size.height),
      startAngle,
      sweepAngle * percent,
      false,
      paint..color = progressColor,
    );

    // 绘制进度百分比文本
    TextSpan span = TextSpan(
      style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      text: '${(percent * 100).toStringAsFixed(0)}%', // 将百分比转换为文本
    );
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant SpeedometerPainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.progressColor != progressColor; // 检查颜色改变
  }
}

// StatefulWidget，用于创建具有动画的进度条
class Speedometer extends StatefulWidget {
  final double percent; // 进度条的目标百分比
  final int size; // 进度条的尺寸
  final Color color; // 进度条的颜色

  Speedometer({this.percent = 0.0, required this.size, this.color = Colors.blue}); // 添加颜色参数，默认为蓝色

  @override
  _SpeedometerState createState() => _SpeedometerState();
}

class _SpeedometerState extends State<Speedometer> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // 动画时长
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: widget.percent).animate(CurvedAnimation(
      parent: _controller!,
      curve: Curves.easeInOut, // 动画曲线
    ))
      ..addListener(() {
        setState(() {}); // 动画值变化时重新绘制
      });

    _controller!.forward(); // 启动动画
  }

  @override
  void dispose() {
    _controller?.dispose(); // 销毁控制器
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: widget.size.toDouble(), // 使用widget.size设置尺寸
        height: widget.size.toDouble(),
        child: CustomPaint(
          painter: SpeedometerPainter(_animation!.value, widget.color), // 使用动画的当前值和颜色绘制
        ),
      ),
    );
  }
}
