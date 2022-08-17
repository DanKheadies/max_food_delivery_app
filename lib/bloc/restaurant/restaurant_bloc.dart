import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/models/models.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _restaurantSubscription;

  RestaurantBloc({
    required RestaurantRepository restaurantRepository,
  })  : _restaurantRepository = restaurantRepository,
        super(RestaurantLoading()) {
    on<LoadRestaurants>(_onLoadRestaurants);

    _restaurantSubscription = _restaurantRepository
        .getRestaurant()
        .listen((restaurants) => add(LoadRestaurants(restaurants)));
  }

  void _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) {
    emit(RestaurantLoaded(event.restaurants));
  }

  @override
  Future<void> close() async {
    _restaurantSubscription?.cancel();
    super.close();
  }
}
