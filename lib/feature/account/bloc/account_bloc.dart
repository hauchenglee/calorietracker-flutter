import 'package:bloc/bloc.dart';
import 'package:calorie_tracker_app/feature/account/account_model.dart';
import 'package:calorie_tracker_app/feature/login/login_service.dart';
import 'package:calorie_tracker_app/util/api_response.dart';

import 'account_event.dart';
import 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final LoginService loginService;

  AccountBloc(this.loginService) : super(AccountInitial());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async* {
    if (event is LoginRequested) {
      yield AccountLoading();
      try {
        ApiResponse loginResponse = await loginService.login(
          email: event.email,
          password: event.password,
        );
        AccountModel accountModel = loginResponse.data;
        yield AccountLoaded(accountModel);
      } catch (e) {
        yield AccountError(e.toString());
      }
    }
  }
}
