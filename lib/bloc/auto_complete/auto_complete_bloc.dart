import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

part 'auto_complete_event.dart';
part 'auto_complete_state.dart';

class AutoCompleteBloc extends Bloc<AutoCompleteEvent, AutoCompleteState> {
  final PlacesRepository _placesRespository;
  StreamSubscription? _placesSubscription;

  AutoCompleteBloc({
    required PlacesRepository placesRepository,
  })  : _placesRespository = placesRepository,
        super(AutoCompleteLoading()) {
    on<LoadAutoComplete>(_onLoadAutoComplete);
  }

  void _onLoadAutoComplete(
    LoadAutoComplete event,
    Emitter<AutoCompleteState> emit,
  ) async {
    // print('complete?');
    // emit(AutoCompleteLoading());
    // try {
    //   print('trying');
    // _placesSubscription?.cancel();
    final List<PlaceAutoComplete> autoComplete =
        await _placesRespository.getAutoComplete(event.searchInput);

    emit(
      AutoCompleteLoaded(
        autoComplete: autoComplete,
      ),
    );

    // } catch (_) {
    //   print('caught');
    // }
  }
}
