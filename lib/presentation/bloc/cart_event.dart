part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetCartsEvent extends CartEvent {}

class SaveCartFruitEvent extends CartEvent {
  final Fruit fruit;

  const SaveCartFruitEvent(this.fruit);

  @override
  List<Object> get props => [fruit];
}

class UpdateCartFruitEvent extends CartEvent {
  final Fruit fruit;
  final int quantity;

  const UpdateCartFruitEvent(this.fruit, this.quantity);

  @override
  List<Object> get props => [fruit, quantity];
}

class RemoveCartFruitEvent extends CartEvent {
  final Fruit fruit;

  const RemoveCartFruitEvent(this.fruit);

  @override
  List<Object> get props => [fruit];
}
