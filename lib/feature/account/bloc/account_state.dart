import 'package:equatable/equatable.dart';
import 'package:calorie_tracker_app/feature/account/account_model.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {
  final AccountModel accountModel;

  const AccountLoaded(this.accountModel);

  @override
  List<Object> get props => [accountModel];
}

class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object> get props => [message];
}
