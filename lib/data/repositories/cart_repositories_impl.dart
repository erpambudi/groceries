import 'package:groceries/data/datasource/fruit_local_datasource.dart';
import 'package:groceries/data/models/fruit.dart';
import 'package:groceries/common/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:groceries/domain/repositories/cart_repository.dart';

import '../../common/utils/exception.dart';

class CartRepositoriesImpl implements CartRepository {
  final FruitLocalDataSource localDataSource;

  CartRepositoriesImpl({required this.localDataSource});

  @override
  Future<Either<Failure, String>> saveFruit(Fruit fruit) async {
    try {
      final result = await localDataSource.insertFruit(fruit);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, List<Fruit>>> getCartData() async {
    try {
      final result = await localDataSource.getCartData();
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, String>> removeFruit(Fruit fruit) async {
    try {
      final result = await localDataSource.removeFruit(fruit);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, String>> updateQuantity(
      Fruit fruit, int quantity) async {
    try {
      final result = await localDataSource.updateQuantity(fruit, quantity);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Either<Failure, Fruit?>> getFruitById(int id) async {
    try {
      final result = await localDataSource.getFruitById(id);
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw Exception();
    }
  }
}
