import 'package:flutter/material.dart';

class DiaryScreen extends StatefulWidget {
  final AnimationController? animationController;

  const DiaryScreen({Key? key, this.animationController}) : super(key: key);

  @override
  _DiaryScreenState createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Diary', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
