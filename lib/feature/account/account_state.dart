// Account States
import 'account_model.dart';

abstract class AccountState {}
class AccountInitial extends AccountState {}
class AccountLoaded extends AccountState {
  final AccountModel account;
  AccountLoaded(this.account);
}