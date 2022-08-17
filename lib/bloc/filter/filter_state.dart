part of 'filter_bloc.dart';

@immutable
abstract class FilterState extends Equatable {
  const FilterState();

  @override
  List<Object> get props => [];
}

class FilterLoading extends FilterState {}

class FilterLoaded extends FilterState {
  final Filter filter;
  final List<Restaurant> filteredRestaurants;

  const FilterLoaded({
    this.filter = const Filter(),
    this.filteredRestaurants = const <Restaurant>[],
  });

  @override
  List<Object> get props => [
        filter,
        filteredRestaurants,
      ];
}
