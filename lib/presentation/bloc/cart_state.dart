part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartStateInitial extends CartState {}

class CartStateLoading extends CartState {}

class CartStateLoaded extends CartState {
  final List<Fruit> fruits;

  const CartStateLoaded({required this.fruits});

  @override
  List<Object> get props => [fruits];
}

class CartStateError extends CartState {
  final String message;

  const CartStateError(this.message);

  @override
  List<Object> get props => [message];
}
