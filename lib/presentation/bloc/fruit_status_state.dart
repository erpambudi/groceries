part of 'fruit_status_cubit.dart';

abstract class FruitStatusState extends Equatable {
  const FruitStatusState();

  @override
  List<Object> get props => [];
}

class FruitStatusStateInitial extends FruitStatusState {}

class FruitStatusStateLoading extends FruitStatusState {}

class FruitStatusStateLoaded extends FruitStatusState {
  final Fruit? fruit;

  const FruitStatusStateLoaded({required this.fruit});

  @override
  List<Object> get props => [fruit ?? const []];
}

class FruitStatusStateError extends FruitStatusState {
  final String message;

  const FruitStatusStateError(this.message);

  @override
  List<Object> get props => [message];
}
