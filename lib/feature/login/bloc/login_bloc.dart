import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../util/api_response.dart';
import '../../account/account_model.dart';
import '../login_service.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<OnCheckExistEvent>(_onCheckExist);
    on<OnLoginEvent>(_onLogin);
    on<OnRegisterEvent>(_onRegister);
  }

  void _onCheckExist(OnCheckExistEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    try {
      ApiResponse response = await LoginService().checkExist(email: event.email);
      if (response.data == "true") {
        add(OnLoginEvent(event.email, event.password));
      } else {
        emit(AskRegisterState()); // 状态提示用户是否注册
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  void _onLogin(OnLoginEvent event, Emitter<LoginState> emit) async {
    try {
      ApiResponse response = await LoginService().login(email: event.email, password: event.password);
      if (response.message.toUpperCase() == "SUCCESS") {
        AccountModel account = AccountModel.fromJson(response.data);
        emit(LoginSuccessState(account));
      } else {
        emit(LoginErrorState(response.message));
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  void _onRegister(OnRegisterEvent event, Emitter<LoginState> emit) async {
    try {
      ApiResponse response = await LoginService().register(email: event.email, password: event.password);
      if (response.message.toUpperCase() == "SUCCESS") {
        AccountModel account = AccountModel.fromJson(response.data);
        emit(RegisterSuccessState(account));
      } else {
        emit(RegisterErrorState(response.message));
      }
    } catch (e) {
      emit(RegisterErrorState(e.toString()));
    }
  }
}
