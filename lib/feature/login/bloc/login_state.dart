import 'package:calorie_tracker_app/feature/account/account_model.dart';
import 'package:equatable/equatable.dart';

// 登录状态的抽象基类，所有登录相关状态都将继承自此类
abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

// 初始状态，表示登录流程的开始，用于初始化UI组件或变量。
class LoginInitialState extends LoginState {}

// 加载状态，通常用于在进行API调用期间显示加载动画。
// 这个状态可以在调用后端服务等待响应时显示一个进度指示器，通知用户当前操作正在进行中。
class LoginLoadingState extends LoginState {}

// 询问是否注册
class AskRegisterState extends LoginState {}

// 登录成功状态，存储登录成功后的用户信息。
// 当从后端成功接收到用户数据后，可以使用此状态来更新应用的UI，显示登录成功并跳转到相应的页面。
class LoginSuccessState extends LoginState {
  final AccountModel account; // 登录成功后获取的用户账户信息，包含了用户的详细信息如ID、邮箱等。

  LoginSuccessState(this.account);

  @override
  List<Object?> get props => [account]; // 使用account作为比较基准，确保当用户信息发生变化时，状态可以正确更新。
}

// 登录失败状态，存储错误信息。
// 这个状态用于处理登录过程中可能出现的各种错误，如网络问题、错误的用户凭证等。
class LoginErrorState extends LoginState {
  final String message; // 登录失败时的错误信息，这个消息通常是从后端服务或异常捕获中获得的。

  LoginErrorState(this.message);

  @override
  List<Object?> get props => [message]; // 使用message作为比较基准，当错误信息相同时，视为相同状态。
}

class RegisterSuccessState extends LoginState {
  final AccountModel account;

  RegisterSuccessState(this.account);

  @override
  List<Object?> get props => [account];
}

class RegisterErrorState extends LoginState {
  final String message;

  RegisterErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
