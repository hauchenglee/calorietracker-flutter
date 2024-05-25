import 'package:calorie_tracker_app/widget/speedometer_all.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SpeedometerAll(percent: 0.0, currentNumber: 0, totalNumber: 0.0, size: 200, color: Colors.blue),
    );
  }
}
