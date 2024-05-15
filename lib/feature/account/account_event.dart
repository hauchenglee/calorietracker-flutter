// Account Events
import 'account_model.dart';

abstract class AccountEvent {}
class AccountLoggedIn extends AccountEvent {
  final AccountModel account;
  AccountLoggedIn({required this.account});
}