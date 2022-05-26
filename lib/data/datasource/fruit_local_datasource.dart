import '../../common/utils/exception.dart';
import '../models/fruit.dart';
import 'db/database_helper.dart';

abstract class FruitLocalDataSource {
  Future<String> insertFruit(Fruit fruit);
  Future<String> removeFruit(Fruit fruit);
  Future<Fruit?> getFruitById(int id);
  Future<List<Fruit>> getCartData();
  Future<String> updateQuantity(Fruit fruit, int quantity);
}

class FruitLocalDataSourceImpl implements FruitLocalDataSource {
  final DatabaseHelper databaseHelper;

  FruitLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertFruit(Fruit fruit) async {
    try {
      await databaseHelper.insertFruit(fruit);
      return 'Added to Cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeFruit(Fruit fruit) async {
    try {
      await databaseHelper.removeFruit(fruit);
      return 'Removed from Cart';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<Fruit?> getFruitById(int id) async {
    final result = await databaseHelper.getFruitById(id);
    if (result != null) {
      return Fruit.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<Fruit>> getCartData() async {
    final result = await databaseHelper.getCartData();
    return result.map((data) => Fruit.fromMap(data)).toList();
  }

  @override
  Future<String> updateQuantity(Fruit fruit, int quantity) async {
    try {
      await databaseHelper.updateQty(fruit, quantity);
      return 'Quantity Updated';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
