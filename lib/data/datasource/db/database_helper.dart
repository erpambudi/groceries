import 'dart:async';

import 'package:groceries/data/models/fruit.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblCart = 'cart';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/groceries.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblCart (
        id INTEGER PRIMARY KEY,
        name TEXT,
        price INTEGER,
        imageUrl TEXT,
        rating INTEGER,
        totalInCart INTEGER
      );
    ''');
  }

  Future<int> insertFruit(Fruit fruit) async {
    final db = await database;
    return await db!.insert(_tblCart, fruit.toJson());
  }

  Future<int> removeFruit(Fruit fruit) async {
    final db = await database;
    return await db!.delete(
      _tblCart,
      where: 'id = ?',
      whereArgs: [fruit.id],
    );
  }

  Future<int> updateQty(Fruit fruit, int quantity) async {
    final db = await database;
    return await db!.update(
      _tblCart,
      {'totalInCart': quantity},
      where: 'id = ?',
      whereArgs: [fruit.id],
    );
  }

  Future<Map<String, dynamic>?> getFruitById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblCart,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getCartData() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db!.query(_tblCart);

    return results;
  }
}
