import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/models/fruit.dart';
import '../repositories/cart_repository.dart';

class UpdateCartFruit {
  final CartRepository repository;

  UpdateCartFruit(this.repository);

  Future<Either<Failure, String>> execute(Fruit fruit, int quantity) {
    return repository.updateQuantity(fruit, quantity);
  }
}
