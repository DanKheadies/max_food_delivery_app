part of 'geolocation_bloc.dart';

@immutable
abstract class GeolocationState extends Equatable {
  const GeolocationState();

  @override
  List<Object?> get props => [];
}

class GeolocationLoading extends GeolocationState {}

class GeolocationLoaded extends GeolocationState {
  final Position position;

  const GeolocationLoaded({required this.position});

  @override
  List<Object?> get props => [position];
}
