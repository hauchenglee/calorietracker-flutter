import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/api_response.dart';
import '../../account/account_model.dart';
import '../login_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  AccountModel? currentAccount;

  LoginBloc() : super(LoginInitialState()) {
    on<OnCheckExistEvent>(_onCheckExist);
    on<OnLoginEvent>(_onLogin);
    on<OnRegisterEvent>(_onRegister);
    on<OnAskRegister>(_onAskRegister);
  }

  // 提供一个方法来获取当前账户信息
  AccountModel? getCurrentAccount() {
    return currentAccount;
  }

  void _onCheckExist(OnCheckExistEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      ApiResponse response = await LoginService().checkExist(email: event.email);
      if (response.data == "true") {
        add(OnLoginEvent(event.email, event.password));
      } else {
        add(OnAskRegister());  // 触发询问是否注册的事件
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  void _onLogin(OnLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    await Future.delayed(Duration(seconds: 5));  // 添加5秒的模拟延时
    try {
      ApiResponse response = await LoginService().login(email: event.email, password: event.password);
      if (response.message.toUpperCase() == "SUCCESS") {
        // 直接尝试解析AccountModel，如果数据有问题将抛出异常
        AccountModel account = AccountModel.fromJson(response.data);
        currentAccount = account;  // 更新当前账户信息
        emit(LoginSuccessState(account)); // 发射成功状态
      } else {
        emit(LoginErrorState(response.message)); // API返回了失败消息
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  void _onRegister(OnRegisterEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    await Future.delayed(Duration(seconds: 4));  // 添加4秒的模拟延时
    try {
      ApiResponse response = await LoginService().register(email: event.email, password: event.password);
      if (response.message.toUpperCase() == "SUCCESS") {
        AccountModel account = AccountModel.fromJson(response.data);  // 尝试解析AccountModel
        currentAccount = account;  // 更新当前账户信息
        emit(RegisterSuccessState(account)); // 发射注册成功状态
      } else {
        emit(RegisterErrorState(response.message)); // API返回了失败消息
      }
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }

  void _onAskRegister(OnAskRegister event, Emitter<LoginState> emit) {
    // 这里可以发射一个特定的状态或者进行其他的逻辑处理，例如询问用户是否注册
    emit(AskRegisterState());  // 发射一个询问是否注册的状态
  }
}
