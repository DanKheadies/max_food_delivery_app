part of 'auto_complete_bloc.dart';

@immutable
abstract class AutoCompleteState extends Equatable {
  const AutoCompleteState();

  @override
  List<Object> get props => [];
}

class AutoCompleteLoading extends AutoCompleteState {}

class AutoCompleteLoaded extends AutoCompleteState {
  final List<Place> autoComplete;

  const AutoCompleteLoaded({
    required this.autoComplete,
  });

  @override
  List<Object> get props => [autoComplete];
}

class AutoCompleteError extends AutoCompleteState {}
