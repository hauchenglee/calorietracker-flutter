import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view/navigation/navigation_view.dart';
import 'bloc/login_bloc.dart';
import 'bloc/login_event.dart';
import 'bloc/login_state.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState || state is RegisterSuccessState) {
          if (!mounted) return;  // 确保在进行导航前，当前 widget 仍然被挂载
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigationView()),
          );
          _setLoadingFalse();
        } else if (state is LoginErrorState || state is RegisterErrorState) {
          if (!mounted) return;  // 同样，确保在显示对话框前，当前 widget 仍然被挂载
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('错误'),
              content: Text(state is LoginErrorState ? state.message : (state as RegisterErrorState).message),
              actions: <Widget>[
                TextButton(
                  child: const Text('关闭'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          );
          _setLoadingFalse();
        } else if (state is AskRegisterState) {
          if (!mounted) return;
          showRegistrationDialog(context);
        }
      },
      child: buildBody(context),
    );
  }

  // 只有在_loading状态需要改变时才调用setState
  void _setLoadingFalse() {
    if (_isLoading) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget buildBody(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(  // 使用 Stack 来叠加屏幕内容和加载指示器
        children: [
          CustomPaint(
            painter: BackgroundPainter(),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: screenHeight * 0.1),
                      const Text('Login', style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: AppTheme.white)),
                      const SizedBox(height: 40),
                      buildEmailField(),
                      const SizedBox(height: 20),
                      buildPasswordField(),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: !_isLoading ? () => _onPressLogin(context) : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.loginBtn,
                          foregroundColor: AppTheme.white,
                          minimumSize: Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Text('Login'),
                      ),

                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot your password?', style: TextStyle(color: AppTheme.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (_isLoading)
            Container(
              color: Colors.black.withOpacity(0.5),
              child: const Center(
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppTheme.white)),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        hintText: 'email@account.com',
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.person, color: Colors.grey[600]),
      ),
      validator: (value) => _validateEmail(value ?? '') ? null : '无效的邮箱地址',
    );
  }

  Widget buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppTheme.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: BorderSide.none,
        ),
        hintText: 'Password',
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey[600],
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) => _validatePassword(value ?? '') ? null : '密码必须为6-20位英文或数字',
    );
  }

  bool _validateEmail(String email) {
    return EmailValidator.validate(email);  // 这需要从一个第三方库引入EmailValidator
  }

  bool _validatePassword(String password) {
    String pattern = r'^[a-zA-Z0-9]{6,20}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password) && password.length >= 6 && password.length <= 20;
  }

  void _onPressLogin(BuildContext context) {
    // 隐藏软键盘
    FocusScope.of(context).unfocus();

    // 检查表单验证
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    // 触发登录事件
    BlocProvider.of<LoginBloc>(context).add(OnCheckExistEvent(_emailController.text, _passwordController.text));
  }

  void showRegistrationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('账户不存在'),
          content: Text('您希望注册新账户吗？'),
          actions: <Widget>[
            TextButton(
              child: Text('否'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('是'),
              onPressed: () {
                Navigator.of(context).pop();
                BlocProvider.of<LoginBloc>(context).add(
                    OnRegisterEvent(_emailController.text, _passwordController.text)
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    Path mainBackground = Path();
    mainBackground.addRect(Rect.fromLTRB(0, 0, size.width, size.height));
    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [AppTheme.login1, AppTheme.login2],
    ).createShader(Rect.fromLTRB(0, 0, size.width, size.height));
    canvas.drawPath(mainBackground, paint);

    // 保持波浪形状不变，调整波浪的基线到页面的三分之二位置
    Path wavePath = Path();
    double baseHeight = size.height * 3 / 4; // 波浪的基线位置
    wavePath.lineTo(0, baseHeight);
    wavePath.quadraticBezierTo(size.width * 0.25, baseHeight - 50, size.width * 0.5, baseHeight);
    wavePath.quadraticBezierTo(size.width * 0.75, baseHeight + 50, size.width, baseHeight);
    wavePath.lineTo(size.width, size.height);
    wavePath.lineTo(0, size.height);
    wavePath.close();

    paint.shader = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xFFFFFFFF), Color(0xFFFFFFFF)],
    ).createShader(Rect.fromLTRB(0, baseHeight, size.width, size.height));
    canvas.drawPath(wavePath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
