import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../entities/account.dart';

abstract class AccountRepository {
  Future<Either<Failure, Account>> getAccount();
}
