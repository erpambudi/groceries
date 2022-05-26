import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/models/fruit.dart';
import '../repositories/cart_repository.dart';

class GetCartFruits {
  final CartRepository repository;

  GetCartFruits(this.repository);

  Future<Either<Failure, List<Fruit>>> execute() {
    return repository.getCartData();
  }
}
