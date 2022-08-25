import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:max_food_delivery_app/models/models.dart';
import 'package:max_food_delivery_app/repositories/repositories.dart';

part 'auto_complete_event.dart';
part 'auto_complete_state.dart';

class AutoCompleteBloc extends Bloc<AutoCompleteEvent, AutoCompleteState> {
  final LocationRepository _locationRepository;

  AutoCompleteBloc({
    required LocationRepository locationRepository,
  })  : _locationRepository = locationRepository,
        super(AutoCompleteLoading()) {
    on<LoadAutoComplete>(_onLoadAutoComplete);
    on<ClearAutoComplete>(_onClearAutoComplete);
  }

  void _onLoadAutoComplete(
    LoadAutoComplete event,
    Emitter<AutoCompleteState> emit,
  ) async {
    final List<Place> autoComplete =
        await _locationRepository.getAutoComplete(event.searchInput);

    emit(
      AutoCompleteLoaded(
        autoComplete: autoComplete,
      ),
    );
  }

  void _onClearAutoComplete(
    ClearAutoComplete event,
    Emitter<AutoCompleteState> emit,
  ) {
    emit(
      AutoCompleteLoaded(
        autoComplete: List.empty(),
      ),
    );
  }
}
