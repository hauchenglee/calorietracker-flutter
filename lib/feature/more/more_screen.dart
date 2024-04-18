import 'package:flutter/material.dart';

class MoreScreen extends StatefulWidget {
  final AnimationController? animationController;

  const MoreScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('More', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
