import 'package:equatable/equatable.dart';

// 登录事件的抽象基类，所有登录相关事件都将继承自此类
abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 检查用户是否存在的事件
class OnCheckExistEvent extends LoginEvent {
  final String email; // 用户邮箱
  final String password; // 用户密码

  OnCheckExistEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];  // 包含所有属性以确保正确比较
}

// 执行登录的事件
class OnLoginEvent extends LoginEvent {
  final String email; // 用户邮箱
  final String password; // 用户密码

  OnLoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// 询问是否注册
class OnAskRegister extends LoginEvent {
  @override
  List<Object?> get props => [];
}

// 执行注册的事件
class OnRegisterEvent extends LoginEvent {
  final String email; // 用户邮箱
  final String password; // 用户密码

  OnRegisterEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}
