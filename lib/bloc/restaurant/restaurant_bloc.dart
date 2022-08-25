import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/bloc/blocs.dart';
import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantRepository _restaurantRepository;
  final LocationBloc _locationBloc;
  StreamSubscription? _restaurantSubscription;
  StreamSubscription? _locationSubscription;

  RestaurantBloc({
    required RestaurantRepository restaurantRepository,
    required LocationBloc locationBloc,
  })  : _restaurantRepository = restaurantRepository,
        _locationBloc = locationBloc,
        super(RestaurantLoading()) {
    on<LoadRestaurants>(_onLoadRestaurants);

    _locationSubscription = _locationBloc.stream.listen(
      (state) {
        if (state is LocationLoaded) {
          _restaurantSubscription =
              _restaurantRepository.getNearbyRestaurants(state.place).listen(
                    (restaurants) => add(
                      LoadRestaurants(restaurants),
                    ),
                  );
        }
      },
    );
  }

  void _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<RestaurantState> emit,
  ) {
    emit(RestaurantLoaded(event.restaurants));
  }

  @override
  Future<void> close() async {
    _locationSubscription?.cancel();
    _restaurantSubscription?.cancel();
    super.close();
  }
}
