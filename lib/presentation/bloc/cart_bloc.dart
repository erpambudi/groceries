import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groceries/domain/usecases/get_cart_fruits.dart';
import 'package:groceries/domain/usecases/update_cart_fruit.dart';
import 'package:rxdart/rxdart.dart';

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
    on<GetCartsEvent>(_onGetCartsFruit);
    on<SaveCartFruitEvent>(_onSaveFruit);
    on<AddQuantityFruitEvent>(_onAddQuantityFruit);
    on<ReduceQuantityFruitEvent>(_onReduceQuantityFruit);
    on<RemoveCartFruitEvent>(_onRemoveFruit);
  }

  void _onGetCartsFruit(GetCartsEvent event, Emitter<CartState> emit) async {
    final result = await getCartFruits.execute();
    result.fold(
      (failure) {
        log(failure.message);
        emit(const CartStateError('Error while loading cart'));
      },
      (fruits) {
        int totalPrice = 0;
        int totalItems = 0;

        for (final fruit in fruits) {
          totalPrice += fruit.price * fruit.totalInCart;
          totalItems += fruit.totalInCart;
        }

        emit(CartStateLoaded(
            fruits: fruits, totalPrice: totalPrice, totalItems: totalItems));
      },
    );
  }

  void _onSaveFruit(SaveCartFruitEvent event, Emitter<CartState> emit) async {
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

  void _onAddQuantityFruit(
      AddQuantityFruitEvent event, Emitter<CartState> emit) async {
    int quantity = event.fruit.totalInCart + 1;

    final result = await updateCartFruit.execute(event.fruit, quantity);
    result.fold(
      (failure) {
        log(failure.message);
        emit(const CartStateError('Add quantity failed'));
      },
      (data) async {
        log(data);
      },
    );
  }

  void _onReduceQuantityFruit(
      ReduceQuantityFruitEvent event, Emitter<CartState> emit) async {
    if (event.fruit.totalInCart != 1) {
      int quantity = event.fruit.totalInCart - 1;
      final result = await updateCartFruit.execute(event.fruit, quantity);
      result.fold(
        (failure) {
          log(failure.message);
          emit(const CartStateError('Reduce quantity failed'));
        },
        (data) async {
          log(data);
        },
      );
    } else {
      log('Cannot reduce quantity');
    }
  }

  void _onRemoveFruit(
      RemoveCartFruitEvent event, Emitter<CartState> emit) async {
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

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
