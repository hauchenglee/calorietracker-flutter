import 'package:calorie_tracker_app/view/navigation/navigation_view.dart';
import 'package:flutter/material.dart';

import 'config/token_manager.dart';
import 'feature/login/login_screen.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  @override
  void initState() {
    super.initState();
    _checkToken();
  }

  // 模拟Token验证过程
  void _checkToken() async {
    // 假设 `authenticate()` 是验证Token的函数
    // 这里使用延迟来模拟网络请求
    await Future.delayed(const Duration(seconds: 3));

    TokenManager tokenManager = TokenManager();
    bool isValid = await tokenManager.checkTokenValidity(); // 你需要从你的认证服务获取实际的Token状态

    if (isValid) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const NavigationView()));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // 显示加载指示器
      ),
    );
  }
}
