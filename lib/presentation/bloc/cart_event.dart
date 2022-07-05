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

class AddQuantityFruitEvent extends CartEvent {
  final Fruit fruit;

  const AddQuantityFruitEvent(this.fruit);

  @override
  List<Object> get props => [fruit];
}

class ReduceQuantityFruitEvent extends CartEvent {
  final Fruit fruit;

  const ReduceQuantityFruitEvent(this.fruit);

  @override
  List<Object> get props => [fruit];
}

class RemoveCartFruitEvent extends CartEvent {
  final Fruit fruit;

  const RemoveCartFruitEvent(this.fruit);

  @override
  List<Object> get props => [fruit];
}
