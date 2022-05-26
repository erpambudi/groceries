part of 'account_bloc.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {
  @override
  List<Object> get props => [];
}

class AccountHasData extends AccountState {
  final Account result;

  const AccountHasData({required this.result});

  @override
  List<Object> get props => [result];
}

class AccountError extends AccountState {
  final String message;

  const AccountError(this.message);

  @override
  List<Object> get props => [message];
}
