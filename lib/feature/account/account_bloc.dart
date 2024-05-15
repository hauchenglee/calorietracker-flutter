import 'package:flutter_bloc/flutter_bloc.dart';

import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc() : super(AccountInitial()) {
    on<AccountLoggedIn>((event, emit) {
      // 假设你已经在event中得到了用户信息
      // 发出一个新的状态，包含用户信息
      emit(AccountLoaded(event.account));
    });
  }
}