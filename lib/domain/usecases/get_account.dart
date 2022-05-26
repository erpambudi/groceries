import 'package:dartz/dartz.dart';
import 'package:groceries/domain/entities/account.dart';
import 'package:groceries/domain/repositories/account_repository.dart';

import '../../common/utils/failure.dart';

class GetAccountDetail {
  final AccountRepository repository;

  GetAccountDetail(this.repository);

  Future<Either<Failure, Account>> execute() {
    return repository.getAccount();
  }
}
