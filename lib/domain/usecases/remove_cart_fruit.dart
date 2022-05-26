import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/models/fruit.dart';
import '../repositories/cart_repository.dart';

class RemoveCartFruit {
  final CartRepository repository;

  RemoveCartFruit(this.repository);

  Future<Either<Failure, String>> execute(Fruit fruit) {
    return repository.removeFruit(fruit);
  }
}
