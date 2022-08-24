import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GeolocationRepository _geolocationRepository;
  final LocalStorageRepository _localStorageRepository;
  final PlacesRepository _placesRepository;
  StreamSubscription? _geolocationSubscription;
  StreamSubscription? _placesSubscription;

  LocationBloc({
    required GeolocationRepository geolocationRepository,
    required LocalStorageRepository localStorageRepository,
    required PlacesRepository placesRepository,
  })  : _geolocationRepository = geolocationRepository,
        _localStorageRepository = localStorageRepository,
        _placesRepository = placesRepository,
        super(LocationLoading()) {
    on<LoadMap>(_onLoadMap);
    on<SearchLocation>(_onSearchLocation);
  }

  void _onLoadMap(
    LoadMap event,
    Emitter<LocationState> emit,
  ) async {
    Box box = await _localStorageRepository.openBox();
    Place? place = _localStorageRepository.getPlace(box);

    if (place == null) {
      print('Place is null');

      final Position position =
          await _geolocationRepository.getCurrentLocation();

      emit(
        LocationLoaded(
          controller: event.controller,
          place: Place(
            lat: position.latitude,
            long: position.longitude,
          ),
        ),
      );
    } else {
      emit(
        LocationLoaded(
          controller: event.controller,
          place: place,
        ),
      );
    }
  }

  void _onSearchLocation(
    SearchLocation event,
    Emitter<LocationState> emit,
  ) async {
    final state = this.state as LocationLoaded;
    final Place place = await _placesRepository.getPlace(event.placeId);

    if (place == null) {
      emit(
        LocationLoaded(
          controller: state.controller,
          place: state.place,
        ),
      );
    } else {
      Box box = await _localStorageRepository.openBox();
      _localStorageRepository.clearBox(box);
      _localStorageRepository.addPlace(box, place);

      state.controller!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(
            place.lat,
            place.long,
          ),
        ),
      );

      emit(
        LocationLoaded(
          controller: state.controller,
          place: place,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
