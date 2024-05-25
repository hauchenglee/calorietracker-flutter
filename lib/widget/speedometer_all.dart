import 'dart:math';

import 'package:flutter/material.dart';

import '../util/app_theme.dart';

// 自定义绘制类，用于绘制圆形进度条
class SpeedometerPainter extends CustomPainter {
  final double percent; // 0.0至1.0之间，用于显示和绘制进度
  final double currentNumber;  // 当前数字
  final double totalNumber;    // 总数字
  final Color progressColor; // 进度条的颜色

  SpeedometerPainter(this.percent, this.currentNumber, this.totalNumber, this.progressColor);

  @override
  void paint(Canvas canvas, Size size) {
    double padAngle = pi / 2; // 开口的角度大小
    double startAngle = pi / 2 + padAngle / 2; // 起始角度，从底部中央开始
    double sweepAngle = 2 * pi - padAngle; // 进度条的扫描角度
    double radius = size.width / 2; // 半径取宽度的一半

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
      paint..color = AppTheme.circleBackward,
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
      style: TextStyle(color: AppTheme.circleText, fontSize: 50.0, fontWeight: FontWeight.bold),
      text: '${(percent * 100).toStringAsFixed(0)}%', // 将百分比转换为文本
    );
    TextPainter tp = TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(size.width / 2 - tp.width / 2, size.height / 2 - tp.height / 2));

    // 绘制 currentNumber
    TextSpan span2 = TextSpan(style: TextStyle(color: AppTheme.circleText, fontSize: 25.0, fontWeight: FontWeight.bold), text: '${(currentNumber * percent).toStringAsFixed(0)}');
    TextPainter tp2 = TextPainter(text: span2, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp2.layout();

    // 绘制 totalNumber span3
    TextSpan span3 = TextSpan(style: TextStyle(color: AppTheme.circleText, fontSize: 25.0, fontWeight: FontWeight.bold), text: '${(totalNumber * percent).toStringAsFixed(0)}');
    TextPainter tp3 = TextPainter(text: span3, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp3.layout();

    // currentNumber, totalNumber 用
    double totalWidth = tp2.width + tp3.width + 50; // 包括10像素间隔，要与下面的[间隔10像素]一起调整
    double startX = size.width / 2 - totalWidth / 2; // 计算两个文本组合后整体居中的起始x位置

    // 绘制第 2 个文本span
    tp2.paint(canvas, Offset(startX, size.height / 2 + radius + 20)); // 下移20单位，使其位于环形指示器底部

    // 绘制第 3 个文本，紧跟在 span2 之后
    tp3.paint(canvas, Offset(startX + tp2.width + 50, size.height / 2 + radius + 20)); // 间隔10像素

    // in user / total 文本用
    double startX2 = size.width / 2 - (tp2.width + tp3.width + 50) / 2; // 居中位置
    double startY = size.height / 2 + radius + 20; // Y坐标

    // 绘制“In Use”文本
    TextSpan labelSpan2 = TextSpan(style: TextStyle(color: AppTheme.circleText, fontSize: 15.0, fontWeight: FontWeight.normal), text: 'In Use');
    TextPainter labelTp2 = TextPainter(text: labelSpan2, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    labelTp2.layout();
    labelTp2.paint(canvas, Offset(startX2, startY - 30)); // 3px 间隔，稍微上移（左边对齐）

    // 绘制“Total”文本
    TextSpan labelSpan3 = TextSpan(style: TextStyle(color: AppTheme.circleText, fontSize: 15.0, fontWeight: FontWeight.normal), text: 'Total');
    TextPainter labelTp3 = TextPainter(text: labelSpan3, textAlign: TextAlign.left, textDirection: TextDirection.ltr);
    labelTp3.layout();
    labelTp3.paint(canvas, Offset(startX2 + tp2.width + 50, startY - 30)); // 3px 间隔

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
    double outerRadius = size.width / 2.5; // 顶点位置

    /// 底部稍微在顶点内侧
    double triangleRadius = outerRadius - 30;
    Offset center = Offset(size.width / 2, size.height / 2);
    Offset trianglePoint = Offset(center.dx + outerRadius * cos(currentAngle), center.dy + outerRadius * sin(currentAngle));

    // 计算底部角度较小的三角形
    double baseAngle = 0.1; // 较小的底部角度，使三角形更尖锐
    double insetDepth = 5; // 内缩深度

    Path path = Path();
    path.moveTo(trianglePoint.dx, trianglePoint.dy); // 顶点

    // 内缩点，朝内部凹陷
    Offset insetPoint = Offset(center.dx + (triangleRadius + insetDepth) * cos(currentAngle), center.dy + (triangleRadius + insetDepth) * sin(currentAngle));

    // 绘制路径，使底部朝内部凹陷
    path.lineTo(center.dx + triangleRadius * cos(currentAngle - baseAngle), center.dy + triangleRadius * sin(currentAngle - baseAngle));
    path.lineTo(insetPoint.dx, insetPoint.dy); // 内缩点
    path.lineTo(center.dx + triangleRadius * cos(currentAngle + baseAngle), center.dy + triangleRadius * sin(currentAngle + baseAngle));

    path.close();

    canvas.drawPath(path, trianglePaint);
  }

  @override
  bool shouldRepaint(covariant SpeedometerPainter oldDelegate) {
    return oldDelegate.percent != percent || oldDelegate.progressColor != progressColor; // 检查颜色改变
  }
}

// StatefulWidget，用于创建具有动画的进度条
class SpeedometerAll extends StatefulWidget {
  final double currentNumber;
  final double totalNumber;
  final double percent;
  final int size; // 进度条的尺寸
  final Color color; // 进度条的颜色

  SpeedometerAll({required this.currentNumber, required this.totalNumber, required this.percent, required this.size, this.color = Colors.blue}); // 添加颜色参数，默认为蓝色

  @override
  _SpeedometerAllState createState() => _SpeedometerAllState();
}

class _SpeedometerAllState extends State<SpeedometerAll> with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _animation;

  // double get percent => (widget.currentNumber / widget.totalNumber); // 动态计算百分比

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
          painter: SpeedometerPainter(_animation!.value, widget.currentNumber, widget.totalNumber, widget.color), // 使用动画的当前值和颜色绘制
        ),
      ),
    );
  }
}
