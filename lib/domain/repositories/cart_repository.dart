import 'package:dartz/dartz.dart';
import 'package:groceries/data/models/fruit.dart';

import '../../common/utils/failure.dart';

abstract class CartRepository {
  Future<Either<Failure, String>> saveFruit(Fruit fruit);
  Future<Either<Failure, String>> removeFruit(Fruit fruit);
  Future<Either<Failure, Fruit?>> getFruitById(int id);
  Future<Either<Failure, List<Fruit>>> getCartData();
  Future<Either<Failure, String>> updateQuantity(Fruit fruit, int quantity);
}
