import 'package:flutter/material.dart';

class FoodScreen extends StatefulWidget {
  final AnimationController? animationController;

  const FoodScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _FoodScreenState createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Food', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
