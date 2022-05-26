import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/domain/entities/account.dart';
import 'package:groceries/domain/usecases/get_account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final GetAccountDetail getAccountDetail;

  AccountBloc(this.getAccountDetail) : super(AccountInitial()) {
    on<GetAccountEvent>((event, emit) async {
      emit(AccountLoading());

      final result = await getAccountDetail.execute();

      result.fold((failure) {
        emit(AccountError(failure.message));
      }, (data) {
        emit(AccountHasData(result: data));
      });
    });
  }
}
