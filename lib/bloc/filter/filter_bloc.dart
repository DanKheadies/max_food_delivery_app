import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/models/models.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final RestaurantBloc _restaurantBloc;

  FilterBloc({
    required RestaurantBloc restaurantBloc,
  })  : _restaurantBloc = restaurantBloc,
        super(FilterLoading()) {
    on<LoadFilter>(_onLoadFilter);
    on<UpdateCategoryFilter>(_onUpdateCategoryFilter);
    on<UpdatePriceFilter>(_onUpdatePriceFilter);
  }

  // @override
  // Stream<FilterState> mapEventToState(
  //   FilterEvent event,
  // ) async* {
  //   if (event is FilterLoad) {
  //     yield* _mapFilterLoadToState();
  //   }
  //   if (event is CategoryFilterUpdated) {
  //     yield* _mapCategoryFilterUpdated(event, state);
  //   }
  //   if (event is PriceFilterUpdated) {
  //     yield* _mapPriceFilterUpdated(event, state);
  //   }
  // }

  void _onLoadFilter(
    LoadFilter event,
    Emitter<FilterState> emit,
  ) {
    emit(
      FilterLoaded(
        filter: Filter(
          categoryFilters: CategoryFilter.filters,
          priceFilters: PriceFilter.filters,
        ),
      ),
    );
  }

  void _onUpdateCategoryFilter(
    UpdateCategoryFilter event,
    Emitter<FilterState> emit,
  ) {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<CategoryFilter> updatedCategoryFilters =
          state.filter.categoryFilters.map((categoryFilter) {
        return categoryFilter.id == event.categoryFilter.id
            ? event.categoryFilter
            : categoryFilter;
      }).toList();

      var categories = updatedCategoryFilters
          .where((filter) => filter.value)
          .map((filter) => filter.category)
          .toList();
      var prices = state.filter.priceFilters
          .where((filter) => filter.value)
          .map((filter) => filter.price.price)
          .toList();

      List<Restaurant> filteredRestaurants = _getFilteredRestaurants(
        categories,
        prices,
      );

      emit(
        FilterLoaded(
          filter: Filter(
            categoryFilters: updatedCategoryFilters,
            priceFilters: state.filter.priceFilters,
          ),
          filteredRestaurants: filteredRestaurants,
        ),
      );
    }
  }

  void _onUpdatePriceFilter(
    UpdatePriceFilter event,
    Emitter<FilterState> emit,
  ) {
    final state = this.state;
    if (state is FilterLoaded) {
      final List<PriceFilter> updatedPriceFilters =
          state.filter.priceFilters.map((priceFilter) {
        return priceFilter.id == event.priceFilter.id
            ? event.priceFilter
            : priceFilter;
      }).toList();

      var categories = state.filter.categoryFilters
          .where((filter) => filter.value)
          .map((filter) => filter.category)
          .toList();
      var prices = updatedPriceFilters
          .where((filter) => filter.value)
          .map((filter) => filter.price.price)
          .toList();

      List<Restaurant> filteredRestaurants = _getFilteredRestaurants(
        categories,
        prices,
      );

      emit(
        FilterLoaded(
          filter: Filter(
            categoryFilters: state.filter.categoryFilters,
            priceFilters: updatedPriceFilters,
          ),
          filteredRestaurants: filteredRestaurants,
        ),
      );
    }
  }

  List<Restaurant> _getFilteredRestaurants(
    List<Category> categories,
    List<String> prices,
  ) {
    return (_restaurantBloc.state as RestaurantLoaded)
        .restaurants
        .where(
          (restaurant) => categories.any(
            (category) => restaurant.categories.contains(category),
          ),
        )
        .where(
          (restaurant) => prices.any(
            (price) => restaurant.priceCategory.contains(price),
          ),
        )
        .toList();
  }

  // Stream<FilterState> _mapPriceFilterUpdated(
  //   PriceFilterUpdated event,
  //   FilterState state,
  // ) async* {
  //   if (state is FilterLoaded) {
  //     final List<PriceFilter> updatedPriceFilters =
  //         state.filter.priceFilters.map((priceFilter) {
  //       return priceFilter.id == event.priceFilter.id
  //           ? event.priceFilter
  //           : priceFilter;
  //     }).toList();
  //     yield FilterLoaded(
  //       filter: Filter(
  //         categoryFilters: state.filter.categoryFilters,
  //         priceFilters: updatedPriceFilters,
  //       ),
  //     );
  //   }
  // }
}
