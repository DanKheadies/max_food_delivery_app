import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:max_food_delivery_app/repositories/places/places_respository.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/models/models.dart';

part 'place_event.dart';
part 'place_state.dart';

class PlaceBloc extends Bloc<PlaceEvent, PlaceState> {
  final PlacesRepository _placesRepository;
  StreamSubscription? _placesSubscription;

  PlaceBloc({
    required PlacesRepository placesRepository,
  })  : _placesRepository = placesRepository,
        super(PlaceLoading()) {
    on<LoadPlace>(_onLoadPlace);
  }

  void _onLoadPlace(
    LoadPlace event,
    Emitter<PlaceState> emit,
  ) async {
    emit(PlaceLoading());
    try {
      _placesSubscription?.cancel();
      final Place place = await _placesRepository.getPlace(event.placeId);
      emit(
        PlaceLoaded(place: place),
      );
    } catch (_) {}
  }

  @override
  Future<void> close() {
    _placesSubscription?.cancel();
    return super.close();
  }
}
