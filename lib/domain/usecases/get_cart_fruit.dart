import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/models/fruit.dart';
import '../repositories/cart_repository.dart';

class GetCartFruit {
  final CartRepository repository;

  GetCartFruit(this.repository);

  Future<Either<Failure, Fruit?>> execute(int id) {
    return repository.getFruitById(id);
  }
}
