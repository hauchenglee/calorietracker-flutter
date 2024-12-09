import 'dart:io';

import 'package:calorie_tracker_app/feature/dashboard/bloc/dashboard_bloc.dart';
import 'package:calorie_tracker_app/feature/food_record/food_record_screen.dart';
import 'package:calorie_tracker_app/util/app_string.dart';
import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'feature/login/bloc/login_bloc.dart';
import 'init_screen.dart';

void main() async {
  // 确保Flutter小部件绑定已初始化，这对于所有后续操作都是必要的
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    // 在这里添加错误记录到日志系统或发送到服务器
  };

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 调整状态栏和导航栏的样式，确保应用的视觉风格一致。
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<DashboardBloc>(
          create: (context) => DashboardBloc(),
        ),
      ],
      child: MaterialApp(
        title: APP_NAME,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: AppTheme.textTheme,
          platform: TargetPlatform.iOS,
          scaffoldBackgroundColor: AppTheme.red, // 设置预设的背景色
        ),
        home: FoodRecordScreen(), // Start the app with the LoginScreen
      ),
    );
  }
}
