import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GeolocationRepository _geolocationRepository;
  final LocationRepository _locationRepository;
  final RestaurantRepository _restaurantRepository;
  StreamSubscription? _geolocationSubscription;
  StreamSubscription? _restaurantSubscription;

  LocationBloc({
    required GeolocationRepository geolocationRepository,
    required LocationRepository locationRepository,
    required RestaurantRepository restaurantRepository,
  })  : _geolocationRepository = geolocationRepository,
        _locationRepository = locationRepository,
        _restaurantRepository = restaurantRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    Place? place = await _locationRepository.getPlace();

    if (place == null) {
      final Position position =
          await _geolocationRepository.getCurrentLocation();

      place = Place(
        lat: position.latitude,
        long: position.longitude,
      );
    }

    List<Restaurant> restaurants =
        await _restaurantRepository.getNearbyRestaurants(place).first;

    emit(
      LocationLoaded(
        controller: event.controller,
        place: place,
        restaurants: restaurants,
      ),
    );
  }

  void _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    final state = this.state as LocationLoaded;
    final Place place =
        await _locationRepository.getPlace(event.placeId) ?? Place.empty;

    state.controller!.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(
          place.lat,
          place.long,
        ),
      ),
    );

    List<Restaurant> restaurants =
        await _restaurantRepository.getNearbyRestaurants(place).first;

    emit(
      LocationLoaded(
        controller: state.controller,
        place: place,
        restaurants: restaurants,
      ),
    );
  }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    _restaurantSubscription?.cancel();
    return super.close();
  }
}
