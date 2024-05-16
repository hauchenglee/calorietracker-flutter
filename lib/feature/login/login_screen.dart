import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calorie_tracker_app/util/app_theme.dart';
import 'package:calorie_tracker_app/widget/custom_dialog.dart';
import 'package:calorie_tracker_app/feature/account/bloc/account_bloc.dart';
import 'package:calorie_tracker_app/feature/account/bloc/account_event.dart';
import 'package:calorie_tracker_app/feature/account/bloc/account_state.dart';
import 'package:calorie_tracker_app/feature/login/login_service.dart';
import 'package:email_validator/email_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) => AccountBloc(LoginService()),
        child: CustomPaint(
          painter: BackgroundPainter(),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: screenHeight * 1 / 10),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.white,
                      ),
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
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
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          borderSide: BorderSide.none,
                        ),
                        hintText: 'Password',
                        hintStyle: TextStyle(color: Colors.grey[600]),
                        prefixIcon: Icon(Icons.lock, color: Colors.grey[600]),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.grey[600]),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      validator: (value) => _validatePassword(value ?? '') ? null : '密码必须为6-20位英文或数字',
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<AccountBloc, AccountState>(
                      listener: (context, state) {
                        if (state is AccountLoaded) {
                          CustomDialog().showCustomDialog(context, '登录成功');
                        } else if (state is AccountError) {
                          CustomDialog().showCustomDialog(context, state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is AccountLoading) {
                          return CircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AccountBloc>().add(
                                    LoginRequested(
                                      _emailController.text,
                                      _passwordController.text,
                                    ),
                                  );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.loginBtn,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          child: const Text('Register / Login'),
                        );
                      },
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
      ),
    );
  }

  bool _validateEmail(String email) {
    return EmailValidator.validate(email);
  }

  bool _validatePassword(String password) {
    String pattern = r'^[a-zA-Z0-9]{6,20}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(password) && password.length >= 6 && password.length <= 20;
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
