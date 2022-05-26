import 'dart:io';

import 'package:groceries/domain/entities/account.dart';
import 'package:groceries/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:groceries/domain/repositories/account_repository.dart';

import '../../common/utils/exception.dart';
import '../datasource/account_remote_datasource.dart';

class AccountRepositoriesImpl implements AccountRepository {
  final AccountRemoteDatasource remoteDataSource;

  AccountRepositoriesImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Account>> getAccount() async {
    try {
      final result = await remoteDataSource.getAccount();
      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Server Problem'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
