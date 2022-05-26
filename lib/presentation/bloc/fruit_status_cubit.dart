import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/data/models/fruit.dart';
import 'package:groceries/domain/usecases/get_cart_fruit.dart';

part 'fruit_status_state.dart';

class FruitStatusCubit extends Cubit<FruitStatusState> {
  final GetCartFruit getCartFruit;

  FruitStatusCubit(this.getCartFruit) : super(FruitStatusStateInitial());

  Future<Fruit?> getFruitById(int id) async {
    emit(FruitStatusStateLoading());
    final result = await getCartFruit.execute(id);
    Fruit? fruitResult;
    result.fold(
      (failure) {
        log(failure.message);
        fruitResult = null;
        emit(const FruitStatusStateError('Error while loading cart'));
      },
      (fruit) {
        fruitResult = fruit;
        emit(FruitStatusStateLoaded(fruit: fruit));
      },
    );
    return fruitResult;
  }
}
