import 'package:dartz/dartz.dart';

import '../../common/utils/failure.dart';
import '../../data/models/fruit.dart';
import '../repositories/cart_repository.dart';

class SaveCartFruit {
  final CartRepository repository;

  SaveCartFruit(this.repository);

  Future<Either<Failure, String>> execute(Fruit fruit) {
    return repository.saveFruit(fruit);
  }
}
