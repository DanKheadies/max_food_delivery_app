part of 'location_bloc.dart';

@immutable
abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final GoogleMapController? controller;
  final Place place;
  final List<Restaurant>? restaurants;

  const LocationLoaded({
    this.controller,
    required this.place,
    this.restaurants,
  });

  @override
  List<Object?> get props => [
        controller,
        place,
        restaurants,
      ];
}
