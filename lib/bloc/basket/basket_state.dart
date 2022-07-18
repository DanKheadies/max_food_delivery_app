part of 'basket_bloc.dart';

@immutable
abstract class BasketState extends Equatable {}

class BasketLoading extends BasketState {
  @override
  List<Object> get props => [];
}

class BasketLoaded extends BasketState {
  final Basket basket;

  BasketLoaded({required this.basket});

  @override
  List<Object> get props => [basket];
}
