part of 'search_bloc.dart';

@immutable
abstract class SearchState {
  const SearchState();
}

class SearchInitial extends SearchState {
  const SearchInitial();
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchFinished extends SearchState {
  final JishoAPIResult result;

  const SearchFinished(this.result);
}

class SearchError extends SearchState {
  final String message;

  const SearchError(this.message);
}