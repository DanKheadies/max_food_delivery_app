import 'dart:async';
// import 'dart:html';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/repositories/repositories.dart';

part 'geolocation_event.dart';
part 'geolocation_state.dart';

class GeolocationBloc extends Bloc<GeolocationEvent, GeolocationState> {
  final GeolocationRepository _geolocationRepository;
  StreamSubscription? _geolocationSubscription;

  // GeolocationBloc() : super(GeolocationInitial()) {
  //   on<GeolocationEvent>((event, emit) {
  //     // TODO: implement event handler
  //   });
  // }

  GeolocationBloc({
    required GeolocationRepository geolocationRepository,
  })  : _geolocationRepository = geolocationRepository,
        super(GeolocationLoading()) {
    on<LoadGeolocation>(_onLoadGeolocation);
    on<UpdateGeolocation>(_onUpdateGeolocation);
  }

  // Stream<GeolocationState> mapEventToState(
  //   GeolocationEvent event,
  // ) async* {
  //   if (event is LoadGeolocation) {
  //     yield* _mapLoadGeolocationToState();
  //   } else if (event is UpdateGeolocation) {
  //     yield* _mapUpdateGeolocationToState(event);
  //   }
  // }

  void _onLoadGeolocation(
    LoadGeolocation event,
    Emitter<GeolocationState> emit,
  ) async {
    emit(GeolocationLoading());
    try {
      _geolocationSubscription?.cancel();
      final Position position =
          await _geolocationRepository.getCurrentLocation();
      emit(
        GeolocationLoaded(
          position: position,
        ),
      );
    } catch (_) {}
  }

  // Stream<GeolocationState> _mapLoadGeolocationToState() async* {
  //   _geolocationSubscription?.cancel();
  //   final Position position = await _geolocationRepository.getCurrentLocation();

  //   add(UpdateGeolocation(position: position));
  // }

  void _onUpdateGeolocation(
    UpdateGeolocation event,
    Emitter<GeolocationState> emit,
  ) {
    final state = this.state;
    if (state is GeolocationLoaded) {
      try {
        emit(
          GeolocationLoaded(
            position: event.position,
          ),
        );
      } catch (_) {}
    }
  }

  // Stream<GeolocationState> _mapUpdateGeolocationToState(
  //     UpdateGeolocation event) async* {
  //   yield GeolocationLoaded(position: event.position);
  // }

  @override
  Future<void> close() {
    _geolocationSubscription?.cancel();
    return super.close();
  }
}
