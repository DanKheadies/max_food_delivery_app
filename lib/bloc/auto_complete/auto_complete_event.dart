part of 'auto_complete_bloc.dart';

@immutable
abstract class AutoCompleteEvent extends Equatable {
  const AutoCompleteEvent();

  @override
  List<Object> get props => [];
}

class LoadAutoComplete extends AutoCompleteEvent {
  final String searchInput;

  const LoadAutoComplete({this.searchInput = ''});

  @override
  List<Object> get props => [searchInput];
}
