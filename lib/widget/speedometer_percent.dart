import 'dart:math';

import 'package:flutter/material.dart';

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
      style: TextStyle(color: Colors.black, fontSize: 50.0, fontWeight: FontWeight.bold),
      text: '${(percent * 100).toStringAsFixed(0)}%', // 将百分比转换为文本
    );
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));

    // 绘制三角形指示器
    _drawSharpTriangleIndicator(canvas, size, startAngle, sweepAngle);
  }

  // 绘制锐角三角形指示器
  void _drawSharpTriangleIndicator(Canvas canvas, Size size, double startAngle, double sweepAngle) {
    Paint trianglePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    double currentAngle = startAngle + sweepAngle * percent;

    /// 指示器顶点到圆心的距离。
    double outerRadius = size.width / 2.5;  // 顶点位置

    /// 底部稍微在顶点内侧
    double triangleRadius = outerRadius - 30;
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset trianglePoint = Offset(center.dx + outerRadius * cos(currentAngle), center.dy + outerRadius * sin(currentAngle));

    // 计算底部角度较小的三角形
    double baseAngle = 0.1; // 较小的底部角度，使三角形更尖锐
    double insetDepth = 5; // 内缩深度

    Path path = Path();
    path.moveTo(trianglePoint.dx, trianglePoint.dy);  // 顶点

    // 内缩点，朝内部凹陷
    Offset insetPoint = Offset(
        center.dx + (triangleRadius + insetDepth) * cos(currentAngle),
        center.dy + (triangleRadius + insetDepth) * sin(currentAngle)
    );

    // 绘制路径，使底部朝内部凹陷
    path.lineTo(
        center.dx + triangleRadius * cos(currentAngle - baseAngle),
        center.dy + triangleRadius * sin(currentAngle - baseAngle)
    );
    path.lineTo(insetPoint.dx, insetPoint.dy);  // 内缩点
    path.lineTo(
        center.dx + triangleRadius * cos(currentAngle + baseAngle),
        center.dy + triangleRadius * sin(currentAngle + baseAngle)
    );

    path.close();

    canvas.drawPath(path, trianglePaint);
  }

  @override
  bool shouldRepaint(covariant SpeedometerPainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.progressColor != progressColor; // 检查颜色改变
  }
}

// StatefulWidget，用于创建具有动画的进度条
class SpeedometerPercent extends StatefulWidget {
  final double currentNumber;
  final double totalNumber;
  final int size; // 进度条的尺寸
  final Color color; // 进度条的颜色

  SpeedometerPercent({required this.currentNumber, required this.totalNumber, required this.size, this.color = Colors.blue}); // 添加颜色参数，默认为蓝色

  @override
  _SpeedometerPercentState createState() => _SpeedometerPercentState();
}

class _SpeedometerPercentState extends State<SpeedometerPercent> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;
  double get percent => (widget.currentNumber / widget.totalNumber); // 动态计算百分比

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // 动画时长
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: percent).animate(CurvedAnimation(
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
