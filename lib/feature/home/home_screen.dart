import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final AnimationController? animationController;

  const HomeScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Home', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
