part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

class GetSearchResults extends SearchEvent {
  final String searchString;
  const GetSearchResults(this.searchString);
}

class ReturnToInitialState extends SearchEvent {
  const ReturnToInitialState();
}