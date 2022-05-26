import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/domain/usecases/get_cart_fruits.dart';
import 'package:groceries/domain/usecases/update_cart_fruit.dart';

import '../../data/models/fruit.dart';
import '../../domain/usecases/get_cart_fruit.dart';
import '../../domain/usecases/remove_cart_fruit.dart';
import '../../domain/usecases/save_cart_fruit.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartFruits getCartFruits;
  final SaveCartFruit saveCartFruit;
  final RemoveCartFruit removeCartFruit;
  final UpdateCartFruit updateCartFruit;
  final GetCartFruit getCartFruit;

  CartBloc({
    required this.getCartFruits,
    required this.saveCartFruit,
    required this.removeCartFruit,
    required this.updateCartFruit,
    required this.getCartFruit,
  }) : super(CartStateInitial()) {
    on<CartEvent>(
      (event, emit) async {
        //Get all cart
        if (event is GetCartsEvent) {
          emit(CartStateLoading());
          final result = await getCartFruits.execute();
          result.fold(
            (failure) {
              log(failure.message);
              emit(const CartStateError('Error while loading cart'));
            },
            (fruit) {
              emit(CartStateLoaded(fruits: fruit));
            },
          );
        }

        //Save fruit to cart
        else if (event is SaveCartFruitEvent) {
          final result = await saveCartFruit.execute(event.fruit);
          result.fold(
            (failure) {
              log(failure.message);
              emit(const CartStateError('Failed to save fruit to cart'));
            },
            (data) {
              log(data);
            },
          );
        }

        //Update quantity
        else if (event is UpdateCartFruitEvent) {
          final result =
              await updateCartFruit.execute(event.fruit, event.quantity);
          result.fold(
            (failure) {
              log(failure.message);
              emit(const CartStateError('Update quantity failed'));
            },
            (data) async {
              log(data);
            },
          );
        }

        //Remove fruit from cart
        else if (event is RemoveCartFruitEvent) {
          final result = await removeCartFruit.execute(event.fruit);
          result.fold(
            (failure) {
              log(failure.message);
              emit(const CartStateError('Failed to remove fruit from cart'));
            },
            (data) async {
              log(data);
            },
          );
        }
      },
    );
  }
}
